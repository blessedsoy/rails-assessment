class SampleSale < ApplicationRecord
  has_many :sample_sale_lists
  has_many :lists, through: :sample_sale_lists
  has_many :users, through: :lists
  has_many :votes
  
  def self.of_the_week
    sales_of_the_week = []
    SampleSale.all.collect do |s|
      s.dates.gsub!('/','-')
      # start_date = '2016-'+ s.dates[0..4]
      end_date = '2016-' + s.dates[-5..-1]   
      sales_of_the_week << s if Date.parse(end_date) >= Date.today && Date.parse(end_date) < (Date.today + 7.days)  
    end
    sales_of_the_week
  end

  # def added_to_list?(id)
  #   List.find_by(sample_sale_id: self.id, user_id: id)
  # end

  def total_likes
    self.votes.inject(0){|sum, v| sum + v.like }
  end

  def total_dislikes
    self.votes.inject(0){|sum, v| sum + v.dislike }
  end

  def current_like(id)
    @vote = self.votes.find_by(user_id: id)
    @vote ? @vote.like : 0
  end

  def current_dislike(id)
    @vote = self.votes.find_by(user_id: id)
    @vote ? @vote.dislike : 0
  end

  def self.sort_by_likes
    SampleSale.all.sort do |a, b|
      b.total_likes <=> a.total_likes
    end
  end

  def is_not_in_lists_of(current_user)
    !current_user || !(current_user.lists.any?{|x| x.sample_sale == self})
  end

end
