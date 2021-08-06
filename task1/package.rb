require_relative 'price_calculator'
require_relative 'distance_calculator'

class Package
  include DistanceCalculator
  attr_accessor :proxy

  def initialize
    @proxy = DistanceCalculator::DistanceCalculatorProxy.new
  end

  def create_package(weight, length, width, height, dep_address, arr_address, api_type)
    return unless proxy.list_of_apis.include?(api_type)
    distance = proxy.calculate_distance(DistanceCalculator::MapboxCalculator.new(dep_address, arr_address)) if api_type == 'mapbox'
    distance = proxy.calculate_distance(DistanceCalculator::BingCalculator.new(dep_address, arr_address)) if api_type == 'bing'
    distance = proxy.calculate_distance(DistanceCalculator::DistanceMatrixCalculator.new(dep_address, arr_address)) if api_type == 'distancematrix'
    {weight: weight, 
     length: length, 
     width: width, 
     height: height, 
     distance: distance, 
     price: PriceCalculator.calculate_price(weight.to_f, 
     	                                      length.to_f / 100, 
     	                                      width.to_f / 100, 
     	                                      height.to_f / 100, 
     	                                      distance
                                           )
    }
  end
end
