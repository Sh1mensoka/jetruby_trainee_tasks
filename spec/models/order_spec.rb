require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:org) { FactoryBot.create(:organisation, :foo) }
  let!(:user) { FactoryBot.create(:user, organisation_id: org.id) }
  
  describe '.create' do 
    let(:order) { FactoryBot.create(:order, user_id: user.id) }
    
    it "order has 'accepted' status by default" do
      expect(order).to have_attributes(status: 'accepted')
    end
  end

  describe '.process' do
    let(:order) { FactoryBot.create(:order, user_id: user.id)}
    
    context "successfully change status to 'processing'" do
      it "from 'accepted'" do
        order.process
        expect(order).to have_attributes(status: 'processing')
      end
    end
  end

  describe '.deliver' do
    let(:order) { FactoryBot.create(:order, user_id: user.id, status: 'processing')}
    
    context "successfully change status to 'sent'" do
      it "from 'processing'" do
        order.deliver
        expect(order).to have_attributes(status: 'sent')
      end
    end
  end

  describe '.confirm_delivery' do
    let(:order) { FactoryBot.create(:order, user_id: user.id, status: 'sent')}
    
    context "successfully change status to 'delivered'" do
      it "from 'sent'" do
        order.confirm_delivery
        expect(order).to have_attributes(status: 'delivered')
      end
    end
  end

  describe '.cancel' do
    context "successfully change status to 'cancelled'" do
      let(:order1) { FactoryBot.create(:order, user_id: user.id) }
      let(:order2) { FactoryBot.create(:order, user_id: user.id, status: 'processing') }
      
      it "from 'accepted'" do
        order1.cancel
        expect(order1).to have_attributes(status: 'cancelled')
      end

      it "from 'processing'" do
        order2.cancel
        expect(order2).to have_attributes(status: 'cancelled')
      end
    end
  end
end
