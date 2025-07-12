class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_user

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_shipping_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_user
    redirect_to root_path if @item.user_id == current_user.id || @item.order.present?
  end

  def order_shipping_params
    params.require(:order_shipping).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:order_shipping][:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_shipping_params[:token],
      currency: 'jpy'
    )
  end
end
