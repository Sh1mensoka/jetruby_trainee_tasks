class PriceCalculator
  def self.calculate_price(weight, length, width, height, distance)
    return distance unless length * width * height > 1
    return distance * 2 unless weight > 10
    distance * 3
  end
end
