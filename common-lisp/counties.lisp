(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defparameter *counties* (get-file "../data/counties.txt"))
(defparameter *words* (get-file "../data/enable1.txt"))


(defun in (c s)
 (if (search (string c) (string s)) 
   T 
   Nil))


(defun string-overlap? (w1 w2)
  (some #'identity 
	(map 'list #'(lambda (c) (in c w2)) 
	     w1)))


(defun matches-n-counties (word counties)
  (count-if #'identity 
	    (map 'list #'(lambda (c) (string-overlap? word c))
	    counties)))

(defun match-31-counties? (word counties)
  (= 31 (matches-n-counties word counties)))


(defun matches (words counties)
  (remove-if-not #'(lambda (w) 
		     (match-31-counties? w counties)) words))


(print 
  (car (sort (matches *words* *counties*)
	     '> :key #'length))
  )
