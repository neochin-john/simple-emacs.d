(use-package rainbow-mode
  :diminish
  :hook ((html-mode php-mode) . rainbow-mode))

(use-package hl-todo
  :diminish
  :hook (after-init . global-hl-todo-mode))

(provide 'init-highlight)
