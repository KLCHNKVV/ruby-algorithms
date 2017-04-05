enter_text = File.read("%enter here path to txt file containing english text%")

puts "USED TEXT: " + "\n"+ enter_text + "\n" 

NULL = 0.00
ENG_ALPHABET = 5.64

def calc_shannons (txt)
	l = txt.length
 	if txt != nil
		keys = Hash.new(NULL)
		txt.each_char { |x| keys[x]+=1 }
		text_length = l

		keys.values.reduce(NULL) do |calc,key|
			frequency = key / text_length 
			calc - frequency * Math.log2(frequency)
		end
 	end
end


def conditional_entropy (any_txt)
	p = NULL
	len = any_txt.length
	shannon = calc_shannons(any_txt)

	puts "Enter time(sec):".chomp
	t = gets

	puts "Enter speed (bit per sec)".chomp
	v = gets

	s = calc_shannons (any_txt)
	out = t.to_i * v.to_i * s
	puts "Amount Of Sended Info = " + out.to_s

	while p<=0.9
		p += 0.1
		q = 1  -  p
		hxy = (-p.round(1) * Math.log2(p) - q * Math.log2(q.round(1)))
		puts "p (probability of error) = " + p.round(1).to_s + " and " + " conditional_entropy in that case = " + hxy.to_s.chomp
		puts "Effective entropy for this case = " + (shannon - hxy).to_s + "\n"
		puts "Amount Of Loss Information = " + (shannon * len - (shannon - hxy) * len).to_s + " bit"	
		puts "Amount Of Information In Recieved Message = " + ((shannon - hxy) * len).to_s
 	end
end


puts "Enthropy Of Text Above: " + calc_shannons(enter_text).to_s + "\n"
conditional_entropy (enter_text)

	


