require_relative 'price_calculator'
require_relative 'distance_calculator_proxy'
require_relative './api_files/mapbox_calculator'
require_relative './api_files/bing_calculator'
require_relative './api_files/distancematrix_calculator'

class OrderCreator
  def self.create_order(params)
    return unless Module.const_get(params[:selected_api]).is_a?(Class)
    calculator = Kernel.const_get(params[:selected_api]).new(params[:dep_address],
                                                             params[:arr_address]
                                                            )
    distance = DistanceCalculatorProxy.calculate_distance(calculator)
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
