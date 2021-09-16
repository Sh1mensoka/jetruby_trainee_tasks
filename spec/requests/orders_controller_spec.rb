require 'rails_helper'

RSpec.describe "OrdersController", type: :request do
  let!(:org) { FactoryBot.create(:organisation, :foo) }
  let!(:user) { FactoryBot.create(:user, organisation: org) }
  subject { get orders_path }

  describe 'Any GET action' do
    context "when logged in" do    
      it "responds with 200" do
        sign_in(user)
        expect(subject).to eq(200)
      end
    end

    context "when not logged in" do
      it "redirects to authorization page" do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /index" do 
    it "renders index template" do
      sign_in(user)
      expect(subject).to render_template(:index)
    end
  end

  describe "POST /create" do
    let(:order) { FactoryBot.build(:order, user: user) }
    let!(:api) { FactoryBot.create(:api, :bing, :on) }

    context "after submit" do
      it "redirects to #index" do
        sign_in(user)
        post orders_path, params: { order: order.attributes }
        expect(response).to redirect_to(orders_path)
      end
    end
  end
end
