require 'rubygems'
require 'nokogiri'
require 'open-uri'


class Dog_list


	def get_names
#get popular dog names
#open a file
@name_array = []

File.open("dog_names.txt", "w") do |f|
	page = Nokogiri::HTML(open("http://www.petbabynames.com/populardognames.php"))
	doggies = page.css('div#content a')

		# f.write("This is the dog name file \n\n\n")
		
		doggies.each do |name|
			formated_name = name.text.downcase.capitalize
			@name_array << formated_name
			f.write(formated_name + "\n")
		end	
	end	

	#.text.downcase.capitalize
		return @name_array
		
	end #method
end	#class