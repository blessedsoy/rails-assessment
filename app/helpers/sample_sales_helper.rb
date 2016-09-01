module SampleSalesHelper

  def checked?(user, sample_sale)
    user && sample_sale.added_to_list?(user) ? true : false
  end
end
