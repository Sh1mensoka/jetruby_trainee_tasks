require_relative 'price_calculator'
require_relative 'distance_calculator_proxy'
require_relative './api_files/mapbox_calculator'
require_relative './api_files/bing_calculator'
require_relative './api_files/distancematrix_calculator'

class Package
  attr_accessor :proxy

  def initialize
    @proxy = DistanceCalculatorProxy.new
  end

  def create_package(weight, length, width, height, dep_address, arr_address, api_type)
    return unless Module.const_get(api_type).is_a?(Class)
    distance = proxy.calculate_distance(Kernel.const_get(api_type).new(dep_address, arr_address))
    {weight: weight, 
     length: length, 
     width: width, 
     height: height, 
     distance: distance, 
     price: PriceCalculator.calculate_price(weight, 
     	                                      length.to_f / 100, 
     	                                      width.to_f / 100, 
     	                                      height.to_f / 100, 
     	                                      distance
                                           )
    }
  end
end
