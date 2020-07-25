import Data.Ord
import Data.List


shareLetter :: [Char] -> [Char] -> Bool
shareLetter a b = any (\x -> x `elem` b) a


countTrues list = sum $ map fromEnum list


countiesMatch :: [Char] -> [[Char]] -> Int
countiesMatch word counties = 
        let share = shareLetter word
        in countTrues $ map share counties


matchPredicate :: [[Char]] -> [Char] -> Bool
matchPredicate counties word = 31 == (countiesMatch word counties)


matchingWords :: [[Char]] -> [[Char]] -> [[Char]]
matchingWords dictionary counties =
        let pred = matchPredicate counties
        in filter pred dictionary


longest :: [String] -> String
longest = maximumBy (comparing length)

main = do  
    counties <- readFile "../data/counties.txt"
    dictionary <- readFile "../data/enable1.txt"
    print . longest $ matchingWords (lines dictionary) (lines counties)
