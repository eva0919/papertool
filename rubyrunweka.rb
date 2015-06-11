require 'csv'
require './DeBugMan.rb'
sayMan = DeBugMan.new
CSV.open("wekaResult/rand30seed.csv", "w") do |csv|
	csv << ["2012-2014"]
	actionList = 5
	fileNameAppendList = ["RowData_weka_logic_round2_","RowData_weka_competitve_logic_round2_","RowData_weka_directCompetitve_logic_round2_"]
	seeds = [840, 436, 629, 92, 993, 93, 612, 208, 900, 408, 229, 603, 417, 621, 966, 330, 521, 138, 158, 951, 58, 448, 869, 938, 46, 882, 903, 450, 824, 60]
	endPoint = fileNameAppendList.size * seeds.size * (actionList+1)
	nowPoint = 0
	fileNameAppendList.each do |fileNameAppend|		
		(0..actionList).each do |ind|
			csv << ["#{fileNameAppend}#{ind}"]
			tempResult = []
			seeds.each do |seed|
				cmd_string = "java -cp ./weka.jar weka.classifiers.functions.Logistic -t #{fileNameAppend}#{ind}.arff -s #{seed}"
				puts cmd_string
				result = `#{cmd_string}`
				temp = result.split("Correctly Classified Instances")
				temp = temp[2].split("Incorrectly Classified Instances")
				temp = temp[0].match(/\d+.?\d+ +%/).to_s
				temp = temp.gsub("%","")
				temp = temp.gsub(" ","")
				tempResult << temp.to_s
				nowPoint += 1
				sayMan.loading_bar(nowPoint,endPoint)
			end
			csv << tempResult
		end
	end
end
# result = %x[java -cp ./weka.jar weka.classifiers.functions.Logistic -t RowData_weka_logic_Round2_0.arff -s 80]
# temp = result.split("Correctly Classified Instances")
# temp = temp[2].split("Incorrectly Classified Instances")
# temp = temp[0].match(/\d+.\d+ %/).to_s
# temp = temp.gsub("%","")
# temp = temp.gsub(" ","")
# temp = temp[0].split(/ /)
# p temp.to_s
