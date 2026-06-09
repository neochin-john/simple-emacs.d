(use-package python
  :config
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-env "PYTHONPATH")))

(use-package pyvenv
  :hook (after-init . pyvenv-mode)
  :config
  (defun my/python-activate-project-venv ()
    "Find .venv upward from the current file and activate it."
    (when-let ((root (locate-dominating-file default-directory ".venv")))
      (let ((venv (expand-file-name ".venv" root)))
        (when (file-directory-p venv)
          (setq-local pyvenv-activate venv)
          (unless (and pyvenv-virtual-env
                       (string= (expand-file-name pyvenv-virtual-env)
                                (expand-file-name venv)))
            (pyvenv-activate venv))))))
  (add-hook 'python-mode-hook #'my/python-activate-project-venv)
  (add-hook 'python-ts-mode-hook #'my/python-activate-project-venv))

(provide 'init-python)
