from typing import List


County = str
Counties = List[County]
Word = str
Wordlist = List[Word]


def read_file(filename: str) -> List[str]:
    with open(filename, "r") as f:
        data = [w.lower().strip("\n") for w in f.readlines()]
    return data


def overlap(a: Word, b: Word) -> bool:
    return any(letter in b for letter in a)


def counties_overlap(word: Word, counties: County) -> int:
    return sum(overlap(word, county) for county in counties)


def longest_w_one_overlap(words, counties):
    match = lambda x: counties_overlap(x, counties) == 31
    return next(filter(match, sorted(words, key=len, reverse=True)))


if __name__ == "__main__":

    words = read_file("../data/enable1.txt")
    counties = read_file("../data/counties.txt")

    print(longest_w_one_overlap(words, counties))
