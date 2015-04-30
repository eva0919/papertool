def get_random_variable
	arr = []
	ir1 = 0
	ir2 = 0
	ir3 = 0 
	ir4 = 0 
	(1..10000).each do |ind|
		temp = []
		r1 = rand(10)
		r2 = rand(2)
		if r1 > 1
			temp << "T"
			ir1 += 1
		else
			temp << "F"
		end

		if r2 > 0
			temp << "T"
			ir2 += 1
		else
			temp << "F"
		end

		arr << temp

	end



	arr.each do |value|
		if value[0] == "T" && value[1] =="T"
			if rand(10) > 1
				value << "T"
				ir3 += 1
			else
				value << "F"
			end
		elsif value[0] == "T" && value[1] =="F"
			if rand(10) > 4
				value << "T"
			else
				value << "F"
			end
		elsif value[0] == "F" && value[1] =="T"
			if rand(10) > 3
				value << "T"
			else
				value << "F"
			end
		else
			if rand(10) > 8
				value << "T"
			else
				value << "F"
			end		
		end
	end

	arr.each do |value|
		if value[2] == "T"
			if rand(10) > 1
				value << "T"
				ir4 += 1
			else
				value << "F"
			end
		else
			if rand(10) > 4
				value << "T"
			else
				value << "F"
			end
		end
	end

	return arr
end


