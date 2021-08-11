gem 'minitest'
require 'minitest/autorun'
require_relative '../price_calculator'

describe PriceCalculator do
  describe '.calculate_price' do
    it 'works only with numbers' do
      assert_raises(TypeError) {PriceCalculator.calculate_price('a', 'b', 'c', 'd', 'e')}
    end

    it 'correct for < 1 m^3' do
      assert_equal(1, PriceCalculator.calculate_price(12, 0.9, 0.9, 0.9, 1))
    end

    it 'correct for 1 m^3' do
      assert_equal(1, PriceCalculator.calculate_price(12, 1, 1, 1, 1))
    end

    it 'correct for > 1 m^3 and < 10 kg' do
      assert_equal(2, PriceCalculator.calculate_price(8, 1.2, 1, 1, 1))
    end

    it 'correct for > 1 m^3 and 10 kg' do
      assert_equal(2, PriceCalculator.calculate_price(10, 1.2, 1, 1, 1))
    end

    it 'correct for > 1 m^3 and > 10 kg' do
      assert_equal(3, PriceCalculator.calculate_price(12, 1.2, 1, 1, 1))
    end
  end
end
