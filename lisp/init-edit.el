(show-paren-mode t)
(delete-selection-mode t)
(recentf-mode t)
(prefer-coding-system 'utf-8-unix)

;; duplicate-line, and move cursor to next line
(setq duplicate-line-final-position -1)
(global-set-key (kbd "M-S-<down>") #'duplicate-dwim)

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

;; multiple-cursors only replays self-insert-command on fake cursors. Unconditionally
;; rebind electric keys in the buffer local map (same approach as local-set-key for
;; < and >); save the previous binding for restore instead of hard-coding c-mode.
(defvar my/mc-keys-for-self-insert
  '("(" ")" "{" "}" "[" "]" "<" ">" "'" "\"" ";" "," ":")
  "Keys to rebind to self-insert-command while multiple-cursors-mode is active.")

(defvar-local my/mc-saved-local-keys nil
  "Alist of (KEY-STRING . COMMAND) saved before mc local key overrides.")

(defun my/mc-override-electric-keys ()
  (setq my/mc-saved-local-keys nil)
  (dolist (key my/mc-keys-for-self-insert)
    (let ((kbd (kbd key)))
      (push (cons key (key-binding kbd)) my/mc-saved-local-keys)
      (local-set-key kbd #'self-insert-command))))

(defun my/mc-restore-electric-keys ()
  (dolist (pair my/mc-saved-local-keys)
    (local-set-key (kbd (car pair)) (cdr pair)))
  (setq my/mc-saved-local-keys nil))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-\"" . mc/skip-to-next-like-this)
         ("C-:" . mc/skip-to-previous-like-this))
  :init
  ;; Register hooks at startup (always-defer delays :config until first use).
  (add-hook 'multiple-cursors-mode-enabled-hook #'my/mc-override-electric-keys)
  (add-hook 'multiple-cursors-mode-disabled-hook #'my/mc-restore-electric-keys))

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

(defun my/fn/copy-range-line-number (arg)
  "Copy the current region's line range as \"#START-END\" to clipboard.
With prefix ARG (\\[universal-argument]), prompt for a base directory and
prepend the relative file path: \"@REL/PATH#START-END\"."
  (interactive "P")
  (if (use-region-p)
      (let* ((start (line-number-at-pos (region-beginning)))
             (end   (line-number-at-pos (region-end)))
             (range (if (= start end)
                        (format "#%d" start)
                      (format "#%d-%d" start end)))
             (prefix (when arg
                       (let ((base (read-directory-name "Base directory: ")))
                         (concat "@"
                                 (file-relative-name
                                  (buffer-file-name)
                                  base)))))
             (s     (concat prefix range)))
        (kill-new s)
        (funcall interprogram-cut-function s)
        (message "Copied: %s" s))
    (user-error "No active region")))

(provide 'init-edit)
