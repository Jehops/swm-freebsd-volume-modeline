;;;; swm-freebsd-volume-modeline.asd

(asdf:defsystem #:swm-freebsd-volume-modeline
  :description "Show the speaker volume in the StumpWM modeline"
  :author "Joseph Mingrone <jrm@ftfl.ca>"
  :license "2-CLAUSE BSD (see COPYRIGHT file for details)"
  :depends-on (#:stumpwm)
  :serial t
  :components ((:file "package")
               (:file "swm-freebsd-volume-modeline")))

