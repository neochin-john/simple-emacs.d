(use-package cc-mode
  :hook (c-mode-common . (lambda ()
                           (c-set-style "stroustrup")
                           (c-set-offset 'inextern-lang 0)))
  :init (setq-default c-basic-offset 4)
  :config
  (use-package modern-cpp-font-lock
    :diminish
    :init (modern-c++-font-lock-global-mode t)))

(provide 'init-c)
