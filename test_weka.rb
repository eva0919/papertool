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

p ir1
p ir2
p ir3
p ir4


file = File.open('file1.arff','w')
file.write("@relation test\n")
file.write("@attribute t1 {TRUE, FALSE}\n")
file.write("@attribute t2 {TRUE, FALSE}\n")
file.write("@attribute t3 {TRUE, FALSE}\n")
file.write("@attribute t4 {TRUE, FALSE}\n")
file.write( "@data\n\n")

arr.each do |value|
	i = 0 
	value.each do |v|
		if i < 3
			if v == "T"
				file << "TRUE,"
			else
				file << "FALSE,"
			end
		else
			if v == "T"
				file << "TRUE"
			else
				file << "FALSE"
			end
		end
		i += 1
	end
	file << "\n"
end