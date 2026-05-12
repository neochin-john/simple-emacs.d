(use-package wingman
  :straight (:type git :host github :repo "mjrusso/wingman")
  :defer t

  :init
  ;; No prefix map until you set `wingman-prefix-key' (e.g. "C-c w").
  (setq wingman-prefix-key nil)

  ;; :hook (prog-mode . wingman-mode)

  :config
  (setq wingman-log-level 4)
  (setq wingman-ring-n-chunks 16)
  (setq wingman-llama-endpoint "http://127.0.0.1:6666/infill")

  (when (fboundp 'modus-themes-get-color-value)
    (set-face-attribute 'wingman-overlay-face nil
                        :foreground (modus-themes-get-color-value 'red-warmer)
                        :background (modus-themes-get-color-value 'bg-inactive)))

  (add-to-list 'wingman-disable-predicates
               (lambda ()
                 (or (derived-mode-p 'envrc-file-mode)
                     (derived-mode-p 'direnv-envrc-mode)
                     (when buffer-file-name
                       (let ((fname (file-name-nondirectory buffer-file-name)))
                         (or (string-equal ".env" fname)
                             (string-equal ".envrc" fname)
                             (string-prefix-p ".localrc" fname))))))))

(provide 'init-ai)
