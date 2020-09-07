;;;
;;; Test app.audacity
;;;

(use gauche.test)

(test-start "app.audacity")
(use app.audacity)
(test-module 'app.audacity)

;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




