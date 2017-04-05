text = File.read('%enter here path to txt file containing any english words%')
eng_alphabet = File.read('%write here path to txt file with alphabet (eng)%')

NULL = 0.0


def prok (some_text)
	if some_text!=nil
		
		res = Hash.new (NULL)
		some_text.each_char { |x| res[x]+=1 }

		while res.length>=some_text.length
			res[some_text] = res[some_text]+1
		end

		res.each {|key,value| puts "#{key} ===> #{value}"}

		res.values.each do |v|
			s = v / some_text.length
			puts s.round(5)
		end
	end
end


def calc (any_text)
 if any_text!=nil
	keys = Hash.new(NULL)
	any_text.each_char { |x| keys[x]+=1 }
	text_length = any_text.length

	keys.values.reduce(NULL) do |calc,key|
		frequency = key / text_length 
		calc - frequency * Math.log2(frequency)
	end
 end
end


#main
print text,"\n"
print "\n -------Shannon's Entropy For Text From File ===== ",calc(text).round(3).to_s.chomp,"\n"
print "probability".upcase,":\n"
prok (text)

print "\n",eng_alphabet,"\n"
print "\n -------Shannon's Entropy For English Alphabet ===== ",calc(eng_alphabet).round(3).to_s.chomp,"\n"
print "Amount Of Information In My Name-Surname = ","Daniel Kliuchnikov".length * calc(eng_alphabet).round(3)," bit\n" 

