(use-package lsp-mode
  :hook ((prog-mode . (lambda ()
			(unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
			  (lsp-deferred))))
	 (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
	      ([remap xref-find-definitions] . lsp-find-definition)
	      ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://github.com/emacs-lsp/lsp-mode#performance
  (setq read-process-output-max (* 1024 1024)))


(use-package lsp-ui
  :diminish)

(use-package lsp-ivy
  :diminish
  :after lsp-mode)

(use-package lsp-treemacs
  :diminish
  :after lsp-mode)

(use-package dap-mode
  :diminish
  :hook ((after-init . dap-mode)
	 (dap-mode . dap-ui-mode)))

(provide 'init-lsp)
