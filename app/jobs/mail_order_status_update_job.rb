class MailOrderStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(params)
    OrderMailer.update_status_email(params).deliver_now
  end
end
