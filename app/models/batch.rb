class Batch < ApplicationRecord
	has_many :items

  validates :customer_id, :customer_name, presence: true
  validates :customer_id, uniqueness: true
end

