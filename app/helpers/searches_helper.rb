module SearchesHelper

		def comma_separate(total)
		total.to_s
		length = total.length
		if length <= 3
			return total 
		elsif length <= 6
			total = total.insert(-4, ",")
		else 
			total = total.insert(-4, ",").insert(-8, ",")
		end
	end
	
end
