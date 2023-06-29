class DbTriggerJob
  include Sidekiq::Job

  def perform(record_id)
    item = Item.find_by(id: record_id)
    item.batch.touch if item.persisted?
    puts "Batch updated"
  end
end
