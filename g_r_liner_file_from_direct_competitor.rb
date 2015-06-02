
def gogo(targetIndex)
	a = []
	fin = File.open("RowData_R_directCompetitve_logic_#{targetIndex}",'r')
	fin.each do |line|
		line = line.split(',')
		a = a + line.collect{|x| x.to_i}
	end
	



	nameList = [
	"t1_a1",
	"ct1_a1",
	"t1_a2",
	"ct1_a2",
	"t1_a3",
	"ct1_a3",
	"t1_a4",
	"ct1_a4",
	"t1_a5",
	"ct1_a5",
	"t1_a6",
	"ct1_a6",
	"t2_a1",
	"ct2_a1",
	"t2_a2",
	"ct2_a2",
	"t2_a3",
	"ct2_a3",
	"t2_a4",
	"ct2_a4",
	"t2_a5",
	"ct2_a5",
	"t2_a6",
	"ct2_a6",
	"t3_a1",
	"ct3_a1",
	"t3_a2",
	"ct3_a2",
	"t3_a3",
	"ct3_a3",
	"t3_a4",
	"ct3_a4",
	"t3_a5",
	"ct3_a5",
	"t3_a6",
	"ct3_a6",
	"t4_a "]

	maxActionNumber = 19
	file = File.open("g_r_liner_file_from_direct_competitor_#{targetIndex}","w")
	(0..36).each do |index|
		temp = "#{nameList[index]} <- c("
		(0..104).each do |i|
			unless i == 104
				temp << "#{a[index+i*37]},"
			else
				temp << "#{a[index+i*37]}"
			end
		end
		temp << ")\n"
		file << temp
	end
	file << "fit <- lm(#{nameList[nameList.size-1]} ~"

	nameList.each_index do |ind|
		if ind == 0 
			file << "#{nameList[ind]}"
		elsif ind < nameList.size-1
			file << "+#{nameList[ind]}"
		end
	end
	file << ")\n"
	file << "summary(fit)"
end


(0..5).each do |ind|
	gogo(ind)
end