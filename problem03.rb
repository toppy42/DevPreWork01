require 'benchmark'

# generate primes up to a specific number
def prime_gen(num)
	prime_array = [2]
	3.upto(num) do |x|
		prime = true
		prime_array.each do |member|
			prime &= (0 != x % member)
			if not prime
				break
			end
		end
		if prime == true
			prime_array << x
		end
	end
	prime_array
end


#puts prime_gen(100)

# generate primes using a sieve
def prime_gen_reduct(num)
	full_array = []
	primes = []
	2.upto(num) {|x| full_array << x}
	while not full_array.empty?
		recent = full_array[0]
		primes << recent
		full_array.reject! {|x| x%recent==0}
	end
	primes
end

# n = 100000
# Benchmark.bm do |x|
# 	x.report {prime_gen(n)}
# 	x.report {prime_gen_reduct(n)}  #faster
# end

# take an array of primes and return list of additional up to num
# assumes it will only be passed a full array of primes
# also uses a sieve
def iter_prime_gen(primes_ary, num)
	full_array=[]
	new_primes = []
	if primes_ary[-1] >= num
		return primes_ary
	end
	primes_ary[-1].upto(num) {|x| full_array << x}
	until full_array.empty?
		recent = full_array[0]
		new_primes << recent
		full_array.reject! {|x| x%recent==0}
	end
	new_primes
end

global_prime = [2]

#puts iter_prime_gen(global_prime,10)

 def largest_prime(num)
	primes_array = [2]
	array_copy = primes_array.dup
	found = false

	while found==false
		# add response from iter_prime_gen to primes arry and array_copy
		new_primes = iter_prime_gen(primes_array, primes_array[-1] * 10)
		primes_array += new_primes
		array_copy += new_primes


		until array_copy.empty?
			first = array_copy[0]
			if first == num
				found = true
				break
			elsif num%first == 0
				num /= first
			else
				array_copy.shift
			end
		end
	end
	num
 end

 puts largest_prime(12345)
 puts largest_prime(600851475143)

