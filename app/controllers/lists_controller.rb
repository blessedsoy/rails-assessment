class ListsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @list = List.create_or_find_by(list_params)
  end

  def index
    @lists = current_user.lists if current_user.lists
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
      params.require(:list).permit(:user_id, sample_sale_ids:[])
    end

end
