(use-package counsel
  :diminish ivy-mode counsel-mode
  :hook ((after-init . ivy-mode)
	 (ivy-mode . counsel-mode)))
(use-package ivy-prescient
  :diminish
  :hook ((ivy-mode . ivy-prescient-mode)
	 (ivy-prescient-mode . prescient-persist-mode))
  :init
  (setq prescient-filter-method '(literal regexp initialism)))

(use-package counsel-projectile
  :hook (counsel-mode . counsel-projectile-mode)
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)))

(use-package ivy-yasnippet
  :bind ("C-c C-y" . ivy-yasnippet))

(use-package avy)

(provide 'init-ivy)
