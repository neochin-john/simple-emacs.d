(use-package company
  :diminish
  :hook (after-init . global-company-mode)
  :init
  (use-package company-box
    :diminish
    :hook (company-mode . company-box-mode))
  (use-package company-quickhelp
    :hook (global-company-mode . company-quickhelp-mode))
  (use-package company-prescient
    :hook (global-company-mode . company-prescient-mode)))

(provide 'init-company)
