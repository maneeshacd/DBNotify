class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.belongs_to :batch, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
