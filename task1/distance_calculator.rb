require "uri"
require "json"
require "net/http"

module DistanceCalculator
  class DistanceCalculatorInterface
    def calculate_distance
      raise NotImplementedError, "#{self.class} has no #{__method__} method"
    end
  end

  class DistanceCalculatorProxy < DistanceCalculatorInterface
    attr_accessor :cache, :list_of_apis

    def initialize
      @cache = {}
      @list_of_apis = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json")).keys
    end

    def calculate_distance(calculator)
      key = format("%<dep_address>s-%<arr_address>s", 
                   {dep_address: calculator.dep_address, arr_address: calculator.arr_address})

      key_invert = format("%<dep_address>s-%<arr_address>s", 
                          {dep_address: calculator.arr_address, arr_address: calculator.dep_address})

      cache.store(key, calculator.calculate_distance) unless cache.has_key?(key) || cache.has_key?(key_invert)

      cache[key]
    end
  end

  class MapboxCalculator < DistanceCalculatorInterface
    attr_accessor :dep_address, :arr_address

    def initialize(dep_address, arr_address)
      @dep_address = dep_address
      @arr_address = arr_address
    end

    def calculate_distance
      api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['mapbox']

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

      distance = JSON.parse(Net::HTTP.get(URI(format(api_data['mapbox_directions_uri'], 
                                                     {dep_longitude: coords[:dep_coords][0], 
                                                      dep_latitude: coords[:dep_coords][1], 
                                                      arr_longitude: coords[:arr_coords][0], 
                                                      arr_latitude: coords[:arr_coords][1], 
                                                      token: api_data['mapbox_token']
                                                     }
                                                    ))))['routes'][0]['distance'].to_f / 1000
    end
  end

  class BingCalculator < DistanceCalculatorInterface
    attr_accessor :dep_address, :arr_address

    def initialize(dep_address, arr_address)
      @dep_address = dep_address
      @arr_address = arr_address
    end

    def calculate_distance
      api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['bing']

      distance = JSON.parse(Net::HTTP.get(URI(format(api_data['bing_uri'],
                                                     {dep_address: dep_address, 
                                                     	arr_address: arr_address,
                                                     	token: api_data['bing_token']
                                                     }
                                                    ))))['resourceSets'][0]['resources'][0]['travelDistance'].to_f
    end
  end

  class DistanceMatrixCalculator < DistanceCalculatorInterface
    attr_accessor :dep_address, :arr_address

    def initialize(dep_address, arr_address)
      @dep_address = dep_address
      @arr_address = arr_address
    end

    def calculate_distance
      api_data = JSON.parse(File.read("#{File.dirname(__FILE__)}/api.json"))['distancematrix']

      distance = JSON.parse(Net::HTTP.get(URI(format(api_data['distancematrix_uri'],
                                                     {dep_address: dep_address, 
                                                      arr_address: arr_address, 
                                                      token: api_data['distancematrix_token']
                                                     }
                                                    ))))['rows'][0]['elements'][0]['distance']['value'].to_f / 1000
    end
  end
end
