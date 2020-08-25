(show-paren-mode t)
(delete-selection-mode t)
(recentf-mode t)
(prefer-coding-system 'utf-8)

(setq auto-save-default nil
      make-backup-files nil)
(setq show-trailing-whitespace t)

(use-package diffview)

(use-package goto-chg
  :bind ("C-," . goto-last-change))

(use-package goto-last-point
  :diminish
  :bind ("C-M-," . goto-last-point)
  :hook (after-init . goto-last-point-mode))

(use-package goto-char-preview
  :bind ([remap goto-char] . goto-char-preview))

(use-package goto-line-preview
  :bind ([remap goto-line] . goto-line-preview))

(provide 'init-edit)
