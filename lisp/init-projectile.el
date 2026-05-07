(use-package projectile
  :diminish
  :hook (after-init . projectile-mode)
  :init
  (setq projectile-indexing-method 'alien))

(provide 'init-projectile)
