require "uri"
require "json"
require "net/http"

class MapboxCalculator
  attr_accessor :dep_address, :arr_address

  def initialize(dep_address, arr_address)
    @dep_address = dep_address
    @arr_address = arr_address
  end

  def calculate_distance
    api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['MapboxCalculator']

    coords = {dep_coords: JSON.parse(Net::HTTP.get(URI(format(api_data['mapbox_geocoding_uri'], 
                                                              {address: dep_address, 
                                                               token: api_data['mapbox_token']
                                                              }
                                                             ))))['features'][0]['center'],
              arr_coords: JSON.parse(Net::HTTP.get(URI(format(api_data['mapbox_geocoding_uri'], 
                                                              {address: arr_address, 
                                                               token: api_data['mapbox_token']
                                                              }
                                                             ))))['features'][0]['center']}

    JSON.parse(Net::HTTP.get(URI(format(api_data['mapbox_directions_uri'], 
                                        {dep_longitude: coords[:dep_coords][0], 
                                         dep_latitude: coords[:dep_coords][1], 
                                         arr_longitude: coords[:arr_coords][0], 
                                         arr_latitude: coords[:arr_coords][1], 
                                         token: api_data['mapbox_token']
                                        }
                                       ))))['routes'][0]['distance'] / 1000
  end
end
