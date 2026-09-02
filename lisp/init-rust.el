(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive nil))

(use-package ron-mode
  :mode ("\\.ron" . ron-mode))

(provide 'init-rust)
