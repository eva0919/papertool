class Node

	@ActionNum = 0
	def initialize(id = 0,num = 0 ,list = [])
		@ActionNum = num
		@ActionList = list
		@Probability = 0
		@NodeID = id
	end

	# def self.Probability
	# 	@@Probability
	# end
	attr_reader :ActionNum,:ActionList,:Probability,:NodeID
	attr_writer :ActionNum,:ActionList,:Probability,:NodeID
end

class JointNode
	def initialize(id1,id2)
		@NodeID = [id1,id2]
		@Probability = Hash.new
	end
end