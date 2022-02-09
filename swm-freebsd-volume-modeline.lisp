;; swm-freebsd-volume-modeline.lisp
;;
;; Put %v in your modeline format string to show the current speaker volume.
;;

(in-package #:swm-freebsd-volume-modeline)

(defvar *vol-percent* 0)
(defvar *vol-stream* nil)

(defun set-vol-stream ()
  (setf *vol-stream*
	(sb-ext:process-output
	 (sb-ext:run-program "ml_vol.sh" nil
			     :output :stream
			     :search t
			     :wait nil))))

(defun fmt-freebsd-volume-modeline-percent (ml)
  "Return the speaker volume."
  (declare (ignore ml))
  (when (not *vol-stream*)
    (set-vol-stream))
  (when (listen *vol-stream*)
    (setf *vol-percent* (read-line *vol-stream* nil "")))
  (format nil "~1,2f" *vol-percent*))

;; Install formatter
(stumpwm::add-screen-mode-line-formatter #\v #'fmt-freebsd-volume-modeline-percent)

