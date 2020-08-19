(use-package python
  :config
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-env "PYTHONPATH")))

(use-package pyvenv
  :hook (after-init . pyvenv-mode))

(provide 'init-python)
