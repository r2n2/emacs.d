;; Attempt to load the COBOL copylib under the cursor.
;; For the moment this DOES not check to see if the lib file
;; actually exists.  It also only works with my VMS account.
(defun nei-load-copylib ()
  (interactive)
  (find-file-read-only
     (concat "~/Documents/Programming/CMTLIB/"
             (nei-current-word) ".COB")))

;     (concat "/ningersoll@poplar.cso.atmel.com:/DSA1:/ISCUSTOM/COMETS_COPYLIB/"
;             (nei-current-word) ".LIB")))

;     (concat "/ningersoll@poplar.cso.atmel.com:WORK/X_COPYLIB/"
;             (nei-current-word) ".LIB")))

;; This function was snatched from a gnu.emacs.help post.
(defun nei-current-word ()
   "Word cursor is over, as a string."
   (save-excursion
      (let (beg end)
         (re-search-backward "\\w" nil 2)
         (re-search-backward "\\b" nil 2)
         (setq beg (point))
         (re-search-forward "\\w*\\b" nil 2)
         (setq end (point))
         (buffer-substring beg end))))

(global-set-key "\C-co" 'nei-load-copylib)

(provide 'nei_load_copylib)
