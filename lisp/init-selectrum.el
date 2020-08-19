(use-package selectrum
  :hook (after-init . selectrum-mode)
  :config
  (use-package selectrum-prescient
    :hook ((selectrum-mode . selectrum-prescient-mode)
	   (selectrum-prescient-mode . prescient-persist-mode))))

(provide 'init-selectrum)


