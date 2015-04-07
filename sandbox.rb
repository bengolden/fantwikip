my_array = ["ham","burger",7,3,22]
p my_array.first # prints first element
p my_array[0]    # prints first element
p my_array[1]    # prints second element
p my_array[-2]   # prints second last element
puts "-----"

my_hash = {"name" => "my_hash", :description => "this is my new hash", :color => "grue"}
p my_hash['name']
p my_hash["description"]
p my_hash[:color]
p my_hash[:shape]
puts "-----"

ARRAY_CONSTANT = Array.new(5,2)
p ARRAY_CONSTANT
p ARRAY_CONSTANT.length
p ARRAY_CONSTANT.inject(:*)


puts "-----"
p [1,4,7,12].select{|int| int < 8}.map{|i| (i * 3).to_s + "MM" }