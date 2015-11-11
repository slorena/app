class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :feed_id
      t.string :title
      t.decimal :price
      t.string :campaign
      t.string :description

      t.timestamps null: false
    end
  end
end
