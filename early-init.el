(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil
                    :family "IosevkaTerm NFM"
                    :height 120)
(setq warning-minimum-level :emergency)
(setq package-gnupghome-dir (concat user-emacs-directory "elpa/gnupg"))

(setq ring-bell-function 'ignore)
(setq visible-bell nil)

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))
