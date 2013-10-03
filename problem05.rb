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


max_prime = 20
$prime_list = iter_prime_gen([2],max_prime)


def get_factors(num)
	fact_list = []
	temp_num = num
	until temp_num == 1
		$prime_list.inject(temp_num) do |reduct, item|
			if temp_num%item == 0
				fact_list << item
				temp_num /= item
				break
			elsif item == $prime_list[-1]
				$prime_list = iter_prime_gen($prime_list, temp_num)
			end
		end
	end
	fact_list
end

#puts get_factors(30)
#puts get_factors(198)

# Return all factors necessary to create each number
# Eg, [2,2,2,2] and [2,2,3,5] would return [2,2,2,2,3,5]
def reduce_factors(fact_list1, fact_list2)
	if (not fact_list1.is_a?(Array) or not fact_list2.is_a?(Array))
		exit
	end
	ret_list = []
	count1 = 0
	count2 = 0

	until fact_list1.empty?
		length1 = fact_list1.length()
		length2 = fact_list2.length()
		reject1 = fact_list1[0]
		count1 = length1 - fact_list1.reject! {|i| i == reject1}.length()
		#fact_list2 = fact_list2.reject {|i| i == reject1}
		#count2 = length2 - fact_list2.length()
		count2 = length2 - fact_list2.reject! {|i| i == reject1}. length()
		max = count1 > count2 ? count1:count2
		max.times do ret_list << reject1 end
	end
	if not fact_list2.empty?
		ret_list.concat(fact_list2)
	end
	ret_list.sort()
end

#puts reduce_factors(get_factors(20),get_factors(30))
#puts reduce_factors(get_factors(20),get_factors(300))

# find the least common multiple in a range of numbers
def least_common_mult(range_start, range_end)
	ret_list = []
	range_start.upto(range_end) do |num| 
		ret_list = reduce_factors(ret_list, get_factors(num))
	end
	ret_list.inject(1) do | num, item |
		num *= item
		num
	end

end

puts least_common_mult(1, 20)
