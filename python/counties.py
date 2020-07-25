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


def counties_overlap(word: Word, county: County) -> int:
    return sum(overlap(word, county) for county in counties)


def longest_w_one_overlap(wordlist: Wordlist, counties: Counties) -> Word:
    return max(
        filter(lambda w: counties_overlap(w, counties) == 31, wordlist), key=len
    )


if __name__ == "__main__":

    words = read_file("../data/enable1.txt")
    counties = read_file("../data/counties.txt")

    print(longest_w_one_overlap(words, counties))
