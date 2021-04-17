use std::path::Path;
use std::fs::File;
use std::io::{BufRead, BufReader};


fn readfile(fname: &str) -> Vec<String> {
   // read a file into a vec of strings

    let fpath = Path::new(fname);
    let f = File::open(&fpath)
                .expect("Couldn't open file");

    let mut contents: Vec<String> = Vec::new();
    for line in BufReader::new(f).lines() {
        contents.push(line.unwrap());
    }

    return contents
}

fn shares_char(a: &str, b: &str) -> bool {
    // do two strings share a character?
    a.chars().any(|x| b.contains(x))
}

fn count_county_matches(word: &str, counties: &Vec<String>) -> usize {
    // how many counties match a given word
   counties.iter().filter(|x| shares_char(x, word)).count()
}

fn longest_match(words: Vec<String>, counties: Vec<String>) -> String {
    let mut longest = String::new();

    // I would have prefered to write this as an iter with a closure 
    // (as in the fn above), but I got an odd borrow error that I couldn't parse
    // so I've written it imperatively
    for word in words {
        if count_county_matches(&word, &counties) == 31 {
            longest += &word;
            break;
        }
    }
    return longest;
}

fn usage() {
    let name = env!("CARGO_PKG_NAME");
    println!("{}", name);
    println!("Usage: {} [counties file] [word file]", name);
}

fn solve(counties_fname: &str, words_fname: &str) {
    let counties = readfile(counties_fname);
    let mut words = readfile(words_fname);

    words.sort_by(|a, b| b.len().cmp(&a.len()));

    println!("{}", longest_match(words, counties));
}


fn main() {

    let args: Vec<String> = std::env::args().collect();
    match args.len() {
        3 => solve(&args[1], &args[2]),
        _ => usage(),
    }

}
