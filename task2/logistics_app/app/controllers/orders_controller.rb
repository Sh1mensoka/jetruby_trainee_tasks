require_relative '../../lib/order_creator/order_creator'

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    new_params = order_params
    new_params = new_params.merge(OrderCreator.new.create_order(new_params, "MapboxCalculator"))
    @order = Order.new(new_params)
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
