require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  let(:user) { User.first }
  describe "GET action" do
    context "when logged in" do
      it "responds with 200" do
        sign_in(user)
        get root_path
        expect(response.status).to eq(200)
      end
    end

    context "when not logged in" do
      it "redirects to authorization page" do
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    let(:order) { FactoryBot.build(:order, user: user) }

    context "after submit" do
      it "redirects to #index" do
        sign_in(user)
        post orders_path, params: { order: order.attributes }
        expect(response).to redirect_to(orders_path)
      end
    end
  end
end
