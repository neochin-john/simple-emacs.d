(setq package-archives '(("gnu" . "http://1.15.88.122/gnu/")
			 ("melpa" . "http://1.15.88.122/melpa/")))

;; Emacs 27 bug report #31397:
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=31397
;; Emacs doesn't call package-initialize if there's no elpa directory
(unless (bound-and-true-p package--initialized)
  (package-initialize t))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  (setq use-package-expand-minimally t)
  (setq use-package-enable-imenu-support t))

(eval-when-compile
    (require 'use-package))

(use-package benchmark-init
  :commands (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate)
  :init (benchmark-init/activate))

;; (use-package esup
;;   ;; To use MELPA Stable use ":pin mepla-stable",
;;   :pin melpa-stable
;;   :commands (esup))

(provide 'init-package)
