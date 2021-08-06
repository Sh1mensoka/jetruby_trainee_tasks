gem 'minitest'
gem 'vcr'
require 'minitest/autorun'
require 'vcr'
require_relative '../package.rb'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

describe Package do
  before do
    @package = Package.new
  end

  describe '#create_package' do
    it 'works only with existent apis' do
      _(@package.create_package(12, 100, 100, 100, 'Moscow', 'Krasnodar', 'google')).must_be_nil
    end

    it 'returns hash' do
      VCR.insert_cassette 'mapbox_moscow_krasnodar'
      _(@package.create_package(12, 100, 100, 100, 'Moscow', 'Krasnodar', 'mapbox')).must_be_instance_of(Hash)
      VCR.eject_cassette
    end
  end
end
