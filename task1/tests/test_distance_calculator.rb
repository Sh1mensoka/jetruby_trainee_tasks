gem 'minitest'
gem 'vcr'
require 'minitest/autorun'
require 'vcr'
require_relative '../distance_calculator'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

describe DistanceCalculator::MapboxCalculator do
  after do
    VCR.eject_cassette
  end

  describe '#calculate_distance' do
    it 'returns float' do
      VCR.insert_cassette 'mapbox_moscow_krasnodar'
      _(DistanceCalculator::MapboxCalculator.new('Moscow', 'Krasnodar').calculate_distance).must_be_instance_of(Float)
    end

    it 'works with non-string values' do
      VCR.insert_cassette 'mapbox_non_string__input'
      _(DistanceCalculator::MapboxCalculator.new(12, 24).calculate_distance).must_be_instance_of(Float)
    end
  end
end

describe DistanceCalculator::BingCalculator do
  after do
    VCR.eject_cassette
  end

  describe '#calculate_distance' do
    it 'returns float' do
      VCR.insert_cassette 'bing_moscow_krasnodar'
      _(DistanceCalculator::BingCalculator.new('Moscow', 'Krasnodar').calculate_distance).must_be_instance_of(Float)
    end

    it 'raises exception with non-string values' do
      VCR.insert_cassette 'bing_non_string_input'
      assert_raises(NoMethodError) {_(DistanceCalculator::BingCalculator.new(12, 24).calculate_distance)}
    end
  end
end

describe DistanceCalculator::DistanceMatrixCalculator do
  after do
    VCR.eject_cassette
  end

  describe '#calculate_distance' do
    it 'returns float' do
      VCR.insert_cassette 'distancematrix_moscow_krasnodar'
      _(DistanceCalculator::DistanceMatrixCalculator.new('Moscow', 'Krasnodar').calculate_distance).must_be_instance_of(Float)
    end

    it 'works with non-string values' do
      VCR.insert_cassette 'distancematrix_non_string_input'
      _(DistanceCalculator::DistanceMatrixCalculator.new(12, 24).calculate_distance).must_be_instance_of(Float)
    end
  end
end
