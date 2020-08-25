(setq frame-title-format '("" "[%b]")
      inhibit-startup-screen t
      line-number-mode t
      column-number-mode t
      size-indication-mode t)
(set-face-attribute 'region nil :background "#dcdcdc")
(fset 'yes-or-no-p 'y-or-n-p)

; show path if names are same
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(use-package diminish)
(use-package bind-key)
(use-package hydra)
(use-package which-key
  :diminish
  :hook (after-init . which-key-mode))

;; (use-package nyan-mode
;;   :config (setq nyan-bar-length 16)
;;   :hook (after-init . nyan-mode))

(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-check-startup-files nil
	exec-path-from-shell-variables '("PATH" "MANPATH")
	exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

(provide 'init-basic)
