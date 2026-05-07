(use-package lsp-mode
  :hook ((prog-mode
	  . (lambda ()
              (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                (lsp-deferred))))
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://github.com/emacs-lsp/lsp-mode#performance
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-keymap-prefix "C-c l")
  ;; disable RET autoformat
  (setq lsp-enable-on-type-formatting nil))


(use-package lsp-ui
  :diminish
  :config
  (setq lsp-ui-doc-position 'top))

(use-package lsp-ivy
  :diminish
  :after lsp-mode)

(use-package lsp-treemacs
  :diminish
  :after lsp-mode
  :config
  ;; Workaround: `lsp-defun' expands (&optional ...) alongside destructuring into
  ;; extra mandatory INPUTn slots; callers pass 3 args → wrong-number-of-arguments.
  ;; See emacs-lsp/lsp-protocol `lsp-defun' vs lsp-treemacs call hierarchy ret-action.
  (defun lsp-treemacs--call-hierarchy-ret-action (item &optional callsite-start callsite-uri)
    "Build the ret action for a call hierarchy item.
Prefer CALLSITE-START and CALLSITE-URI when provided."
    (-let (((&CallHierarchyItem :uri :selection-range (&Range :start)) item))
      (let ((target-uri (or callsite-uri uri))
            (target-start (or callsite-start start)))
        (lsp-treemacs--open-file-in-mru (lsp--uri-to-path target-uri))
        (goto-char (lsp--position-to-point target-start))
        (run-hooks 'xref-after-jump-hook)))))

(use-package dap-mode
  :diminish
  :hook ((after-init . dap-mode)
	 (dap-mode . dap-ui-mode)))

(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :hook (cmake-mode . lsp-deferred))

(use-package cmake-font-lock
  :ensure t
  :after cmake-mode
  :config (cmake-font-lock-activate))

(provide 'init-lsp)
