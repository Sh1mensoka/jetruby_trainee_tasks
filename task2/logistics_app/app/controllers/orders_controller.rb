require_relative '../../lib/order_creator/order_creator'

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    selected_api = Api.find_by(status: 1)[:name]
    additional_params = OrderCreator.create_order(order_params, selected_api)
    @order = Order.new(order_params.merge(additional_params))
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
