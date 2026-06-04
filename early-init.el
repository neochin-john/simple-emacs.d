(setq package-enable-at-startup nil)

;; On MSys2, GPG is an MSys2 binary that expects Unix-style paths
;; like "/d/msys64/...".  package.el computes a Windows-style path
;; "d:/msys64/..." which GPG treats as relative, producing a broken
;; path like "/home/leo/d:/msys64/.../pubring.kbx".
(when (and (eq system-type 'windows-nt) (getenv "MSYSTEM"))
  (let* ((win-path (expand-file-name "gnupg"
                                     (expand-file-name "elpa" user-emacs-directory)))
         (unix-path (if (string-match "\\`\\([a-zA-Z]\\):" win-path)
                        (concat "/" (downcase (match-string 1 win-path))
                                (substring win-path 2))
                      win-path)))
    (setq package-gnupghome-dir unix-path)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil
                    :family "IosevkaTerm NFM"
                    :height 120)
(setq warning-minimum-level :emergency)

(setq ring-bell-function 'ignore)
(setq visible-bell nil)

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))
