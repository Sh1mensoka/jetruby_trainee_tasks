require 'rails_helper'
require_relative '../../lib/order_creator/order_creator'

RSpec.describe OrderCreator do
  describe ".create_order" do
  	let(:user) { User.first }
    let(:order) { FactoryBot.build(:order, 
                                   dep_address: 'Moscow',
                                   arr_address: 'Krasnodar',
                                   user: user
                                  ) }
    let(:api) { Api.find_by(is_on: true)[:name] }
    
    it 'returns hash' do
      result = OrderCreator.create_order(order.attributes.merge(selected_api: api))
      expect(result).to be_a(Hash)
    end
  end
end