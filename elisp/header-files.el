;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Define customizeable variables ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcustom hf-directory "~/.emacs.d/file-templates"
  "\n   Header file directory where header files can be found."
  :group 'hf-variables
  :type '(choice (const :tag "Directory name" nil)
		 string))

(defcustom hf-file-name nil
  "\n   The name of the header file which can be found in the
Header file directory pointed to by 'hf-directory."
  :group 'hf-variables
  :type '(choice (const :tag "File name" nil)
		 string))
;
; List of file types and their cooresponding header (blank) files.
;
(setq hf-file-list '(
("\\.[cC][oO][mM]$" . "header.com")
("\\.[cC]$"         . "header.c")
("\\.[cC][oO][bB]$" . "header.cob")
("\\.[dD][cC][lL]$" . "header.dcl")
("\\.[fF][oO][rR]$" . "header.for")
("\\.[hH]$"         . "header.h")
("\\.[iI][nN][tT]$" . "header.int")
("\\.[mM][eE][mM]$" . "header.mem")
("\\.[mM][mM][sS]$" . "header.mms")
("\\.[pP][aA][sS]$" . "header.pas")
("\\.[tT][pP][uU]$" . "header.tpu")
("\\.[tT][xX][tT]$" . "header.txt")))

;;;;;;;;;;;;;;;;;;;
;;;; Functions ;;;;
;;;;;;;;;;;;;;;;;;;

(defun hf-file ()
  (interactive)
    ;; Compare the filename against the entries in hf-file-list.
    (if buffer-file-name
        (let ((name buffer-file-name))
          ;; Remove backup-suffixes from file name.
          (setq name (file-name-sans-versions name))
          (while name
        ;; Find first matching alist entry.
        (let ((case-fold-search
               (memq system-type '(vax-vms windows-nt cygwin))))
          (if (and (setq hf-file-name
                    (assoc-default name hf-file-list 'string-match))
               (consp hf-file-name)
               (cadr hf-file-name))
              (setq hf-file-name (car hf-file-name)
                name (substring name 0 (match-beginning 0)))
            (setq name)))

        (message (concat "Hf-File-Name: " hf-file-name))
))))