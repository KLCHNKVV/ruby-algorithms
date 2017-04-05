# overrides #

class Integer < Numeric

  def prime?
    n = self.abs
    return true if n == 2
    return false if n == 1 || n & 1 == 0
    return false if n > 3 && n % 6 != 1 && n % 6 != 5

    d = n-1
    d >>= 1 while d & 1 == 0
    20.times do
      a = rand(n-2) + 1
      t = d
      y = Integer.mod_pow(a, t, n)
      while t != n-1 && y != 1 && y != n-1
        y = (y * y) % n
        t <<= 1
      end
      return false if y != n-1 && t & 1 == 0
    end
    return true
  end

  def Integer.mod_pow(base, power, mod)
    res = 1
    while power > 0
      res = (res * base) % mod if power & 1 == 1
      base = base ** 2 % mod
      power >>= 1
    end
    return res
  end
end

# overrides #