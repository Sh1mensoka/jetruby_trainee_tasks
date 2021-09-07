class MailNewOrderJob < ApplicationJob
  queue_as :default

  def perform(params)
    OrderMailer.new_order_email(params).deliver_now
  end
end
