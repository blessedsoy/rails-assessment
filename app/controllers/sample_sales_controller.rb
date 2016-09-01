class SampleSalesController < ApplicationController
  def index
    @sample_sales = SampleSale.all 
    @list = List.new
  end

  def show
    if current_user
      @sample_sale = SampleSale.find(params[:id])
    else
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end

  # def add_to_list
  #   if !current_user
  #     redirect_to new_user_session_path
  #   else
  #     if params[:sample_sales_ids] || current_user.lists
  #       if params[:sample_sales_ids]
  #         @list = List.create_from_sample_sales(current_user.id, params[:sample_sales_ids]) 
  #       else
  #         @list = current_user.lists 
  #       end
  #       redirect_to lists_path
  #     else
  #       redirect_to sample_sales_path 
  #     end
  #   end
  # end

  def sort_by_likes
    @sample_sales = SampleSale.sort_by_likes
    @list = List.new
    render '/sample_sales/index'
  end

  def like
    if current_user
      get_vote

      if @vote.like == 0 && @vote.dislike != -1
        @vote.like += 1
      elsif @vote.like == 1 
        @vote.like -= 1 
      end
      @vote.save

      redirect_to sample_sales_path
    else 
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end

  def dislike
    if current_user
      get_vote
      
      if @vote.dislike == 0 && @vote.like != 1
        @vote.dislike -= 1 
      elsif @vote.dislike == -1 
        @vote.dislike += 1  
      end
      @vote.save

      redirect_to sample_sales_path
    else
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end

  end

private

  def get_vote
    sample_sale = SampleSale.find(params[:sample_sale])
    @vote = sample_sale.votes.find_by(user_id: current_user.id)
    unless @vote
      @vote = Vote.create(sample_sale_id: sample_sale.id, user_id: current_user.id)
      sample_sale.votes << @vote
    end
  end


end
