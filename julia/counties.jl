function read_file(fname::String) ::Array{String, 1}
	lines = open(fname) do f
		readlines(f)
	end
	return lines
end


function shared_character(a::String, b::String)::Bool

	for c in a
		if occursin(c, b)
			return true
		end
	end
	return false

end


function count_county_matches(word::String, counties::Array{String, 1})::Int
	return count([shared_character(word, c) for c in counties])
end


function longest_match(words::Array{String, 1}, counties::Array{String, 1})::String
	longest = "" 
	len = 0
	for word in words
		if (count_county_matches(word, counties) == 31) & (length(word) > len)
			longest = word
			len = length(word)
		end
	end
	return longest
end


function main()
	
	words = read_file("../data/enable1.txt")
	counties = read_file("../data/counties.txt")

	longest = longest_match(words, counties)
	println("$longest \n")

end


main()
