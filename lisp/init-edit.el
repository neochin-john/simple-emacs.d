(show-paren-mode t)
(delete-selection-mode t)
(recentf-mode t)
(prefer-coding-system 'utf-8)

(setq auto-save-default nil
      make-backup-files nil)
(setq show-trailing-whitespace t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq whitespace-style
      '(face
        tabs
        spaces
        ;; trailing
        ;; lines
        ;; space-before-tab
        ;; newline
        indentation
        empty
        space-after-tab
        space-mark
        tab-mark
        ;; newline-mark
        missing-newline-at-eof))
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(use-package diffview)

(use-package goto-chg
  :bind ("C-," . goto-last-change))

(use-package goto-last-point
  :diminish
  :bind ("C-M-," . goto-last-point)
  :hook (after-init . goto-last-point-mode))

(use-package goto-char-preview
  :bind ([remap goto-char] . goto-char-preview))

(use-package goto-line-preview
  :bind ([remap goto-line] . goto-line-preview))

(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
     ("C->" . mc/mark-next-like-this)
     ("C-<" . mc/mark-previous-like-this)
     ("C-c C-<" . mc/mark-all-like-this)
     ("C-\"" . mc/skip-to-next-like-this)
     ("C-:" . mc/skip-to-previous-like-this)))

(defun insert-windows-clipboard ()
  "Insert the current content of the Windows clipboard at point using PowerShell and iconv.
Also remove Windows-style line endings (^M)."
  (interactive)
  (let ((clipboard-text
         (with-temp-buffer
           (call-process-shell-command
            "powershell.exe -Command Get-Clipboard | iconv -f gbk -t utf-8"
            nil t)
           ;; 删除 ^M（即 \r）
           (goto-char (point-min))
           (while (re-search-forward "\r" nil t)
             (replace-match ""))
           (buffer-string))))
    (insert clipboard-text)))

(provide 'init-edit)
