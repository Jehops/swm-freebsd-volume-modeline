;; swm-freebsd-volume-modeline.lisp
;;
;; Put %v in your modeline format string to show the current speaker volume.
;;

(in-package #:swm-freebsd-volume-modeline)

(defvar *vol-level* -1)
(defvar *vol-prev-time* 0)

(defun fmt-freebsd-volume-modeline-percent (ml)
  "Return the speaker volume."
  (declare (ignore ml))
  (let ((now (/ (get-internal-real-time) internal-time-units-per-second)))
    (when (or (= 0 *vol-prev-time*) (>= (- now *vol-prev-time*) 5))
      (setf *vol-prev-time* now)
      (setf *vol-level*
	    (string-trim
	     '(#\Space #\Tab #\Newline)
	     (stumpwm::run-prog-collect-output
	      stumpwm::*shell-program* "-c"
	      "/usr/sbin/mixer -s vol | sed 's/vol [0-9]*://'")))))
  (format nil "~a" *vol-level*))

;; Install formatter
(stumpwm::add-screen-mode-line-formatter #\v #'fmt-freebsd-volume-modeline-percent)