(require '[clojure.string :as str])

(defn readfile-linesplit [filename]
  (list* (str/split-lines (slurp filename)))
  )

(def counties (readfile-linesplit "../data/counties.txt"))
(def words (readfile-linesplit "../data/enable1.txt"))


(defn longest [a b]
  (if (> (count a) (count b)) a b)
  )


(defn share-letters? [a b] 
  (boolean (some true? (map #(str/includes? b (str %)) a)))
  )


(defn share-counties? [word counties]
  (map #(share-letters? % word) counties)
  )


(defn count-trues [bools]
  ((frequencies bools) true) 
  )


(defn bool-filter [lst bools]
  (for [x (map vector lst bools) :when (not (second x))] (first x))
  )

(defn count-share-counties [word counties]
  (count-trues (share-counties? word counties))
  )


(defn longest-mackerel [words counties]
  (def mackerels (filter #(= (count-share-counties % counties) 31) words))
  (reduce longest mackerels)
  )

(print (longest-mackerel words counties))
