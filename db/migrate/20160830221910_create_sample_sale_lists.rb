class CreateSampleSaleLists < ActiveRecord::Migration[5.0]
  def change
    create_table :sample_sale_lists do |t|
      t.integer :sample_sale_id
      t.integer :list_id

      t.timestamps
    end
  end
end
