class Item < ApplicationRecord
  belongs_to :batch

  validates :name, :quantity, presence: true

  trigger.after(:insert, :update) do
    <<-SQL
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: create_or_update, record_id: ' || COALESCE(NEW.id, 0) || '}');
      RETURN NEW;
    SQL
  end

  trigger.after(:delete) do
    <<-SQL
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: delete, record_id: ' || COALESCE(OLD.id, 0) || '}');
      RETURN OLD;
    SQL
  end

  def self.listen
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)

      begin
        conn.async_exec "LISTEN change_record"
        loop do
          conn.wait_for_notify do |channel, pid, payload|
            puts "Received NOTIFY on channel #{channel} with payload: #{payload}, pid: #{pid}"
            payload = Hash[ payload.gsub!(/[{}"]/,'').scan(/(\w+):\s+([^,]+)/) ]
            DbTriggerJob.perform_async(payload['record_id'])
          end
        end
      ensure
        conn.async_exec "UNLISTEN *"
      end
    end
  end
end
