#just pushes random words to github every so often
require 'net/http'
require 'timeout'
require 'rubygems'
require 'searchbing'
bing_image = Bing.new('dQ22zQvtQ2U3uyHD6aGOhIDibBteqrp7CBVR6mrdXhw=', 1, 'Image')

def push_to_git
  system 'git add --all'
  system 'git commit -a -m "newline"'
  system 'git pull origin master'
  system 'git push origin master'
end

letters = "abcdefghijklmnopqrstuvwxyz"
lengthmax = 12

while true do
	f = File.new("index.html",  "a")
	word = String.new("")

	wordlength = rand(lengthmax);
	while(wordlength<=3)
		wordlength = rand(lengthmax);
	end

	for i in 0..wordlength	
		word<<letters[rand(letters.length)]
	end

	bing_results = bing_image.search(word)
	

	begin 
		if(bing_results.length>0)
			url = bing_results[0][:Image][0][:MediaUrl]

	
			f.puts("\r\n" + "<div class=\"liv-word\">" + word+ "</div><a href=\"" + url +"\"><img class=\"liv-image\" src=\"" + url + "\"/></a>")
			f.close
			sleep rand(36000);
			push_to_git
		end
	rescue
		puts "did not find anything, trying again\n"
	end



end
