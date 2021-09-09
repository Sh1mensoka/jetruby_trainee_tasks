class Order < ApplicationRecord
  after_create :send_new_order_email

  include AASM
  aasm column: 'status' do
    state :accepted, initial: true
    state :processing, :sent, :delivered, :cancelled

    event :process do
      transitions from: :accepted, to: :processing, success: Proc.new { send_update_status_email(state: aasm.to_state) }
    end

    event :deliver do
      transitions from: :processing, to: :sent, success: Proc.new { send_update_status_email(state: aasm.to_state) }
    end

    event :confirm_delivery do
      transitions from: :sent, to: :delivered, success: Proc.new { send_update_status_email(state: aasm.to_state) }
    end

    event :cancel do
      transitions from: [:accepted, :processing], to: :cancelled, success: Proc.new { send_update_status_email(state: aasm.to_state) }
    end
  end

  belongs_to :user

  private

  def send_update_status_email(params)
    MailOrderStatusUpdateJob.perform_later(params.merge(order: self))
  end

  def send_new_order_email
    MailNewOrderJob.perform_later(order: self)
  end
end
