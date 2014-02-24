require 'coffee_lib'

CoffeeLib.instance = nil
CoffeeLib.instance.on_value do |v|
  PotDatum.create!(level: v)
end

puts 'Coffee Lib hooked'
