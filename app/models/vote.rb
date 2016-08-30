class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :sample_sale
end
