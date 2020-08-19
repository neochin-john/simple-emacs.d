(use-package css-mode
  :init (setq css-indent-offset 2))

(use-package scss-mode
  :init
  (setq scss-compile-at-save nil))

(use-package less-css-mode)

(use-package css-eldoc
  :commands trun-on-css-eldoc
  :hook ((css-mode scss-mode less-css-mode) . turn-on-css-eldoc))

(use-package json-mode)

(use-package js2-mode)

(use-package js2-refactor
  :diminish
  :hook (js2-mode . js2-refactor-mode))

(use-package typescript-mode)

(use-package mocha
  :config (use-package mocha-snippets))

(use-package coffee-mode
  :config (setq coffee-tab-width 2))

(use-package web-mode
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(use-package prettier-js)

(use-package haml-mode)
(use-package php-mode)

(use-package restclient
  :config
  (use-package restclient-test
    :diminish
    :hook (restclient-mode . restclient-test-mode))

  (with-eval-after-load 'company
    (use-package company-restclient
      :defines company-backends
      :init (add-to-list 'company-backends 'company-restclient))))

(provide 'init-web)
