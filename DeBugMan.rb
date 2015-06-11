class DeBugMan

	def self.done
		puts "\n=============================\n   Done!\n   Every thing is good!\n=============================\n"
	end

	def self.testForNumber(beTest,testFor,say)
		if beTest == testFor
			puts "\nDeBugMan Say : #{say}\n"
		else
			puts "\nDeBugMan Say :Error!\n"
		end
	end

	def self.putValue(data)
		puts "\n>>>>>>>>>>>>>>>>>Messange>>>>>>>>>>>>>>>>>"
		puts "#{data}"
		puts ">>>>>>>>>>>>>>>>>Messange>>>>>>>>>>>>>>>>>\n"
	end

	def loading_bar(nowPoint,endPoint)
		p = ( (nowPoint*1.0) / endPoint) * 100
		print "\r"
		print "#{p}%"
	end
end