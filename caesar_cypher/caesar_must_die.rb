def caesar_cypher(input_string,shift)
  eng_alphabet=(('a'..'z').to_a) << ' '
  encryptor = Hash[eng_alphabet.zip(eng_alphabet.rotate(shift))]
  (input_string.chars.map {|letter| encryptor.fetch(letter)}).join
end

print "#{('a'..'z').to_a}\n"
print "Enter string to encrypt: "
str = gets.to_s.chomp

print "Enter value of shift: "
shift = gets.to_i

print "Encrypted message: #{caesar_cypher(str,shift)}"
print "\nDecrypted message: #{caesar_cypher((caesar_cypher(str,shift)),-shift)}"
