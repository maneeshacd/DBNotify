require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { should belong_to(:batch) }
  end

  describe 'Validations' do
    subject { create(:item) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'listen to DB trigger' do
    it 'listen' do
      allow_any_instance_of(PG::Connection).to receive(:wait_for_notify).and_return(true)
      block_executed = false
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        conn = connection.instance_variable_get(:@connection)
        block_executed = true
        conn.wait_for_notify do |channel, pid, payload|
        end
      end
      expect(block_executed).to eq true
    end
  end
end
