require './exec_probability.rb'
require './node.rb'
require './DeBugMan.rb'
require 'optparse'
require 'rubygems'
require 'sbn'


randomList = get_random_variable()


net = Sbn::Net.new("Test Net")
cloudy    = Sbn::Variable.new(net, :cloudy)      
sprinkler = Sbn::Variable.new(net, :sprinkler)
rain      = Sbn::Variable.new(net, :rain)
grass_wet = Sbn::Variable.new(net, :grass_wet)

net.learn([
  {:cloudy => :true, :sprinkler => :false, :rain => :true, :grass_wet => :true},
  {:cloudy => :true, :sprinkler => :true, :rain => :false, :grass_wet => :true},
  {:cloudy => :false, :sprinkler => :false, :rain => :true, :grass_wet => :true},
  {:cloudy => :true, :sprinkler => :false, :rain => :true, :grass_wet => :true},
  {:cloudy => :false, :sprinkler => :true, :rain => :false, :grass_wet => :false},
  {:cloudy => :false, :sprinkler => :false, :rain => :false, :grass_wet => :false},
  {:cloudy => :false, :sprinkler => :false, :rain => :false, :grass_wet => :false},
  {:cloudy => :true, :sprinkler => :false, :rain => :true, :grass_wet => :true},
  {:cloudy => :true, :sprinkler => :false, :rain => :false, :grass_wet => :false},
  {:cloudy => :false, :sprinkler => :false, :rain => :false, :grass_wet => :false},
])
p net.set_probabilities_from_sample_points!
p net.to_xmlbif
# evidence = {:sprinkler => :false, :rain => :true}
# net.set_evidence(evidence)
# p net.query_variable(:grass_wet)
DeBugMan.done