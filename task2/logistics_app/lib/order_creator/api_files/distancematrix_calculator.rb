require "uri"
require "json"
require "net/http"

class DistanceMatrixCalculator
  attr_accessor :dep_address, :arr_address

  def initialize(dep_address, arr_address)
    @dep_address = dep_address
    @arr_address = arr_address
  end

  def calculate_distance
    api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['DistanceMatrixCalculator']

    JSON.parse(Net::HTTP.get(URI(format(api_data['distancematrix_uri'],
                                        {dep_address: dep_address, 
                                         arr_address: arr_address, 
                                         token: api_data['distancematrix_token']
                                        }
                                       ))))['rows'][0]['elements'][0]['distance']['value'] / 1000
  end
end
