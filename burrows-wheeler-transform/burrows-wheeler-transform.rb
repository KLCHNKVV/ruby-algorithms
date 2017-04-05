require 'matrix'

def print_matrix(matrix)
  matrix.to_a.each { |r| puts "\t" + r.join("|") }
end

print "Enter message to compress, please: "
message = gets.chomp
print "\nYou have entered message: '#{message}'\n"

#split_message = message.chars.to_a.each_slice(3).to_a

shift_message = ""
message.size.times do
  message << message.chars[0]
  message.slice!(0)
  shift_message<<message + " "
end

shift_message = shift_message.split(" ")
for item1 in shift_message
  w1 = Matrix.rows(w1.to_a<<item1.split(" "))
end

print "\nW1 = \n"
print_matrix(w1)

shift_message = shift_message.sort_by(&:downcase)
for item2 in shift_message
  w2 = Matrix.rows(w2.to_a<<item2.split(" "))
end

print "\nW2 = \n"
print_matrix(w2)

answer = ""
for item3 in shift_message
  answer << item3.slice!(item3.length-1)
end

for row in w2.to_a
  if row.to_a.join == message
    n = w2.to_a.rindex(row)
  end
end

print "\nCompressed message is: #{answer}, N = #{n+1}\n\n"
w3 = Matrix.columns([answer.split(''), answer.split('').sort_by(&:downcase)])
print "\nW3 (first permutation) = \n"
print_matrix(w3)
print "\n-------------------------------------"

tmp_ary = []
for i in 0..w3.row_count-1
  tmp_ary<<w3.row(i).to_a
end
tmp_ary = tmp_ary.sort_by { |array| array.first.downcase }
for i in 0..tmp_ary.size-1
  tmp_ary[i].insert(0, answer.split('')[i])
end
print "\n\n"
print_matrix(tmp_ary)
print "\n--------------------------------------"

(answer.length-3).times do
  tmp_ary = tmp_ary.sort_by { |array| array.first.downcase }
  for i in 0..tmp_ary.size-1
    tmp_ary[i].insert(0, answer.split('')[i])
  end
  print "\n\n"
  print_matrix(tmp_ary)
  print "\n-------------------------------------"
end

last_step_ary = tmp_ary.sort_by {|array| array.first.downcase}
last_step_ary[n].unshift('----> ')
print "\nBWT decompress matrix on the last step = \n\n"
print_matrix(last_step_ary)
print "\n---------------------------------------"

