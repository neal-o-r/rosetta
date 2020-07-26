shareLetter :: [Char] -> [Char] -> Bool
shareLetter a b = any (\x -> x `elem` b) a


countTrues list = sum $ map fromEnum list


countiesMatch :: [Char] -> [[Char]] -> Bool
countiesMatch word counties = 
        let share = shareLetter word
        in ((countTrues $ map share counties) == 31)


comparison :: [[Char]] -> [Char] -> [Char] -> [Char]
comparison counties w1 w2
        | (length w1 > length w2) && (countiesMatch w1 counties) = w1
        | (length w1 < length w2) && (countiesMatch w2 counties) = w2
        | (length w1 > length w2) = w2
        | (length w1 < length w2) = w1
        | otherwise = w1


main = do  
    counties <- readFile "../data/counties.txt"
    dictionary <- readFile "../data/enable1.txt"
    let reduce = foldl (comparison $ lines counties) ""
    print (reduce $ lines dictionary)
