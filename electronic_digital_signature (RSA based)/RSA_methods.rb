def n_to_s(n)
  s = ""
  while n > 0
    s = (n & 0xFF).chr + s
    n >>= 8
  end
  return s
end

def s_to_n(s)
  n = 0
  s.each_byte do |b|
    n = n * 256 + b
  end
  return n
end

def random_number(bits)
  m = (1..bits-2).map { rand() > 0.5 ? '1' : '0' }.join
  s = "1" + m + "1"
  s.to_i(2)
end

def random_prime(bits)
  begin
    n = random_number(bits)
    return n if n.prime?
  end while true
end

def euler_func(a, b)
  (a-1)*(b-1)
end

def euclidean_algorithm(a, b)
  return [0, 1] if a % b == 0
  x, y = euclidean_algorithm(b, a % b)
  [y, x - y * (a / b)]
end

def get_d(p, q, e)
  n = euler_func(p, q)
  d, y = euclidean_algorithm(e, n)
  d += n if d < 0
  return d
end

def encrypt(m, e, n)
  m = s_to_n(m)
  Integer.mod_pow(m, e, n)
end

def decrypt(c, n, d)
  m = Integer.mod_pow(c, d, n)
  n_to_s(m)
end

def generate_keys(bits)
  n, e, d = 0
  p = random_prime(bits)
  q = random_prime(bits)
  n = p * q
  d = get_d(p, q, E)
  [n, E, d]
end

def get_e
  pe = [257, 65537]
  print "Choose public exponent E (#{pe.inspect}), enter index (#{"1 -- " + (pe.size).to_s}): "
  choose = gets.to_i
  e = pe[choose-1]
  return e
end

def generate_new_keys(bits)
  n, d = 0
  p = random_prime(bits)
  q = random_prime(bits)
  n = p * q
  d = get_d(p, q, E)
  return [n, d]
end

def print_all(n, e, d)
  print "Public e (number that < euler_func(n) and gcd(euler_func(n) = 1) == " + e.to_s + "\n"
  print "Key n size = #{n.size}\n"
  print "Public n (n = p * q) == " + n.to_s + "\n"
  print 'Private d (third part of key) == ' + d.to_s + "\n"
end

def get_p_and_q
  print "Enter p: "
  p = gets.to_i
  while !p.prime? do
    print "According to RSA standards p need to be prime number. Re-enter it, please: "
    p = gets.to_i
  end
  print "Enter q: "
  q = gets.to_i
  while !q.prime? do
    print "According to RSA standards q need to be prime number. Re-enter it, please: "
    q = gets.to_i
  end
  return p, q
end

def get_message
  print "\nEnter Message, please: \n"
  message = gets.chomp
  return message
end