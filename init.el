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
(require 'init-go)

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
   '(go-mode auctex-latexmk benchmark-init cmake-font-lock coffee-mode company-auctex company-box company-prescient company-quickhelp company-reftex counsel-projectile css-eldoc dap-mode diffview diminish exec-path-from-shell flycheck goto-char-preview goto-chg goto-last-point goto-line-preview gruber-darker-theme haml-mode hl-todo ivy-prescient ivy-yasnippet js2-refactor json-mode lsp-ivy lsp-ui magic-latex-buffer magit markdown-toc mocha modern-cpp-font-lock nyan-mode php-mode prettier-js pyvenv rainbow-mode restclient scss-mode treemacs-projectile typescript-mode web-mode wgrep yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-sideline-code-action ((t (:inherit warning))))
 '(whitespace-empty ((t (:extend t :background "gray11" :foreground "#ffdd33"))))
 '(whitespace-indentation ((t (:extend t :background "#00000000" :foreground "#505050"))))
 '(whitespace-space ((t (:extend t :background "#00000000" :foreground "#505050"))))
 '(whitespace-tab ((t (:extend t :background "#00000000" :foreground "#505050")))))
