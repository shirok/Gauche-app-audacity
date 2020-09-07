;;
;; Package Gauche-app-audacity
;;

(define-gauche-package "Gauche-app-audacity"
  ;; 
  :version "0.1"

  ;; Description of the package.  The first line is used as a short
  ;; summary.
  :description "Control Audacity via scripting interface\n"

  ;; List of dependencies.
  ;; Example:
  ;;     :require (("Gauche" (>= "0.9.5"))  ; requires Gauche 0.9.5 or later
  ;;               ("Gauche-gl" "0.6"))     ; and Gauche-gl 0.6
  :require ()

  ;; List of providing modules
  ;; NB: This will be recognized >= Gauche 0.9.7.
  ;; Example:
  ;;      :providing-modules (util.algorithm1 util.algorithm1.option)
  :providing-modules (app.audacity)
  
  ;; List name and contact info of authors.
  ;; e.g. ("Eva Lu Ator <eval@example.com>"
  ;;       "Alyssa P. Hacker <lisper@example.com>")
  :authors ("Shiro Kawai <shiro@acm.org>")

  ;; List name and contact info of package maintainers, if they differ
  ;; from authors.
  ;; e.g. ("Cy D. Fect <c@example.com>")
  :maintainers ()

  ;; List licenses
  ;; e.g. ("BSD")
  :licenses ("BSD")

  ;; Homepage URL, if any.
  ; :homepage "http://example.com/Gauche-app-audacity/"

  ;; Repository URL, e.g. github
  :repository "https://github.com/shirok/Gauche-app-audacity.git"
  )
