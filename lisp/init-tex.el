(use-package auctex
  :hook ((LaTex-mode . TeX-fold-mode)
	 (LaTeX-mode . LaTeX-math-mode)
	 (LaTeX-mode . TeX-source-correlate-mode)
	 (LaTeX-mode . TeX-PDF-mode)
	 (LaTeX-mode . (lambda ()
			 (add-to-list 'TeX-command-list
				      '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
			 (setq TeX-command-default "XeLaTeX")))))

(use-package auctex-latexmk)

(use-package company-auctex)

(use-package magic-latex-buffer
  :hook (TeX-update-style . magic-latex-buffer)
  :init
  (setq magic-latex-enable-block-highlight t
	magic-latex-enable-suscript t
	magic-latex-enable-pretty-symbols t
	magic-latex-enable-block-align nil
	magic-latex-enable-inline-image nil))

(use-package company-reftex)

(provide 'init-tex)
