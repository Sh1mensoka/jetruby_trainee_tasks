require "json"

class DistanceCalculatorProxy
  attr_accessor :cache, :list_of_apis

  def initialize
    @cache = {}
    @list_of_apis = JSON.parse(File.read("#{File.dirname(__FILE__)}/api_files/api.json")).keys
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
