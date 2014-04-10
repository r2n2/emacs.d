;;;------------------------------------------------------------------------
;;; first some utilities mimicking perl functions
;;; written by Philip lijnz...@ebi.ac.uk

;;; (first some multiple-value things; mvals are, of course, just lists
;;; cf perl ($a, $b, $c) = @d;

(if (fboundp 'values)
    nil
  (defalias 'values 'list))
(if (fboundp 'multiple-value-setq)
    nil
  (defmacro multiple-value--setq (destination source);; &rest rest ??
  "assign each element of list SOURCE to each respective symbol of list
DESTINATION. SOURCE is evaluated, DESTINATION is not.  Surplus symbols will
become nil, surplus source elements are discarded. Returns nil. Eg.
        (multiple-value-setq (a b c) (cdr (list 1 2 4 8))) => nil
        a => 2,  b => 4, c => 8
This is similar to Common Lisp's multiple-value-setq, and to perl's
list assignment `($a, $b, $c) = @d'. Dave Gillespie's implementation in the
cl package  is infinitely better, though"
  (` (let ((dest '(, destination))      ;can't do this simpler: we need copy as
  (src (, source)))                     ;we can't mess with values of args
       (while dest
       (set (car dest) (car src))
       (setq dest (cdr dest)
             src (cdr src)))))))

;;; replace this by emacs' own split-string !
(defun split (string re &optional keep)
  "splits STRING into a list of strings using regular expression RE (a la
perl's split). If KEEP is non-nil, RE is not deleted from the string
endings. Note that one backslash-literal in an RE is represented by 4
backslashes in the string representing it"
  (let (l b e)
    (while (setq b (string-match re string))
      (setq e (match-end 0)
            l (cons (substring string 0 (if keep e b)) l)
            string  (substring string e )))
    (append (nreverse l) (cons string nil))))

(defun join (list sep)
  "joins LIST of strings into one string using separator string SEP"
  (mapconcat #'(lambda (x) x) list sep))

;;; horribly inefficient ! use emacs' own replace-string or
;;;   (while (search-forward FROM-STRING nil t)
;;;    (replace-match TO-STRING nil t)) !!!!
(defun string-substitute (string old new)
  "In STRING, replace all occurrences of string OLD (a regular expression) to
string NEW. See also split"
  (join (split string old) new))

;;;------------------------------------------------------------------------

;;; now the real stuff
;;; stuff to insert a range of numbers in whichever format.
;;; written by Philip lijnz...@ebi.ac.uk

(defun make-range (from to &optional step)
  "contructs a list of numbers running from FROM to TO (inclusive). If STEP is
  given increments (decrements) by that amount; otherwise, by one"
  (let* ((l nil)
         (i from)
         (reverse (> from to))
         (operator (if reverse '> '<))
         (stepsize (* (if step (abs step) 1) (if reverse -1 1) )))
    (if (zerop stepsize) (error "make-range: zero step size"))
    (while (funcall operator i to)
      (setq l (cons i l))
      (setq i (+ i stepsize)))
    (nreverse l)))

(defun insert-range (string &optional fmt)
  "insert a range of numbers specified by STRING at current point. A `%d' (or
so) in the format FMT indicates the position of the numeric variable; if
FMT is not specified, \"%s \" is taken. See also built-in function
format. ``\\n''is interpreted as meaning NEWLINE."

  (interactive "sfrom to [step]:\nsformat(%%s ):")
  (let ((from nil) (to nil) (step nil))
    (multiple-value-setq (from to step)
               (mapcar 'string-to-number (split string " ")))
    (if (not (and from to))
        (error "specify lower and upper bound, eg. \"0 10\""))
    (if (null step)
        (setq step 1))                  ;only needed for proper message
    (if (or (null fmt)                  ;when using it from within emacs
            (zerop (length fmt)))       ;when hitting return upon M-x insert-r.
        (setq fmt "%s ")
      (or (string-match "%" fmt)
          (error "format does not contain specifier (eg., %%d)")))
    ;;; user's '\n' is read as "\\n", so translate to newline, for convenience
    (if (string-match "\\n" fmt)      ;common, so support this
        (setq fmt (string-substitute fmt "\\\\n" "\n")))
    (mapcar (lambda (x)
              (insert (format fmt x)))
            (make-range from to step))
    (message "range from %d to %d step %d using format \"%s\""
             from to step fmt)))

(provide 'insert-range) 