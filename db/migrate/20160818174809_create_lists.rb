class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :sample_sale_id

      t.timestamps
    end
  end
end
