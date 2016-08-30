class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :sample_sale_id
      t.integer :user_id
      t.integer :like, :default => 0
      t.integer :dislike, :default => 0

      t.timestamps
    end
  end
end
