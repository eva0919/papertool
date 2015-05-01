require './exec_probability.rb'
require './node.rb'
require './DeBugMan.rb'
require 'optparse'

@bugMode = false

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-d", "--[no-]debugMode", "Run debugMode") do |v|
    options[:debugMode] = v
    @bugMode = v
  end
end.parse!



def cal_probability(list,node)
	nodeSize = node.size
	totalEventNum = list.size.to_f  
	nodeActionList = Array.new(nodeSize) { |i| i = Hash.new }
	jointNode = Hash.new
	(0..nodeSize-1).each do |ind|
		(ind+1..nodeSize-1).each do |i|
			jointNode["#{ind}#{i}"] = Hash.new
		end
	end
	list.each do |data|
		data.each_index do |ind|
			if nodeActionList[ind].has_key?(data[ind])
				nodeActionList[ind][data[ind]] += 1
			else
				nodeActionList[ind][data[ind]] = 1
			end
			(ind+1..nodeSize-1).each do |i|
				if jointNode["#{ind}#{i}"].has_key?("#{data[ind]}#{data[i]}")
					jointNode["#{ind}#{i}"]["#{data[ind]}#{data[i]}"] += 1
				else
					jointNode["#{ind}#{i}"]["#{data[ind]}#{data[i]}"] = 1
				end
			end
		end
	end

	node.each_index do |ind|
		node[ind].Probability = nodeActionList[ind]
	end

	node.each_index do |ind|
		node[ind].Probability.each do |key,value|
			node[ind].Probability[key] = value / totalEventNum 
		end
	end
	jointNode.each_value do |value|
		value.each do |key,value2|
			value[key] = value2 / totalEventNum 
		end		
	end

	
	return jointNode

end

def cal_line(node,jNode)
	nodeSize = node.size
	
	(0..nodeSize-1).each do |ind|
		(ind+1..nodeSize-1).each do |i|
			isIndependent(node[ind],node[i],jNode)
		end
	end
end

def show_probabilit(node1,node2)
	node1.Probability.each do |key,value|
		node2.Probability.each do |key2,value2|
			puts "#{key}-#{key2} : #{value*value2}"
		end
	end
end

def isIndependent(node1,node2,jNode)
	id1 = node1.NodeID-1
	id2 = node2.NodeID-1
	jointProbability = jNode["#{id1}#{id2}"]
	node1.Probability.each do |key,value|
		node2.Probability.each do |key2,value2|
			tag = "#{key}#{key2}"
			if  (value * value2 - jointProbability[tag]).abs > 0.05
				puts "#{id1} -> #{id2}"
			end
		end
	end
end

randomList = get_random_variable()
nodeList = []
jointNode = {}
nodeTotalNum = randomList[0].size
totalEventNum = randomList.size
DeBugMan.testForNumber(nodeTotalNum,4,"Node number is correct!") if @bugMode

(1..nodeTotalNum).each do |ind|
	nodeList[ind-1] = Node.new(ind,2,["T","F"])
	(ind+1..nodeTotalNum).each do |i|
		jointNode["#{ind}#{i}"] = JointNode.new(ind,i)
	end
end

jointNode = cal_probability(randomList,nodeList)

DeBugMan.testForNumber(jointNode.size,6,"Joint Node num is correct!") if @bugMode

cal_line(nodeList,jointNode)

DeBugMan.done