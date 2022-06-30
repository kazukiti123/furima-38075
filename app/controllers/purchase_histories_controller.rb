class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @item = Item.find(params[:item_id])
    if current_user.id != @item.user.id && @item.purchase_history.blank?
      @order = Order.new
    else
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order  = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.create
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
