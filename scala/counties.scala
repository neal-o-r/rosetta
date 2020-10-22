import scala.io.Source

object Counties {
  def sharedCharacter(a: String)(b: String):Int = {
    for (c <- a) {
      if (b.contains(c)) {
        return 1
      }
    }
    return 0
  }

  def count_county_matches(word: String, counties: Array[String]):Int = {
    return counties.iterator.map(sharedCharacter(word)(_)).sum
  }

  def comparator(counties: Array[String])(w1: String, w2: String):String = {
    if ((w1.length > w2.length) && (count_county_matches(w1, counties) == 31)){
      return w1
    } else if ((w1.length < w2.length) && (count_county_matches(w2, counties) == 31)){
      return w2
    } else {
      return w1
    }

  }

  def main(args: Array[String]):Unit = {
    val counties = Source.fromFile("../data/counties.txt").getLines.toArray
    val words = Source.fromFile("../data/enable1.txt").getLines.toArray

    val longest = words.foldLeft("")(comparator(counties))
    println(longest)
  }

}
