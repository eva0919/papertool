# coding: utf-8
require 'date'


	companyList = ["apple","samsung","nokia","htc","motorola"]
	competitorTable = {
		:apple => "samsung",
		:samsung => "apple",
		:nokia => "apple",
		:htc=> "samsung",
		:motorola => "apple"
 	}

	companyHash = {}
	totalActionHash = {}
	(2012..2013).each do |year|
		(1..12).each do |season|
			totalActionHash["#{year}-#{season}"] = Array.new(6) { |i| i = 0 }
		end
	end
	companyList.each do |companyName|
		hash = {}
		isEnd = false
		zeroArray = Array.new(6) { |i| i = 0 }
		(2012..2013).each do |year|
			(1..12).each do |season|
				hash["#{year}-#{season}"] = Array.new(zeroArray)
			end
		end

		File.open("#{companyName}_all_event").each do |line|
			token = line.split(' ')
			d = Date.parse( token[6] )
			season = d.mon
			if hash.has_key?("#{d.year}-#{season}")
				hash["#{d.year}-#{season}"].each_index do |ind|
					hash["#{d.year}-#{season}"][ind] += token[ind].to_i
					totalActionHash["#{d.year}-#{season}"][ind] += token[ind].to_i
				end
			else
				arry = Array.new
				(0..5).each do |i|
					arry[i] = token[i].to_i
				end
				hash["#{d.year}-#{season}"] = arry
				totalActionHash["#{d.year}-#{season}"] = arry
			end
		end

		companyHash[companyName.to_sym] = hash
		puts "#{companyName} preprocessing finished..."

	end

	# p companyHash

	# totalActionHash = []
	# companyList.each do |companyName|
	# 	competitiveCompanyList = companyList.select{|i| i!=companyName}
	# end
	# p totalActionHash
	


(0..5).each do |targetIndex|

	# fOutput = File.open("RowData_weka_directCompetitve_logic_#{targetIndex}.arff",'w')
	fOutput = File.open("RowData_R_directCompetitve_logic_#{targetIndex}",'w')
	# fOutput.write( "@relation active_action_1\n")
	# fOutput.write( "@attribute t1_a1 numeric\n")
	# fOutput.write( "@attribute ct1_a1 numeric\n")
	# fOutput.write( "@attribute t1_a2 numeric\n")
	# fOutput.write( "@attribute ct1_a2 numeric\n")
	# fOutput.write( "@attribute t1_a3 numeric\n")
	# fOutput.write( "@attribute ct1_a3 numeric\n")
	# fOutput.write( "@attribute t1_a4 numeric\n")
	# fOutput.write( "@attribute ct1_a4 numeric\n")
	# fOutput.write( "@attribute t1_a5 numeric\n")
	# fOutput.write( "@attribute ct1_a5 numeric\n")
	# fOutput.write( "@attribute t1_a6 numeric\n")
	# fOutput.write( "@attribute ct1_a6 numeric\n")
	# fOutput.write( "@attribute t2_a1 numeric\n")
	# fOutput.write( "@attribute ct2_a1 numeric\n")
	# fOutput.write( "@attribute t2_a2 numeric\n")
	# fOutput.write( "@attribute ct2_a2 numeric\n")
	# fOutput.write( "@attribute t2_a3 numeric\n")
	# fOutput.write( "@attribute ct2_a3 numeric\n")
	# fOutput.write( "@attribute t2_a4 numeric\n")
	# fOutput.write( "@attribute ct2_a4 numeric\n")
	# fOutput.write( "@attribute t2_a5 numeric\n")
	# fOutput.write( "@attribute ct2_a5 numeric\n")
	# fOutput.write( "@attribute t2_a6 numeric\n")
	# fOutput.write( "@attribute ct2_a6 numeric\n")
	# fOutput.write( "@attribute t3_a1 numeric\n")
	# fOutput.write( "@attribute ct3_a1 numeric\n")
	# fOutput.write( "@attribute t3_a2 numeric\n")
	# fOutput.write( "@attribute ct3_a2 numeric\n")
	# fOutput.write( "@attribute t3_a3 numeric\n")
	# fOutput.write( "@attribute ct3_a3 numeric\n")
	# fOutput.write( "@attribute t3_a4 numeric\n")
	# fOutput.write( "@attribute ct3_a4 numeric\n")
	# fOutput.write( "@attribute t3_a5 numeric\n")
	# fOutput.write( "@attribute ct3_a5 numeric\n")
	# fOutput.write( "@attribute t3_a6 numeric\n")
	# fOutput.write( "@attribute ct3_a6 numeric\n")
	# fOutput.write( "@attribute t4_a {0,1}\n")
	# fOutput.write( "@data\n\n")


	companyList.each do |companyName|
		# competitiveCompanyList = companyList.select{|i| i!=companyName}
		# p competitiveCompanyList
		isEnd = false
		(2012..2013).each do |year|
			(1..12).each do |season|
				y = year
				t = season-1
				timeZone = []
				(0..3).each do |ind|
					t += 1
					if t > 12
						y += 1
						if y > 2013
							break
						end
						t = 1
					end
					timeZone[ind] = "#{y}-#{t}"
				end
				
				if y > 2013
					isEnd = true
					break
				end
				temp = ""
				hash = companyHash[companyName.to_sym]
				competitorHash = companyHash[ competitorTable[companyName.to_sym].to_sym ]
				(0..3).each do |ind|
					if ind < 3
						# p timeZone[ind]
						hash[timeZone[ind]].each_index do |value|
							selfValue = hash[timeZone[ind]][value].to_i
							competitorValue = competitorHash[timeZone[ind]][value].to_i
							temp << "#{selfValue},"
							temp << "#{competitorValue},"
						end

					else
						# aIndex = 0
						# hash[timeZone[ind]].each do |value|
						# 	if value > 0
						# 		(1..value).each do |valueIndex|
						# 			fOutput.write( "#{temp}#{aIndex}\n" )
						# 		end
						# 	end
						# 	aIndex += 1
						# end
						tempIndex = targetIndex
						tempValue = hash[timeZone[ind]][tempIndex]
						tempValue = 1 if tempValue.to_i > 0
						fOutput.write( "#{temp}#{tempValue}\n" ) 
						
					end
				end
			end

			if isEnd
				break
			end
		end
	end
	fOutput.close
end

