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
		f.write("\t<div id=\"topper\">\n")
		f.write("\t\t<div id=\"search\">Archie Brindleton</div>\n")
		f.write("\t</div>\n")
		f.write("\t<div id=\"container\">\n")
		f.write("\t\t<div id=\"big_pic\"><a href=\"https://www.facebook.com/ArchieBrindleton\"></a> </div>\n") 
	#</a><img src=\"./top_archie_crop.jpg\" >
		f.write("\t\t<div id=\"info\">\n")
		f.write("\t\t\t<div id=\"inset\"><img src=\"./archie_inset.jpg\" ></div>\n")
		f.write("\t\t\t<h1 id=\"name_plate\" >Archie Brindleton</h1>\n")
		f.write("\t\t<h2 id=\"smells\"><ul><li>Archie's Friends: 396</li><li id=\"butts\"> Butt Smells: 8,967</li><ul></h2>\n")
		f.write("\t\t\</div>\n")
		f.write("\t<div id=\"friends\">\n")

		
		get_names
		get_photos

		iterations = [@name_array.length, @image_array.length].min

		
		# names = @name_array.length
		# photos = @photo_array.length

		# photos < names ? dogs = photos : dogs = names
		switcher = [3,4,7,8,11,12,15,16,19,20]
		iterations.times do |i|
		# @name_array.each_with_index do |name, i|
			 i.even? ? gender = "male"  : gender = "female"

			 # 5.times do |name|
			 switcher.include?(i) ? side = "switched" : side = "unswitched"
			f.write("\t<div class=\"#{gender} #{side}\">\n\t\t<h2 class=\"dog_name\">#{@name_array.shift}<h2>\n\t\t#{@image_array.shift}\n\t</div>\n\n")
			# f.write("\t\t<div class=\"clear\"></div>\n") if gender == "female"
			# puts "\t<div class=\"#{gender}\">\n\t\t#{@name_array.shift}\n\t\t#{@image_array.shift}\n\t</div>\n"

		end
		# friend_list = 
		# get_names

		# puts @name_array

		f.write("\t</div>\n")
		f.write("\t</div>\n")
		f.write("\t</div>\n")
		f.write("</body>\n</html>")
		# puts "\n</body>\n</html>\n\n"
	end

end	

create_page

# puts get_names
# puts get_photos


