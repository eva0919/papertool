require './DeBugMan.rb'
# cmd_string = "java -cp ./weka.jar weka.classifiers.functions.Logistic -t RowData_weka_competitve_logic_round2_3.arff -s 840"
# result = `#{cmd_string}`
# # p result
# temp = result.split("Correctly Classified Instances")
# temp = temp[2].split("Incorrectly Classified Instances")
# p temp
# temp = temp[0].match(/\d+.\d+ +%/).to_s
# p temp
# temp = temp.gsub("%","")
# temp = temp.gsub(" ","")
# puts temp.to_s

a = DeBugMan.new
a.loading_bar(1,2)
sleep(1)
a.loading_bar(2,2)