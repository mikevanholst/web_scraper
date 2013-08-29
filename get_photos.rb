require 'rubygems'
require 'nokogiri'
require 'open-uri'

#get popular dog names
#open a file
File.open("photos.txt", "w") do |f|
	# got to bing images
	page = Nokogiri::HTML(open("http://www.bing.com/images/async?q=french+bulldog&async=content&first=36&count=35&dgst=ro_u916*&IID=images.1&SFX=2&IG=bcf2b00fb3924da58a6a4a9410277834&CT=1377804670308&dgsrr=true"))

	f.write("This is the dog photo file \n\n\n")
	# pictures = page.css('a.dv_i img')
	pictures= page.css('.dg_u img')
	# f.write(pictures)
	# p(pictures)

	# test = page.css('h2')
	# f.write(test)
	
	# p (pictures[0].methods - Object.methods).sort

	pictures.each do |photo|
		# puts "is this working?"
		# p photo
		photo_html = photo.to_html
		# puts "test?"
		f.write(photo_html + "\n")
		p(photo_html + "\n")
	end	
end	

	# https://www.google.ca/imghp?hl=en&tab=ii