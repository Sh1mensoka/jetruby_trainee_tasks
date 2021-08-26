class Order < ApplicationRecord
  include AASM

  aasm :column => 'status' do
    state :waiting, initial: true
    state :accepted, :processing, :sent, :delivered, :cancelled

    event :accept do
      transitions from: :waiting, to: :accepted
    end

    event :process do
      transitions from: :accepted, to: :processing
    end

    event :deliver do
      transitions from: :processing, to: :sent
    end

    event :confirm_delivery do
      transitions from: :sent, to: :delivered
    end

    event :cancel do
      transitions from: [:waiting, :accepted, :processing], to: :cancelled
    end
  end
  
  belongs_to :user
end
