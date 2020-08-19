(use-package windmove
  :hook (after-init . windmove-default-keybindings))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :hook (emacs-startup . ace-window-display-mode))

(provide 'init-window)
