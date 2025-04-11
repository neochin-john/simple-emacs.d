(use-package flycheck
  ;; :hook (prog-mode . flycheck-mode)
  :config
  (add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.15)))
  (setq flycheck-emacs-lisp-load-path 'inherit))

(provide 'init-flycheck)
