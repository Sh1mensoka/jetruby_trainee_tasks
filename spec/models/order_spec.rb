require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.first }

  context "new record" do
    let(:order) { FactoryBot.create(:order, user: user) }

    it "has status accepted by default" do
      expect(order.status).to eq("accepted")
    end
  end

  context "successfully transitions" do
    it "from accepted to processing" do
      order = FactoryBot.create(:order, user: user)
      order.process
      expect(order.status).to eq("processing")
    end

    it "from processing to sent" do
      order = FactoryBot.create(:order, user: user, status: 'processing')
      order.deliver
      expect(order.status).to eq("sent")
    end

    it "from sent to delivered" do
      order = FactoryBot.create(:order, user: user, status: 'sent')
      order.confirm_delivery
      expect(order.status).to eq("delivered")
    end
  end
end
