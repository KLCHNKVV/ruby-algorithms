require_relative("RSA_methods")
require_relative("integer_override")
require 'openssl'
require 'scanf'

E = 65537

print "\tElectronic-Digital Signature With RSA.\n\n"
sent_data = File.read("some_data.txt")
print "|Sent Message:|\n #{sent_data}\n"

n, e, d = generate_keys(256)
print_all(n, e, d)

hash_func = OpenSSL::Digest::MD5.new(sent_data)
print "MD5 Hash Function: #{hash_func}\n"

hash = hash_func.to_s.split("")
encrypted_hash_ascii = []
for item in hash
  encrypted_hash_ascii<<s_to_n(item)
end

encrypted_hash = []
for item1 in encrypted_hash_ascii
  encrypted_hash<<(item1.to_bn.mod_exp(d, n)).to_i
end

print "Encrypted Hash: #{encrypted_hash.join.to_i}\n"

File.open("data_eds.txt", "w+") do |file|
  file<<encrypted_hash.join.to_i.to_s
end

print "Do you wanna use old keys? (write y/n): "
answer = gets.chomp
if answer=='n'

  n_arr = n.to_s.scanf("%1d"*n.size)

  print "Select rank in |n| where changes will be appear (#{"0 -- " + (n_arr.size-1).to_s}):"
  n_change = gets.to_i
  print "Enter new value in |n| for this rank (0-9):"
  n_value = gets.to_i
  n_arr[n_change] = n_value
  n = n_arr.join.to_i

  decrypted_hash = ""
  decrypted_hash_ascii = []

  for enc_item in encrypted_hash
    decrypted_hash_ascii<<(enc_item.to_bn.mod_exp(E,n)).to_i
  end

  for decr_item in decrypted_hash_ascii
    decrypted_hash<<n_to_s(decr_item)
  end

  print "Decrypted Hash: #{decrypted_hash}\n"
  print "Hash-function of accepted message: #{(OpenSSL::Digest::MD5.new(File.read("some_data.txt"))).to_s}\n"
  if decrypted_hash == (OpenSSL::Digest::MD5.new(File.read("some_data.txt"))).to_s
    print "Everything OK. EDS is approved.\n"
  else
    print "Something went wrong. EDS is not approved.\n"
  end
else
  decrypted_hash = ""
  decrypted_hash_ascii = []

  for enc_item in encrypted_hash
    decrypted_hash_ascii<<(enc_item.to_bn.mod_exp(E,n)).to_i
  end

  for decr_item in decrypted_hash_ascii
    decrypted_hash<<n_to_s(decr_item)
  end

  print "Decrypted Hash: #{decrypted_hash}\n"
  print "Hash-function of accepted message: #{(OpenSSL::Digest::MD5.new(File.read("some_data.txt"))).to_s}\n"
  if decrypted_hash == (OpenSSL::Digest::MD5.new(File.read("some_data.txt"))).to_s
    print "Everything OK. EDS is approved.\n"
  else
    print "Text was changed, EDS wasn't. EDS is not approved.\n"
  end
end


