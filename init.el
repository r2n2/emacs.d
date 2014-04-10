;; .Emacs file for Nelson Ingersoll
;;
;; Set up my key bindings.
;;
;; NOTE: Nelson, you can test changes while still editing the .emacs
;;       buffer by issuing the meta-X command eval-buffer which will
;;       compile the buffer and make all changes available.
;;       Thu 2003.07.31 10:48:12 NEI
;;
;;============================================================================
;; Windows font notes:
;;     Quick-n-dirty way to pick and set/test new fonts in Windows.
;;
;;  Execute this (insert (prin1-to-string (w32-select-font))) in the
;;  *scratch* buffer.  Select a font.  Take the resulting string and
;;  put it in place of the XXXXX in the following string:
;;
;;   (set-default-font XXXXX )
;;
;;  and execute that code.  That will set the default font.
;;
;;============================================================================

(message "\n==========================================================")
(message "Starting Nelson's init.el")
(message "==========================================================")
(message         "Op System:   %s" system-type)
(message         "System Name: %s" system-name)
(message (concat "TERMinal:    " (getenv "TERM")))
(message "==========================================================\n")

(server-start)

; Use Unix line endings by default!
(setq default-buffer-file-coding-system 'utf-8-unix)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  )

;(semantic-mode 1)
;(ecb-activate)

;; This is where I put my personal lisp files.
(add-to-list 'load-path "~/.emacs.d/elisp")

;; This is where 'local' Info files are put.
(add-to-list 'Info-default-directory-list "~/.emacs.d/info")

;; Initial mode.
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

(tool-bar-mode -1)   ; Do we like the toolbar?  NO!

;; Miscellaneous startup settings.
(setq inhibit-startup-message t)
(setq user-mail-address "nelson_ingersoll@where.ever.com")
(setq user-full-name "Nelson E. Ingersoll")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(setq tab-width 3) ; or any other preferred value


;; ============== Specific key-sequences for Nelson! ==============
(global-set-key "\C-b" 'backward-word)
(global-set-key "\C-f" 'forward-word)
(global-set-key "\C-cf" 'find-file-at-point)
(global-set-key "\C-x\C-i" 'insert-file)
(global-set-key "\C-\\" 'delete-trailing-whitespace)
(global-set-key "\M-\\" 'delete-horizontal-space)
(global-set-key [f5] 'sql-oracle)
(global-set-key [f6] 'occur)

;; Perlcritic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(defvar perlcritic-buffer)
(autoload 'perlcritic-mode   "perlcritic" "" t)
;; End PerlCritic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Perltidy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun perltidy ()
  "Run perltidy on the current region or buffer."
  (interactive)
  (save-excursion
    (unless mark-active (mark-defun))
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(global-set-key "\C-ct" 'perltidy)
;; End Perltidy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "sql"
  '(load-library "sql-indent"))

;; Session Setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'session)
       (add-hook 'after-init-hook 'session-initialize)
;; --- end Session Setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; uniquify-region from
;;   http://everything2.com/title/useful%2520emacs%2520lisp%2520functions
(defun uniquify-region ()
  "remove duplicate adjacent lines in the given region"
  (interactive)
  (narrow-to-region (region-beginning) (region-end))
  (beginning-of-buffer)
  (while (re-search-forward "\\(.*\n\\)\\1+" nil t)
    (replace-match "\\1" nil nil))
  (widen)
  nil
)

(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insert a date/time stamp at point.
;; Picked up code fragment in USENET group "comp.emacs.xemacs".
(setq nei-datetime-format "%Y.%m.%d %H:%M")
(setq nei-time-format "%l:%M %P")
(defun insert-datetime-here ()
  (interactive)
  (insert (format-time-string nei-datetime-format)))
;;
(defun insert-time-here ()
  (interactive)
  (insert (format-time-string nei-time-format)))
(global-set-key "\C-x\\" 'insert-datetime-here)
(global-set-key "\C-x\|" 'insert-time-here)
;; --- end Setup special date/time bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Frame controls.
(require 'nei-frame-controls)

(global-set-key "\C-cwr" 'nei-restore-window)
(global-set-key "\C-cws" 'nei-remember-frame)
(global-set-key "\C-cwo" (lambda () (interactive)
                           (nei-frame-set 55 300 81 45)))
(global-set-key "\C-cwn" (lambda () (interactive) (nei-frame-set 0 0 80 0)))
(global-set-key "\C-cww" (lambda () (interactive) (nei-frame-set 0 0 133 0)))
(global-set-key "\C-cw3" (lambda () (interactive) (nei-frame-set 0 0 0 35)))
(global-set-key "\C-cw4" (lambda () (interactive) (nei-frame-set 0 0 0 40)))
(global-set-key "\C-cw5" (lambda () (interactive) (nei-frame-set 0 0 0 45)))
(global-set-key "\C-cw6" (lambda () (interactive) (nei-frame-set 0 0 0 50)))
(global-set-key "\C-cwp" (lambda () (interactive) (nei-frame-set 65 4 130 90)))
;;; end Load Frame controls ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;############################################################################
;;#### org-mode setup ########################################################
;;############################################################################
;o;(add-to-list 'load-path "~/.emacs.d/elisp/org")

(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; Some adjustments to org.el
(setq org-todo-keywords '("TODO" "PROJ" "MEET" "NOTE" "ONGO" "Tick" "DONE")
      org-todo-interpretation 'sequence)
(setq org-lowest-priority ?D)
(setq org-startup-folded t)
(setq org-hide-leading-stars t)
;
(global-set-key "\C-ct" 'org-insert-todo-heading)
(setq nei-TODO-header-format "** %Y.%m.%d-%A")
(setq nei-date-format "* %Y.%m.%d")

;; Insert normal Org day entry.
(global-set-key "\C-x\C-\\" 'insert-TODO-header-here)
(defun insert-TODO-header-here ()
  (interactive)
;dt;  (if (string-match "Sunday" (format-time-string nei-TODO-header-format))
  (if (string-match "Monday" (format-time-string nei-TODO-header-format))
      (insert (format-time-string nei-date-format) "\n") nil )
  (insert (format-time-string nei-TODO-header-format))
  (insert " [ ]")
;;  (insert "\n*** TODOs\n")
)

;; Load TODOs.org data file.
(global-set-key [f9] 'nei-open-TODO-file)
(defun nei-open-TODO-file ()
  (interactive)
;  (find-file "~/Share/org/DailyLog.org"))
  (find-file "\\\\coqc2dntoeng029\\Share\\org\\DailyLog.org"))

;; Load Projects.org data file.
(global-set-key [f10] 'nei-open-PROJECTS-file)
(defun nei-open-PROJECTS-file ()
  (interactive)
  (find-file "~/.emacs.d/org/Projects.org")
)

;; Load Personal.org data file.
(global-set-key [f11] 'nei-open-PERSONAL-file)
(defun nei-open-PERSONAL-filexx ()
  (interactive)
  (find-file "~/.emacs.d/org/Personal.org")
)

;; Insert Org-mode "*** timestamp" diary line.
(global-set-key "\C-cv" 'nei-insert-diary-timestamp)
(defun nei-insert-diary-timestamp ()
  (interactive)
  (insert (concat "*** " (format-time-string nei-datetime-format) "; \n" ))
  (move-end-of-line -0)
)

(set-default-font "DejaVu Sans Mono-11" )
(setq nei-frame-top 65 )
(setq nei-frame-left 300 )
(setq nei-frame-cols 100 )
(setq nei-frame-rows 55 )
(nei-restore-window)

;;### end org-mode setup #####################################################

;;## Set up goto last change #################################################
(autoload 'goto-last-change "goto-last-change"
 	  "Set point to the position of the last change." t)
(global-set-key "\C-x?" 'goto-last-change)

(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)

;(color-theme-solarized-light)
(color-theme-solarized-dark)

; Where all backups are centralized and NOT in Google Drive!
(setq backup-directory-alist '(("." . "~/.emacs_backups/")))

(setq line-number-mode t)
(setq column-number-mode t)

(autoload 'folding-mode          "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)

;;============================================================================
;;============== End standard .emacs - Start OS specific .emacs ==============
;;============================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Windows specific setup values
(defun windows_setup ()
  (message "Executing Windows-NT Emacs initialization")

  ;; Set a nice font for Windows
  (set-default-font "DejaVu Sans Mono-11" )

  (if (equal system-name "COQC2LNTOENG074")
      ; Special case when running emacs on my laptop.

      (progn
        (set-default-font "DejaVu Sans Mono-11" )
        (setq nei-frame-top 55 )
        (setq nei-frame-left 300 )
        (setq nei-frame-cols 81 )
        (setq nei-frame-rows 45 )
        (nei-restore-window)
       )
   )

  (add-to-list 'load-path "~/.emacs.d/elisp/EmacsW32/lisp")
  (require 'emacsw32)

  ; Alt key presses are passed on to Windows.
  (setq-default w32-pass-alt-to-system t)

  ; Cygwin bin directory location.
  (setq w32shell-cygwin-bin "C:/cygwin/bin")

  ; Window look
  (menu-bar-mode 1) ; Turn ON drop down menu.
  (tool-bar-mode 0) ; Turn OFF tool bar.

  ;; Set a nice font for Windows
  (set-default-font "DejaVu Sans Mono-11" )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tramp nonsense (I hate tramp - too much trouble on Windows.)
  (require 'tramp)
  ;DBG;(setq tramp-debug-buffer t) ; To debug tramp issues.
  ;DBG;(setq tramp-verbose 10)     ; To debug tramp issues.
  (setq tramp-default-method "plink")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;  (set-default-font "Inconsolata-14:medium")
;  (set-frame-font "Courier New-12")

  ; ISpell
  (setq-default ispell-program-name "C:/Program Files (x86)/Aspell/bin/aspell")
  (ispell-change-dictionary "english" t)
  (global-set-key "\C-cs" 'ispell-buffer)
  (global-set-key "\C-cS" 'ispell-region)

  ;;====== Don't MESS with the following... please. =======================
  (custom-set-variables
   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(blink-matching-paren-on-screen t)
   '(case-fold-search t)
   '(confirm-kill-emacs (quote yes-or-no-p))
   '(current-language-environment "Latin-1")
   '(default-input-method "latin-1-prefix")
   '(global-font-lock-mode t nil (font-lock))
   '(mouse-avoidance-mode (quote jump) nil (avoid))
   '(perl-tab-to-comment t)
   '(show-paren-mode t nil (paren))
   '(show-paren-mode-hook nil)
   '(show-paren-style (quote parenthesis))
   '(show-trailing-whitespace t)
   '(transient-mark-mode t)
   '(uniquify-buffer-name-style nil nil (uniquify))
   )
  ;;---------------------------------------------------------------------------
  (setq default-directory "~/")
  (message "Finished Windows-NT Emacs initialization")
  (message "==========================================================")
)
;; --- end Windows specific setup values ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Unknown setup.   Generally this is *NIX of some flavor.
;;
(defun unknown_setup ()
  (message (concat "Executing 'Unknown' Emacs initialization" system-name) )
  (custom-set-variables
   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(blink-matching-paren-on-screen t)
   '(case-fold-search t)
   '(current-language-environment "Latin-1")
   '(default-input-method "latin-1-prefix")
   '(global-font-lock-mode t nil (font-lock))
   '(perl-tab-to-comment t)
   '(show-paren-mode t nil (paren))
   '(show-paren-mode-hook nil)
   '(show-paren-style (quote parenthesis))
   '(show-trailing-whitespace t)
   '(transient-mark-mode t)
   '(uniquify-buffer-name-style nil nil (uniquify)))

  (require 'tramp)
  (setq tramp-default-method "ssh")

  ; ISpell
  (setq-default ispell-program-name "/usr/bin/aspell")
  (ispell-change-dictionary "english" t)
  (global-set-key "\C-cs" 'ispell-buffer)
  (global-set-key "\C-cS" 'ispell-region)
  (set-default-font "DejaVu Sans Mono-11" )
  (message "Finished 'Unknown' Emacs initialization")
  (message "==========================================================")
)
;; End Unknown setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Now, figure out the OS and run special setup accordingly.
(if (equal system-type 'windows-nt )
    (progn
      (message "Windows-NT")
      (windows_setup))
  (unknown_setup)
)

(message "Finished Nelson's init.el")
(message "==========================================================")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Anything past this point was put in here by Emacs, typically as a
;; CUSTOMIZATION.  Steal the appropriate value settings, transmogrify
;; them, and delete the rest of this effluent.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren-on-screen t)
 '(case-fold-search t)
 '(confirm-kill-emacs (quote yes-or-no-p))
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(ecb-options-version "2.40")
 '(global-font-lock-mode t nil (font-lock))
 '(mouse-avoidance-mode (quote jump) nil (avoid))
 '(perl-tab-to-comment t)
 '(show-paren-mode t nil (paren))
 '(show-paren-mode-hook nil t)
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace t)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style nil nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
