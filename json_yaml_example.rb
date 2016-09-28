require 'json'
require 'set'
require 'yaml


class Set
  def self.json_creatable?
   true
 end
  def to_json(*a)
    {
      'json_class'   => self.class.name, # = 'Range'
      'data'         => [self.to_a]
    }.to_json(*a)
  end
  def self.json_create(o)
    new(*o['data'])
  end
end

class Bird
  def initialize(name, characteristic, area)
    @name=name
    @characteristic=characteristic
    @area=area
  end
  def to_json(*a)
    {
      'json_class'   => self.class.name,
       'data'         => [@name, @characteristic, @area]
    }.to_json(*a)
  end
  def self.json_create(o)
    new(*o['data'])
  end
end

s=Set.new ["go", 435.007, {"points"=>80}, false, nil]

puts s
file=s.to_json
puts file
puts "#{JSON.load(file).class}"
puts "#{JSON.load(file).inspect}"

sparrow=Bird.new("Sparrow", [{"size"=>11.4}, {"weight"=>0.03}], ["Africa", "Eurasia"])
king_penguin=Bird.new("King penguin", [{"size"=>80}, {"weight"=>13}], "Subantarctic islands")
s_injson=sparrow.to_json
s_injsonpretty=JSON.pretty_generate(sparrow)
arr_of_birds=[sparrow, king_penguin]
arr_injson=arr_of_birds.to_json
arr_inyaml=YAML.dump(arr_of_birds)

puts s_injson
puts s_injsonpretty
puts arr_injson
puts "#{JSON.load(arr_injson)}"
puts "#{arr_inyaml}"
puts "#{YAML.load(arr_inyaml)}"
