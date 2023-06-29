require 'rails_helper'

RSpec.describe DbTriggerJob, type: :worker do
  let(:batch) { create(:batch) }

  context 'success' do
    let(:item) { create(:item, batch_id: batch.id) }

    it 'update corresponding batch' do
      batch_updated_at = batch.updated_at.to_f
      Sidekiq::Testing.inline!
      described_class.perform_async(item.id)
      new_updated_at = batch.reload.updated_at.to_f
      expect(batch_updated_at).not_to eq (new_updated_at)
    end
  end
end
