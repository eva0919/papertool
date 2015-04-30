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
end