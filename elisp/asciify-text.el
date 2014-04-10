(defun asciify-text ( string &optional  from  to)
"Change some Unicode characters into equivalent ASCII ones.
For example, �pass� becomes �passe�.

This function works on chars in European languages, and does not
transcode arbitrary Unicode chars (such as Greek, math symbols).
Un-transformed unicode char remains in the string.

When called interactively, work on text selection or current block.

When called in lisp code, if from is nil, returns a changed
string, else, change text in the region between positions from
to."
  (interactive
   (if (region-active-p)
       (list nil (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list nil (car bds) (cdr bds)) ) ) )

  (require 'xfrp_find_replace_pairs)

  (let (workOnStringP
        inputStr
        (charChangeMap [
                        ["�\\|�\\|�\\|�\\| \\|�" "a"]
                        ["�\\|�\\|�\\|�" "e"]
                        ["�\\| \\|�\\|�" "i"]
                        ["�\\| \\|�\\|�\\| \\|�" "o"]
                        ["�\\|�\\|�\\|�"     "u"]
                        [" \\| \\|�"     "y"]
                        ["�" "n"]
                        ["�" "c"]
                        [" " "d"]
                        [" " "th"]
                        ["�" "ss"]
                        ["�" "ae"]
                        ])
        )
    (setq workOnStringP (if  from nil t))
    (setq inputStr (if workOnStringP  string (buffer-substring-no-properties  from  to)))
    (if workOnStringP
        (let ((case-fold-search t)) (replace-regexp-pairs-in-string inputStr charChangeMap) )
      (let ((case-fold-search t)) (replace-regexp-pairs-region  from  to charChangeMap) )) ) )
