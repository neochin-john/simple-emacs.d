(use-package projectile
  :diminish
  :hook (after-init . projectile-mode)
  :init
  (setq projectile-indexing-method 'alien
        projectile-enable-caching t
        ;; Skip git deleted-files sync call in async sentinel (avoids
        ;; potential process-file-shell-command hang on MSYS2 Windows).
        projectile-git-use-fd t)
  :config
  ;; On MSYS2 native Windows Emacs, /bin/sh is not a valid Windows path.
  ;; projectile hardcodes "/bin/sh" in projectile-files-via-ext-command-async,
  ;; but on Windows we need the real path from `shell-file-name' (bash.exe).
  ;; bash is a POSIX shell so the { ...; } 2>file syntax works fine.
  (when (and (eq system-type 'windows-nt) (getenv "MSYSTEM"))
    (advice-add 'projectile-files-via-ext-command-async
                :around #'my/projectile-fix-shell)))

(defun my/projectile-fix-shell (orig-fun &rest args)
  "Replace hardcoded /bin/sh with `shell-file-name' on Windows."
  (let* ((sh shell-file-name)
         (orig-mp (symbol-function 'make-process)))
    (cl-letf (((symbol-function 'make-process)
               (lambda (&rest mp-args)
                 (let ((cmd (plist-get mp-args :command)))
                   (when (equal (car cmd) "/bin/sh")
                     (setq mp-args (plist-put mp-args :command
                                              (cons sh (cdr cmd)))))
                   (apply orig-mp mp-args)))))
      (apply orig-fun args))))

(provide 'init-projectile)
