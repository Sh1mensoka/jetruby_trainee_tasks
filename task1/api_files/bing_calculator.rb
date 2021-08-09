require "uri"
require "json"
require "net/http"

class BingCalculator
  attr_accessor :dep_address, :arr_address

  def initialize(dep_address, arr_address)
    @dep_address = dep_address
    @arr_address = arr_address
  end

  def calculate_distance
    api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['BingCalculator']

    JSON.parse(Net::HTTP.get(URI(format(api_data['bing_uri'],
                                        {dep_address: dep_address, 
                                         arr_address: arr_address, 
                                         token: api_data['bing_token']
                                        }
                                       ))))['resourceSets'][0]['resources'][0]['travelDistance']
  end
end
