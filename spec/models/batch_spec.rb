require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'Associations' do
    it { should have_many(:items) }
  end

  describe 'Validations' do
    subject { create(:batch) }

    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:customer_name) }
    it { should validate_uniqueness_of(:customer_id) }
  end
end
