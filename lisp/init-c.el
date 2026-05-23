(defun my/cc/tab-right ()
  (interactive)
  (if (use-region-p)
      ;; Move region right to the next tab stop
      (let ((deactivate-mark nil)
            (beg (region-beginning))
            (end (region-end)))
        (indent-rigidly-right-to-tab-stop beg end))
    ;; Without region: insert spaces to the next tab stop
    (let* ((col (current-column))
           (spaces (- tab-width
                      (% col tab-width))))
      (insert (make-string spaces ?\s)))))

(defun my/cc/tab-left ()
  (interactive)
  (if (use-region-p)
      ;; Move region left to the previous tab stop
      (let ((deactivate-mark nil)
            (beg (region-beginning))
            (end (region-end)))
        (indent-rigidly-left-to-tab-stop beg end))
    ;; Without region: delete back to previous tab stop, but not non-space chars
    (let* ((col (current-column))
           (target (* (/ (max 0 (- col 1))
                         tab-width)
                      tab-width))
           (delete-count (- col target))
           (start (- (point) delete-count))
           (end (point)))
      (when (and (> delete-count 0)
                 (>= start (line-beginning-position))
                 (string-match-p
                  "^ *$"
                  (buffer-substring-no-properties start end)))
        (delete-region start end)))))

(use-package cc-mode
  :hook (c-mode-common . (lambda ()
                           (c-set-style "stroustrup")
                           (c-set-offset 'inextern-lang 0)
                           (c-set-offset 'innamespace 0)
                           (c-set-offset 'comment-intro 0)

                           ;; Disable TAB invoking c-indent-line-or-region
                           (setq indent-tabs-mode nil)
                           ;; (setq tab-always-indent nil)
                           ;; (setq tab-width 4)
                           ;; (local-set-key (kbd "TAB") #'self-insert-command)
                           (local-set-key (kbd "TAB") #'my/cc/tab-right)
                           (local-set-key (kbd "<backtab>") #'my/cc/tab-left)

                           ;; Disable LSP formatting in the current buffer
                           (setq-local lsp-enable-indentation nil)
                           (setq-local lsp-enable-on-type-formatting nil)))
  :init (setq-default c-basic-offset 4)
  :config
  (use-package modern-cpp-font-lock
    :diminish
    :init (modern-c++-font-lock-global-mode t)))

(provide 'init-c)
