# coding: utf-8
# Generate weka file to run logic regression 
# model : only using self data and merge 3 month to a variable for each action
require 'date'
maxYear = 2014
filenameAppend = "All_action_Round2_"
output_filenameAppend ="RowData_weka_logic_round2_merge_" 
(0..5).each do |targetIndex|


	companyList = ["apple","samsung","nokia","htc","motorola"]
	fOutput = File.open("#{output_filenameAppend}#{targetIndex}.arff",'w')
	fOutput.write( "@relation active_action_1\n" )
	fOutput.write( "@attribute a1 numeric\n" )
	fOutput.write( "@attribute a2 numeric\n" )
	fOutput.write( "@attribute a3 numeric\n" )
	fOutput.write( "@attribute a4 numeric\n" )
	fOutput.write( "@attribute a5 numeric\n" )
	fOutput.write( "@attribute a6 numeric\n" )
	fOutput.write( "@attribute t4_a {0,1}\n")
	fOutput.write( "@data\n\n")

	companyList.each do |companyName|
		hash = {}
		isEnd = false
		zeroArray = Array.new(6) { |i| i = 0 }
		(2012..maxYear).each do |year|
			(1..12).each do |season|
				hash["#{year}-#{season}"] = Array.new(zeroArray)
			end
		end

		File.open("#{filenameAppend}#{companyName}").each do |line|
			token = line.split(' ')
			d = Date.parse( token[6] )
			season = d.mon
			if hash.has_key?("#{d.year}-#{season}")
				hash["#{d.year}-#{season}"].each_index do |ind|
					hash["#{d.year}-#{season}"][ind] += token[ind].to_i
				end
			else
				arry = Array.new
				(0..5).each do |i|
					arry[i] = token[i].to_i
				end
				hash["#{d.year}-#{season}"] = arry
			end
		end

		# hash.each do |key,value|
		# 	puts key
		# 	p value
		# end







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
				tempActionArray = Array.new(6) { |i| i = 0 }
				(0..3).each do |ind|
					if ind < 3
						# p timeZone[ind]
						hash[timeZone[ind]].each_index do |value_index|
							tempActionArray[value_index] += hash[timeZone[ind]][value_index]
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
						tempActionArray.each do |value|
							temp << "#{value},"
						end
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
		puts "#{companyName} finished..."
	end
	fOutput.close
end