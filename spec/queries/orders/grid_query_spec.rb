require 'rails_helper'

RSpec.describe Orders::GridQuery do
  let!(:org) { FactoryBot.create(:organisation, :foo) }
  let!(:admin) { FactoryBot.create(:user, :org_admin, organisation_id: org.id, email: 'admin1@example.com') }
  let!(:operator) { FactoryBot.create(:user, :operator, organisation_id: org.id, email: 'operator1@example.com') }
  let!(:order) { FactoryBot.create(:order, user_id: operator.id) }

  describe '.execute' do
  	context 'if user is admin' do
      let(:relation) { Orders::GridQuery.call({current_user: admin, operator: operator.id}) }

      it 'returns relation with orders related to operators in organisation' do
      	expect(relation).to be_a(ActiveRecord::Relation)
        expect(relation).to match_array(Order.joins(:user).where(user: {organisation_id: admin.organisation_id}))
      end
    end

    context "if user is operator" do
      let(:relation) { Orders::GridQuery.call(current_user: operator) }

      it 'returns relation with orders related to operator' do
        expect(relation).to be_a(ActiveRecord::Relation)
        expect(relation).to match_array(operator.orders)
      end
    end
  end
end
