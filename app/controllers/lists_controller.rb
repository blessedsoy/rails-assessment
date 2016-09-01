class ListsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    if !current_user
      redirect_to new_user_session_path
    else
      if params[:sample_sales_ids] || current_user.lists
        if params[:sample_sales_ids]
          @lists = List.create_from_sample_sales(current_user.id, params[:sample_sales_ids]) 
        else
          @lists = current_user.lists 
        end
        redirect_to lists_path
      else
        redirect_to sample_sales_path 
      end
    end
  end

  def index
    @lists = current_user.lists if current_user.lists
    @memo ? @memo : Memo.new
  end

  def show
    @list = List.find(params[:id])
  end

  def destroy
    List.delete(params[:id])
    redirect_to lists_path
  end

  def sort_by_dates
    @lists = current_user.lists.sort do |a, b|
      a.sample_sale.dates <=> b.sample_sale.dates
    end
    render '/lists/index'
  end
  
  private

    def list_params
      params.require(:list).permit(:user_id, sample_sales_ids:[])
    end

end
