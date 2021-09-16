require 'rails_helper'

RSpec.describe Users::BaseQuery do
  let!(:org1) { FactoryBot.create(:organisation, :foo) }
  let!(:admin1) { FactoryBot.create(:user, :org_admin, organisation_id: org1.id, email: 'admin1@example.com') }
  let!(:operator1) { FactoryBot.create(:user, :operator, organisation_id: org1.id, email: 'operator1@example.com') }

  describe '.base_relation' do
  	context 'if user is organisation admin' do
      let(:relation) { Users::BaseQuery.call(current_user: admin1) }
      it 'returns relation with operator(s)' do
      	expect(relation).to be_a(ActiveRecord::Relation)
        expect(relation).to match_array(User.where(organisation_id: admin1.organisation_id, role: 'operator'))
      end
    end

    context 'if user is operator' do
      let(:relation) { Users::BaseQuery.call(current_user: operator1) }
      it 'returns empty relation' do
        expect(relation).to be_a(ActiveRecord::Relation)
        expect(relation).to match_array(User.none)
      end    
    end
  end
end
