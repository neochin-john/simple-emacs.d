(defun my-tab-right ()
  (interactive)
  (if (use-region-p)
      ;; 选区整体右移到下一个 tab stop
      (indent-rigidly-right-to-tab-stop
       (region-beginning)
       (region-end))

    ;; 非选区：插入空格到下一个 tab stop
    (let* ((col (current-column))
           (spaces (- tab-width
                      (% col tab-width))))
      (insert (make-string spaces ?\s)))))

(defun my-tab-left ()
  (interactive)
  (if (use-region-p)
      ;; 选区整体左移到上一个 tab stop
      (indent-rigidly-left-to-tab-stop
       (region-beginning)
       (region-end))

    ;; 非选区：删除到上一个 tab stop，但不删除非空格字符
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

                           ;; 禁用tab调用c-indent-line-or-region
                           (setq indent-tabs-mode nil)
                           ;; (setq tab-always-indent nil)
                           ;; (setq tab-width 4)
                           ;; (local-set-key (kbd "TAB") #'self-insert-command)
                           (local-set-key (kbd "TAB") #'my-tab-right)
                           (local-set-key (kbd "<backtab>") #'my-tab-left)

                           ;; 当前buffer禁用lsp formatting
                           (setq-local lsp-enable-indentation nil)
                           (setq-local lsp-enable-on-type-formatting nil)))
  :init (setq-default c-basic-offset 4)
  :config
  (use-package modern-cpp-font-lock
    :diminish
    :init (modern-c++-font-lock-global-mode t)))

(provide 'init-c)
