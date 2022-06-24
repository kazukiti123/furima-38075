class ItemsController < ApplicationController
before_action :authenticate_user!, only: [:new, :edit, :destroy]
before_action :item_set, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless current_user == @item.user
      redirect_to root_path
    end
  
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit( :name, :explanation, :price, :states_id, :postage_id, :prefecture_id, :send_time_id, :category_id, :image).merge(user_id: current_user.id)
  end

  def item_set
    @item = Item.find(params[:id])
  end

end
