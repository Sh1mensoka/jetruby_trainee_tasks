require_relative '../../lib/order_creator/order_creator'

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
  end

  def create
    selected_api = Api.find_by(is_on: true)[:name]
    additional_params = OrderCreator.create_order(order_params.merge(selected_api: selected_api))
    @order = current_user.orders.create(order_params.merge(additional_params))
    if @order.save 
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Orders::GridQuery.call(params.merge(current_user: current_user))
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
                                    :arr_address,
                                    :status)
    end
end
