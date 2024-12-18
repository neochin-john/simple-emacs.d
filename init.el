(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(display-line-numbers-type 'relative)
 '(package-selected-packages
   '(gruber-darker-theme flycheck cider-hydra ivy-hydra treemacs-projectile tex auctex magit modern-cpp-font-lock markdown-toc ivy-yasnippet company-quickhelp s ivy-prescient company-prescient company avy counsel which-key goto-line-preview goto-char-preview goto-last-point goto-chg diffview nyan-mode diminish benchmark-init use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-sideline-code-action ((t (:inherit warning)))))

