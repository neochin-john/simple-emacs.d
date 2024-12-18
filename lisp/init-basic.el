(setq frame-title-format '("" "[%b]")
      inhibit-startup-screen t
      line-number-mode t
      column-number-mode t
      size-indication-mode t)
(set-face-attribute 'region nil :background "#dcdcdc")
(fset 'yes-or-no-p 'y-or-n-p)

(global-display-line-numbers-mode t)

; show path if names are same
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(use-package diminish)
(use-package bind-key)
(use-package hydra)
(use-package which-key
  :diminish
  :hook (after-init . which-key-mode))

(use-package gruber-darker-theme
  :ensure t)
  ;; :config
  ;; (load-theme 'gruber-darker t))

(use-package nyan-mode
  :config (setq nyan-bar-length 16)
  :hook (after-init . nyan-mode))

;; Environment
(if sys/win32p
    (add-to-list 'process-coding-system-alist
                 '("cmdproxy" utf-8 . gbk))
  (set-selection-coding-system 'utf-8))

(when (or sys/mac-x-p sys/linux-x-p (daemonp))
  (use-package exec-path-from-shell
    :custom (exec-path-from-shell-arguments '("-l"))
    :init (exec-path-from-shell-initialize)))

(setq image-types (cons 'svg image-types))
(provide 'init-basic)
