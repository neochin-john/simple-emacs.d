(use-package markdown-mode
  :config
  (use-package markdown-toc)
  :init (setq markdown-command "pandoc"))

(provide 'init-markdown)
