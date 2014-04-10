;
; Simple functions which help me control the Emacs display frame (in
; Windows simply the main window.
;
; Author: Nelson Ingersoll
; License: Gnu Public License 2.
; (c) 2009,2011

; Pre-declare functions
(declare-function nei-set-frame "nei-frame-controls.el" nil)

; Default frame values.
(defvar nei-frame-cols )
(defvar nei-frame-rows)
(defvar nei-frame-left)
(defvar nei-frame-top )

(setq nei-frame-cols 81)
(setq nei-frame-rows 40)
(setq nei-frame-left 200)
(setq nei-frame-top 60)

(defun nei-frame-set ( mytop myleft mycols myrows )
"Change the frame to whatever values set in the call.  There can be up
to 4 values coorespoinding to frame top and left position, width, and height.  Any passed value may be 0 (zero).  If a passed value is 0 then the default or current value will be used.  Ergo
.
  (nei-frame-set 0 0 0 35)
.
will only change the height for the window, aka frame."
  (interactive)
  (if (> mycols 0) (setq nei-frame-cols mycols) nil)
  (if (> myrows 0) (setq nei-frame-rows myrows) nil)
  (if (> mytop 0) (setq nei-frame-top mytop) nil)
  (if (> myleft 0) (setq nei-frame-left myleft) nil)

  (message "(nei-frame-set %d %d %d %d)" 
           nei-frame-top nei-frame-left nei-frame-cols nei-frame-rows )

  (set-frame-position (selected-frame) nei-frame-left nei-frame-top)
  (set-frame-size (selected-frame) nei-frame-cols nei-frame-rows)

  (message "Frame set to Top:%d  Left:%d  Cols:%d  Height:%d"
           nei-frame-top nei-frame-left nei-frame-cols nei-frame-rows )
)

(defun nei-restore-window ()
"Return the frame to the position dictated by the variables
nei-frame-rows, nei-frame-cols, nei-frame-left and
nei-frame-top."
  (interactive)
  (nei-frame-set nei-frame-top nei-frame-left nei-frame-cols nei-frame-rows )
  (message "Frame restored to Top:%d  Left:%d  Cols:%d  Height:%d"
           nei-frame-top nei-frame-left nei-frame-cols nei-frame-rows )
)

(defun nei-remember-frame ()
"Remember the current frames position so that it can be restored
later using the nei-restore-frame() function.  Sets the values
nei-frame-rows, nei-frame-cols, nei-frame-left and
nei-frame-top to the current frame values."
  (interactive)
  (setq nei-frame-left (frame-parameter (selected-frame) 'left))
  (setq nei-frame-top (frame-parameter (selected-frame) 'top))
  (setq nei-frame-rows (frame-parameter (selected-frame) 'height))
  (setq nei-frame-cols (frame-parameter (selected-frame) 'width))
  (message "Frame remembered as Top:%d  Left:%d  Cols:%d  Height:%d"
           nei-frame-top nei-frame-left nei-frame-cols nei-frame-rows )
)

(provide 'nei-frame-controls)
