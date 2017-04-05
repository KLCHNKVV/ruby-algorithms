require "matrix"

def to_bool(value)
  return true if value == 1 or value == "true"
  return false if value == 0 or value == "false"
  return nil
end


def to_int32(value)
	return 1 if value == true
	return 0 if value == false
end

puts "Recieving message..." + "\nENTER MSG:"

a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i
d = gets.chomp.to_i

start_message = Matrix[[a],[b],[c],[d]] 
bool_message =[to_bool(a),to_bool(b),to_bool(c),to_bool(d)]
r = Math.log2(start_message.row_count) + 1 
k = start_message.row_count

puts "Message(4 symbols) is " + start_message.to_s
puts "\n" + "r = " + r.to_s + "\n" + "k = " + k.to_s	

matrix = Matrix[[false, true, true, true, true, false, false],
		  		[true, false, true, true, false, true, false],
		  		[true, true, false, true, false, false, true]]


puts "\nMatrix" + matrix.inspect.to_s
x = ((bool_message[0] && matrix[0,0]) ^ (bool_message[1] && matrix[0,1]) ^ (bool_message[2] && matrix[0,2]) ^ (bool_message[3] && matrix[0,3])) 
y = ((bool_message[0] && matrix[1,0]) ^ (bool_message[1] && matrix[1,1]) ^ (bool_message[2] && matrix[1,2]) ^ (bool_message[3] && matrix[1,3]))
z = ((bool_message[0] && matrix[2,0]) ^ (bool_message[1] && matrix[2,1]) ^ (bool_message[2] && matrix[2,2]) ^ (bool_message[3] && matrix[2,3]))	
check_symb1 = Matrix[[x],[y],[z]]

puts "Check sequence = #{to_int32(check_symb1[0,0]).to_s} #{to_int32(check_symb1[1,0]).to_s} #{to_int32(check_symb1[2,0]).to_s}"  

puts "Recieved message (7 symbols):"
recv_message = [a,b,c,d,to_int32(x),to_int32(y),to_int32(z)]

puts "Recieved message" + recv_message.inspect


puts "Do yo wanna put some mistake? (enter yes/no)"
answer = gets.chomp.to_s
while answer != "yes" && answer != "no"
	puts "Retry, please (enter yes/no)"
	answer = gets.chomp.to_s
end
	

if answer == "yes"

	puts "Enter rank where mistake will appear"
	rank = gets.chomp.to_i
	while rank < 0 && rank > 6
		puts "Incorrect range of rank (0-6)"
		rank = gets.chomp.to_i
	end

	if recv_message[rank] == 1
		recv_message[rank] = 0
		else recv_message[rank] = 1
	end
end


bool_recv_message = [to_bool(recv_message[0]),to_bool(recv_message[1]),to_bool(recv_message[2]),to_bool(recv_message[3])]
puts "Message with mistake: " + recv_message.to_s + "\n"

xx = ((bool_recv_message[0] && matrix[0, 0]) ^ (bool_recv_message[1] && matrix[0, 1]) ^ (bool_recv_message[2] && matrix[0, 2]) ^ (bool_recv_message[3] && matrix[0, 3]));
yy = ((bool_recv_message[0] && matrix[1, 0]) ^ (bool_recv_message[1] && matrix[1, 1]) ^ (bool_recv_message[2] && matrix[1, 2]) ^ (bool_recv_message[3] && matrix[1, 3]));
zz = ((bool_recv_message[0] && matrix[2, 0]) ^ (bool_recv_message[1] && matrix[2, 1]) ^ (bool_recv_message[2] && matrix[2, 2]) ^ (bool_recv_message[3] && matrix[2, 3]));

check_symb2 = Matrix[[xx],[yy],[zz]]
puts "Check sequence = #{to_int32(check_symb2[0,0]).to_s} #{to_int32(check_symb2[1,0]).to_s} #{to_int32(check_symb2[2,0]).to_s}"  


sindrom = [to_int32(xx) ^ recv_message[4],to_int32(yy) ^ recv_message[5],to_int32(zz) ^ recv_message[6]]
puts "Sindrom is " + sindrom.inspect


if sindrom[0] == 0 && sindrom[1] == 0 && sindrom[2] == 0
	puts "There are no mistakes"
	exit 1
elsif (sindrom[0] != 1) && (sindrom[1] != 0) && (sindrom[2] != 0)
	puts "Mistake in the null rank."
	correct_message =  [1 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"
elsif (sindrom[0] != 0) && (sindrom[1] != 1) && (sindrom[2] != 0)
	puts "Mistake in the first rank."
	correct_message =  [0 ^ recv_message[0],
	 					1 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"
elsif (sindrom[0] != 0) && (sindrom[1] != 0) && (sindrom[2] != 1)
	puts "Mistake in the second rank."
	correct_message =  [0 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					1 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"	
elsif (sindrom[0] != 0) && (sindrom[1] != 0) && (sindrom[2] != 0)
	puts "Mistake in the third rank."
	correct_message =  [0 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					1 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"	
elsif (sindrom[0] != 0) && (sindrom[1] != 1) && (sindrom[2] != 1)
	puts "Mistake in the fourth rank."
	correct_message =  [0 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					1 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"
elsif (sindrom[0] != 1) && (sindrom[1] != 0) && (sindrom[2] != 1)
	puts "Mistake in the fifth rank."
	correct_message =  [0 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					1 ^ recv_message[5],
	 					0 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"	
elsif (sindrom[0] != 1) && (sindrom[1] != 1) && (sindrom[2] != 0)
	puts "Mistake in the sixth rank."
	correct_message =  [0 ^ recv_message[0],
	 					0 ^ recv_message[1],
	 					0 ^ recv_message[2],
	 					0 ^ recv_message[3],
	 					0 ^ recv_message[4],
	 					0 ^ recv_message[5],
	 					1 ^ recv_message[6]]
	puts "Mistake corrected: #{correct_message.inspect}"
end


