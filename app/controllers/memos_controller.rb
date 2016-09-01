class MemosController < ApplicationController
  
  def create
    @memo = Memo.create(memo_params)
      redirect_to lists_path
  end

  def update
    @memo = Memo.find_by(id: params[:memo][:id], list_id: params[:memo][:list_id])
    @memo.update(memo_params)
    redirect_to lists_path
  end

  def destroy
    @memo = Memo.find_by(id: params[:id])
    list = List.find_by(id: @memo.list_id)
    list.memo.destroy
    @memo.destroy
    redirect_to lists_path
  end

  private

    def memo_params
      params.require(:memo).permit(:id, :content, :list_id)
    end

end
