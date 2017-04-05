require_relative 'integer_override'
require_relative 'RSA_methods'
require 'scanf'
require 'openssl'



print "Do you wanna input p and q manually? (y/n)\n"
generate_answer = gets.chomp

if generate_answer == 'n'
  E = 65537
  n, e, d = generate_keys(1024)
else
  print "Enter e: "
  e  = gets.to_i
  p,q = get_p_and_q
  while (e.gcd(euler_func(p,q)) > 1) or (e > euler_func(p, q)) do
    print "Sorry, but |p and q| doesn't fit to the |e| and RSA standards. Re-choose them.\n"
    p,q = get_p_and_q
  end
  print "Euler func = #{euler_func(p,q)}"
  n = p * q
  d = get_d(p, q, e)
  message = get_message

  print_all(n, e, d)

  print "Do you wanna change n and d? (y/n)"
  answer = gets.to_s.chomp

  if answer == "y"
    n_arr = n.to_s.scanf("%1d"*n.size)
    d_arr = d.to_s.scanf("%1d"*d.size)

    print "Select rank in |n| where changes will be appear (#{"0 -- " + (n_arr.size-1).to_s}):"
    n_change = gets.to_i
    print "Select rank in |d| where changes will be appear (#{"0 -- " + (d_arr.size-1).to_s}):"
    d_change = gets.to_i
    print "Enter new value in |n| for this rank:"
    n_value = gets.to_i
    print "Enter new value in |d| for this rank:"
    d_value = gets.to_i

    d_arr[d_change] = d_value
    n_arr[n_change] = n_value
    n = n_arr.join.to_i
    d = d_arr.join.to_i
    print_all(n, e, d)
  else
    print "n and d stay unchanged.\n"
  end

  msg_arr = message.split("")

  msg_int = []
  for item1 in msg_arr
    msg_int<<s_to_n(item1)
  end

  msg_encrypt = []
  for item2 in msg_int
    msg_encrypt<<(item2.to_bn.mod_exp(e,n)).to_i
  end

  print "\nEncrypted message: #{msg_encrypt.join.to_i}"

  msg_decrypt = []
  for item3 in msg_encrypt
    msg_decrypt<<(item3.to_bn.mod_exp(d,n)).to_i
  end

  decrypted_message = ""
  for item in msg_decrypt
    decrypted_message<<n_to_s(item)
  end

  print "\nDecrypted at last: #{decrypted_message}"

  exit 0
end

message = get_message
print_all(n, e, d)

print "Do you wanna change n and d? (y/n)"
answer = gets.to_s.chomp

if answer == "y"
  n_arr = n.to_s.scanf("%1d"*n.size)
  d_arr = d.to_s.scanf("%1d"*d.size)

  print "Select rank in |n| where changes will be appear (#{"0 -- " + (n_arr.size-1).to_s}):"
  n_change = gets.to_i
  print "Select rank in |d| where changes will be appear (#{"0 -- " + (d_arr.size-1).to_s}):"
  d_change = gets.to_i
  print "Enter new value in |n| for this rank (0-9):"
  n_value = gets.to_i
  print "Enter new value in |d| for this rank (0-9):"
  d_value = gets.to_i

  d_arr[d_change] = d_value
  n_arr[n_change] = n_value
  n = n_arr.join.to_i
  d = d_arr.join.to_i
  print_all(n, e, d)
else
  print "\nn and d stay unchanged.\n"
end

print "Your message is '|#{message}|'\n"

encrypted_message = encrypt(message, e, n)

print "\nEncrypted message: #{(encrypted_message)}\n"
print "\nDecrypted at last: "
print "#{(decrypt(encrypted_message, n, d))}"