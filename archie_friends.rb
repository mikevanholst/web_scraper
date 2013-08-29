require 'rubygems'
require 'nokogiri'
require 'open-uri'
require './get_dog_names'

def get_names

	@name_array = []
	
	page = Nokogiri::HTML(open("http://www.petbabynames.com/populardognames.php"))
	doggies = page.css('div#content a')
		
	doggies.each do |name|
		formated_name = name.text.downcase.capitalize
		@name_array << formated_name
	end	
		
	return @name_array
		
end #method

def get_photos

	@image_array = []
	# go to bing images
	page = Nokogiri::HTML(open("http://www.bing.com/images/async?q=french+bulldog&async=content&first=36&count=35&dgst=ro_u916*&IID=images.1&SFX=2&IG=bcf2b00fb3924da58a6a4a9410277834&CT=1377804670308&dgsrr=true"))
	# pictures = page.css('a.dv_i img')
	pictures= page.css('.dg_u img:not(.ovr)')
	# p (pictures[0].methods - Object.methods).sort
	pictures.each do |photo|

		photo_html = photo.to_html
		# unless photo_html.include? "class=\"ovr"
			@image_array << photo_html.gsub('&amp;', '&')
		# end
	end	
	
	return @image_array	

end


def create_page

	File.open('dog_page.html', 'w') do |f|

		f.write( "<DOCTYPE! html>\n<html>\n<head>\n\t<link rel=\"stylesheet\" type = \"text/css\" href=\"style.css\">\n\t<title>Friends of Archie Brindleton</title>\n</head>\n<body>\n")
		
		puts "File Created"
		
		get_names
		get_photos

		iterations = [@name_array.length, @image_array.length].min
		# names = @name_array.length
		# photos = @photo_array.length

		# photos < names ? dogs = photos : dogs = names

		iterations.times do |i|
		# @name_array.each_with_index do |name, i|
			 i.even? ? gender = "male"  : gender = "female"
		# 5.times do |name|
			f.write("\t<div class=\"#{gender}\">\n\t\t#{@name_array.shift}\n\t\t#{@image_array.shift}\n\t</div>\n")
			# puts "\t<div class=\"#{gender}\">\n\t\t#{@name_array.shift}\n\t\t#{@image_array.shift}\n\t</div>\n"

		end
		# friend_list = 
		# get_names

		# puts @name_array



		f.write("</body>\n</html>")
		# puts "\n</body>\n</html>\n\n"
	end

end	

create_page

# puts get_names
# puts get_photos


