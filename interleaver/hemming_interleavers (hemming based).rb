require 'matrix'


def to_bool value
  return true if value == 1 or value == 'true'
  return false if value == 0 or value == 'false'
end


def to_int value
  return 1 if value == true or value == 'true'
  return 0 if value == false  or value == 'false'
end


matrix = Matrix[[false, true, true, true, true, false, false],
                [true, false, true, true, false, true, false],
                [true, true, false, true, false, false, true]]

print "Enter number of codewords: "
num_comb = gets.to_i
k = 4

r = Math.log2(k) + 1
print "\n" + 'r = ' + r.to_s + "\n" + "k = " + k.to_s + "\nn = #{k + r}\n"

print "Fill #{num_comb} codewords: \n"

og_matrix = Matrix[]
num_comb.times do |x=0|
  x+=1
  c = []
  k.times do |val|
    val = gets.to_i
    c<< to_bool(val)
  end
  print "Codeword №#{x}: #{c}\n"
  og_matrix = Matrix.rows(og_matrix.to_a<<c)
end

print "Matrix filled with codewords: \n"
og_matrix.to_a.each do |row|
  puts row.inspect
end

og_new_matrix = Matrix[]
check_sequence = []

(0..(og_matrix.row_count-1)).each { |i|
  x = ((og_matrix.row(i).to_a[0] && matrix[0, 0]) ^ (og_matrix.row(i).to_a[1] && matrix[0, 1]) ^ (og_matrix.row(i).to_a[2] && matrix[0, 2]) ^ (og_matrix.row(i).to_a[3] && matrix[0, 3]))
  y = ((og_matrix.row(i).to_a[0] && matrix[1, 0]) ^ (og_matrix.row(i).to_a[1] && matrix[1, 1]) ^ (og_matrix.row(i).to_a[2] && matrix[1, 2]) ^ (og_matrix.row(i).to_a[3] && matrix[1, 3]))
  z = ((og_matrix.row(i).to_a[0] && matrix[2, 0]) ^ (og_matrix.row(i).to_a[1] && matrix[2, 1]) ^ (og_matrix.row(i).to_a[2] && matrix[2, 2]) ^ (og_matrix.row(i).to_a[3] && matrix[2, 3]))
  check_sequence<<x
  check_sequence<<y
  check_sequence<<z
  t = (og_matrix.row(i).to_a << check_sequence).flatten!
  check_sequence = []
  og_new_matrix = Matrix.rows(og_new_matrix.to_a<<t)
}

print "\nMatrix filled with codewords + their check_sequences: \n"
og_transpose = og_new_matrix.transpose
og_transpose.to_a.each do |row|
  puts row.inspect
end

print "Enter error row(0 - #{og_transpose.row_count - 1}): "
row_flag = gets.to_i
print "Enter error column(0 - #{og_transpose.column_count - 1}): "
column_flag = gets.to_i
og_array_tran = og_transpose.to_a

og_array_tran[row_flag][column_flag] ? og_array_tran[row_flag][column_flag] = false : og_array_tran[row_flag][column_flag] = true

if og_array_tran[row_flag + 1][column_flag + 1]
  og_array_tran[row_flag + 1][column_flag + 1] = false
elsif og_array_tran[row_flag + 1][column_flag + 1].nil?
  (og_array_tran[row_flag - 1][column_flag - 1]) ? og_array_tran[row_flag - 1][column_flag - 1] = false : og_array_tran[row_flag - 1][column_flag - 1] = true
else
  og_array_tran[row_flag + 1][column_flag + 1] = true
end

print "\nMatrix filled with mistake codewords: \n"
og_array_tran.transpose.each { |row| puts row.inspect }

og_array = og_array_tran.transpose
syndrome = []

og_array.each { |row|
  xx = ((row[0] && matrix[0, 0]) ^ (row[1] && matrix[0, 1]) ^ (row[2] && matrix[0, 2]) ^ (row[3] && matrix[0, 3]))
  yy = ((row[0] && matrix[1, 0]) ^ (row[1] && matrix[1, 1]) ^ (row[2] && matrix[1, 2]) ^ (row[3] && matrix[1, 3]))
  zz = ((row[0] && matrix[2, 0]) ^ (row[1] && matrix[2, 1]) ^ (row[2] && matrix[2, 2]) ^ (row[3] && matrix[2, 3]))
  pod_syndrome = [xx^row[4], yy^row[5], zz^row[6]]
  syndrome<<pod_syndrome
}

syndrome.each_index do |index = 0|
  print "Syndrome for codeword №#{index + 1}: #{syndrome[index].inspect}\n" if syndrome[index] != [false, false, false]
end

(0..matrix.column_count).each { |i|
  syndrome.each_with_index do |item, index|
    if item == matrix.column(i).to_a
      og_array[index][i] = og_array[index][i]^true
    end
  end
}

print "\nMatrix filled with _correct_ codewords: \n"
og_array.each { |row| puts row.inspect }