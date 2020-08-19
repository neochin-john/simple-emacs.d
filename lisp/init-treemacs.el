(use-package treemacs
  :bind (("M-0" . treemacs-select-window))
  :config
  (use-package treemacs-projectile
    :after projectile))

(provide 'init-treemacs)
