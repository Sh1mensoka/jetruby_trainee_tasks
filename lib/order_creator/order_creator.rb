require_relative 'price_calculator'
require_relative 'distance_calculator_proxy'
require_relative './api_files/mapbox_calculator'
require_relative './api_files/bing_calculator'
require_relative './api_files/distancematrix_calculator'

class OrderCreator
  def self.create_order(params, api_type)
    return unless Module.const_get(api_type).is_a?(Class)
    distance = DistanceCalculatorProxy.calculate_distance(Kernel.const_get(api_type).new(params[:dep_address],
                                                                                         params[:arr_address]
                                                                                        ))
    {weight: params[:weight].to_f, 
     length: params[:length].to_f, 
     width: params[:width].to_f, 
     height: params[:height].to_f, 
     distance: distance, 
     price: PriceCalculator.calculate_price(params[:weight].to_f, 
     	                                      params[:length].to_f / 100, 
     	                                      params[:width].to_f / 100, 
     	                                      params[:height].to_f / 100, 
     	                                      distance.to_f
                                           )
    }
  end
end
