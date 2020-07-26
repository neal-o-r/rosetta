shareLetter :: [Char] -> [Char] -> Bool
shareLetter a b = any (\x -> x `elem` b) a


countTrues list = sum $ map fromEnum list


countiesMatch :: [Char] -> [[Char]] -> Int
countiesMatch word counties = 
        let share = shareLetter word
        in countTrues $ map share counties


comparison :: [[Char]] -> [Char] -> [Char] -> [Char]
comparison counties w1 w2 =
        let (long, short) =
             if length w1 > length w2
                then (w1, w2) else (w2, w1)
        in if ((countiesMatch long counties) == 31)
                then long else short


main = do  
    counties <- readFile "../data/counties.txt"
    dictionary <- readFile "../data/enable1.txt"
    let reduce = foldl (comparison $ lines counties) ""
    print (reduce $ lines dictionary)
