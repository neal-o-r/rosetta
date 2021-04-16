import Data.List

shareLetter :: [Char] -> [Char] -> Bool
shareLetter a b = any (\x -> x `elem` b) a

countTrues list = sum $ map fromEnum list

countiesMatch :: [[Char]] -> [Char] -> Bool
countiesMatch counties word = 
        let share = shareLetter word
        in ((countTrues $ map share counties) == 31)


--comparison :: [[Char]] -> [Char] -> [Char] -> [Char]
--comparison counties w1 w2
--        | (length w1 > length w2) = w1
--        | (length w1 < length w2) && (countiesMatch w2 counties) = w2
--        | otherwise = w1


sortByLength :: [[Char]] -> [[Char]]
sortByLength = sortBy (\a b -> compare (length b) (length a))

main = do  
    counties <- readFile "../data/counties.txt"
    dictionary <- readFile "../data/enable1.txt"
    let match = countiesMatch (lines counties)
    let longest = head $ filter match (sortByLength (lines dictionary))
    print longest
