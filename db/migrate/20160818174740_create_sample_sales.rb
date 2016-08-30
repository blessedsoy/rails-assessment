class CreateSampleSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sample_sales do |t|
      t.string :brand
      t.text :about
      t.string :dates
      t.string :hours
      t.string :address

      t.timestamps
    end
  end
end
