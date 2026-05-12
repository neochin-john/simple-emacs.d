;; straight.el is bootstrapped in early-init.el

(straight-use-package 'use-package)
(require 'use-package)

(setq straight-use-package-by-default t
      use-package-always-defer t
      use-package-expand-minimally t
      use-package-enable-imenu-support t)

(use-package benchmark-init
  :commands (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate)
  :init (benchmark-init/activate))

(provide 'init-package)
