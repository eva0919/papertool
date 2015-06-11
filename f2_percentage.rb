# coding: utf-8
# Generate weka file to run logic regression 
# model : using self data and all competitor
require 'date'
maxYear = 2014
filenameAppend = "All_action_Round2_"
output_filenameAppend ="RowData_weka_AC_logic_round2_representIsPercentage_" 
	# allCompanyList = ["apple","samsung","nokia","htc","motorola","huawei","zte","lg","lenovo","sony","xiaomi"]
	allCompanyList = ["apple","samsung","nokia","htc","motorola","huawei"]

	companyHash = {}
	totalActionHash = {}
	totalValueHash = {}
	totalValue_eachCompanyHash= {}
	(2012..maxYear).each do |year|
		(1..12).each do |season|
			totalActionHash["#{year}-#{season}"] = Array.new(6) { |i| i = 0 }
		end
	end
	allCompanyList.each do |companyName|
		hash = {}
		isEnd = false
		totalValue_eachCompanyHash[companyName.to_sym] = {}
		zeroArray = Array.new(6) { |i| i = 0 }
		(2012..maxYear).each do |year|
			(1..12).each do |season|
				hash["#{year}-#{season}"] = Array.new(zeroArray)
				totalValue_eachCompanyHash[companyName.to_sym]["#{year}-#{season}"] = 0
				totalValueHash["#{year}-#{season}"] = 0
			end
		end

		File.open("#{filenameAppend}#{companyName}").each do |line|
			token = line.split(' ')
			d = Date.parse( token[6] )
			season = d.mon
			if hash.has_key?("#{d.year}-#{season}")
				hash["#{d.year}-#{season}"].each_index do |ind|
					hash["#{d.year}-#{season}"][ind] += token[ind].to_i
					totalActionHash["#{d.year}-#{season}"][ind] += token[ind].to_i
					totalValueHash["#{d.year}-#{season}"] += token[ind].to_i
					totalValue_eachCompanyHash[companyName.to_sym]["#{d.year}-#{season}"] += token[ind].to_i
				end
			else	
				arry = Array.new
				(0..5).each do |i|
					arry[i] = token[i].to_i
					totalValueHash["#{d.year}-#{season}"] += token[i].to_i
					totalValue_eachCompanyHash[companyName.to_sym]["#{d.year}-#{season}"] += token[i].to_i
				end
				hash["#{d.year}-#{season}"] = arry
				totalActionHash["#{d.year}-#{season}"] = arry
				
			end
		end

		companyHash[companyName.to_sym] = hash
		puts "#{companyName} preprocessing finished..."

	end
	# companyHash.each do |key,value|
	# 	tempHash = {}
	# 	(2012..maxYear).each do |year|
	# 		(1..12).each do |season|
	# 			tV = 0 
	# 			value["#{year}-#{season}"].each do |value|
	# 				tV += value.to_i
	# 			end
	# 			tempHash["#{year}-#{season}"] = tV
	# 		end
	# 	end
	# 	totalValue_eachCompanyHash[key] = tempHash
	# end
	# p companyHash

	# totalActionHash = []
	# companyList.each do |companyName|
	# 	competitiveCompanyList = companyList.select{|i| i!=companyName}
	# end
	# p totalActionHash
	


(0..5).each do |targetIndex|

	fOutput = File.open("#{output_filenameAppend}#{targetIndex}.arff",'w')

	fOutput.write( "@relation active_action_1\n")
	fOutput.write( "@attribute t1_a1 numeric\n")
	fOutput.write( "@attribute ct1_a1 numeric\n")
	fOutput.write( "@attribute t1_a2 numeric\n")
	fOutput.write( "@attribute ct1_a2 numeric\n")
	fOutput.write( "@attribute t1_a3 numeric\n")
	fOutput.write( "@attribute ct1_a3 numeric\n")
	fOutput.write( "@attribute t1_a4 numeric\n")
	fOutput.write( "@attribute ct1_a4 numeric\n")
	fOutput.write( "@attribute t1_a5 numeric\n")
	fOutput.write( "@attribute ct1_a5 numeric\n")
	fOutput.write( "@attribute t1_a6 numeric\n")
	fOutput.write( "@attribute ct1_a6 numeric\n")
	fOutput.write( "@attribute t2_a1 numeric\n")
	fOutput.write( "@attribute ct2_a1 numeric\n")
	fOutput.write( "@attribute t2_a2 numeric\n")
	fOutput.write( "@attribute ct2_a2 numeric\n")
	fOutput.write( "@attribute t2_a3 numeric\n")
	fOutput.write( "@attribute ct2_a3 numeric\n")
	fOutput.write( "@attribute t2_a4 numeric\n")
	fOutput.write( "@attribute ct2_a4 numeric\n")
	fOutput.write( "@attribute t2_a5 numeric\n")
	fOutput.write( "@attribute ct2_a5 numeric\n")
	fOutput.write( "@attribute t2_a6 numeric\n")
	fOutput.write( "@attribute ct2_a6 numeric\n")
	fOutput.write( "@attribute t3_a1 numeric\n")
	fOutput.write( "@attribute ct3_a1 numeric\n")
	fOutput.write( "@attribute t3_a2 numeric\n")
	fOutput.write( "@attribute ct3_a2 numeric\n")
	fOutput.write( "@attribute t3_a3 numeric\n")
	fOutput.write( "@attribute ct3_a3 numeric\n")
	fOutput.write( "@attribute t3_a4 numeric\n")
	fOutput.write( "@attribute ct3_a4 numeric\n")
	fOutput.write( "@attribute t3_a5 numeric\n")
	fOutput.write( "@attribute ct3_a5 numeric\n")
	fOutput.write( "@attribute t3_a6 numeric\n")
	fOutput.write( "@attribute ct3_a6 numeric\n")
	fOutput.write( "@attribute t4_a {0,1}\n")
	fOutput.write( "@data\n\n")
	companyList = ["apple","samsung","nokia","htc","motorola"]
	companyList.each do |companyName|
		# competitiveCompanyList = companyList.select{|i| i!=companyName}
		# p competitiveCompanyList
		isEnd = false
		(2012..maxYear).each do |year|
			(1..12).each do |season|
				y = year
				t = season-1
				timeZone = []
				(0..3).each do |ind|
					t += 1
					if t > 12
						y += 1
						if y > maxYear
							break
						end
						t = 1
					end
					timeZone[ind] = "#{y}-#{t}"
				end
				
				if y > maxYear
					isEnd = true
					break
				end
				temp = ""
				hash = companyHash[companyName.to_sym]
				(0..3).each do |ind|
					if ind < 3
						# p timeZone[ind]
						hash[timeZone[ind]].each_index do |value|
							selfValue = hash[timeZone[ind]][value].to_i 
							competitorValue = totalActionHash[timeZone[ind]][value].to_i - selfValue
							if totalValue_eachCompanyHash[companyName.to_sym][timeZone[ind]].to_i > 0
								selfValue = selfValue.to_f / totalValue_eachCompanyHash[companyName.to_sym][timeZone[ind]].to_i
							else 
								selfValue = selfValue.to_f / 1
							end
							if totalValueHash[timeZone[ind]].to_i > 0 
								competitorValue = competitorValue.to_f / totalValueHash[timeZone[ind]].to_i
							else
								competitorValue = competitorValue.to_f / 1
							end 
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

