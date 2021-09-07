class OrderMailer < ApplicationMailer
  def update_status_email(params)
    @order = params[:order]
    @state = params[:state]
    mail(to: @order.email, subject: "Your order's status has been changed")
  end

  def new_order_email(params)
    @order = params[:order]
    mail(to: @order.email, subject: "Your order has been created")
  end
end
