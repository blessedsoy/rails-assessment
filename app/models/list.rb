class List < ApplicationRecord
  belongs_to :user
  belongs_to :sample_sale
  has_one :memo
  has_many :sample_sale_lists
  has_many :sample_sales, through: :sample_sale_lists

  def self.create_from_sample_sales(user_id, ids)
    ids.map do |id|
      List.find_or_create_by(user_id: user_id, sample_sale_id: id)
    end
  end

end

