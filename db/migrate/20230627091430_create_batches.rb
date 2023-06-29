class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.integer :customer_id, uniq: true, null: false
      t.string :customer_name, null: false
      t.timestamps
    end
  end
end
