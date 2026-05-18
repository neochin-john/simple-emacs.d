(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; read secrets.el to get api keys, etc.
(let ((secret-file
       (expand-file-name "secrets.el"
                         user-emacs-directory)))
  (when (file-exists-p secret-file)
    (load secret-file)))

(require 'init-const)
(require 'init-package)
(require 'init-basic)
(require 'init-edit)
(require 'init-ivy)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-highlight)
(require 'init-window)
(require 'init-treemacs)
(require 'init-projectile)
(require 'init-magit)
(require 'init-flycheck)

(require 'init-markdown)
(require 'init-tex)
(require 'init-lsp)
(require 'init-c)
(require 'init-python)
(require 'init-web)
(require 'init-go)

(require 'init-ai)

(load custom-file t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-sideline-code-action ((t (:inherit warning))))
 '(whitespace-empty ((t (:extend t :background "gray11" :foreground "#ffdd33"))))
 '(whitespace-indentation ((t (:extend t :background "#00000000" :foreground "#404040"))))
 '(whitespace-space ((t (:extend t :background "#00000000" :foreground "#404040"))))
 '(whitespace-tab ((t (:extend t :background "#00000000" :foreground "#404040")))))
