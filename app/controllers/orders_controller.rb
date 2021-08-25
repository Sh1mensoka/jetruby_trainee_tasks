require_relative '../../lib/order_creator/order_creator'

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
  end

  def create
    selected_api = Api.find_by(status: 1)[:name]
    additional_params = OrderCreator.create_order(order_params, selected_api)
    @order = current_user.orders.build(order_params.merge(additional_params))
    @order.accept if @order.may_accept?
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:name,
                                    :s_name,
                                    :patronymic,
                                    :phone,
                                    :email,
                                    :weight,
                                    :length,
                                    :width,
                                    :height,
                                    :dep_address,
                                    :arr_address)
    end
end
