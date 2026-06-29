;; (message "xX-init.el load ho gaya!-Xx")
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; backup files configuration
(setq backup-directory-alist `(("." . "~/Programming/.emacs_backups/backups")))

;; Custom variables (auto-generated)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd"
     "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
     default))
 '(package-selected-packages
   '(chess color-theme-sanityinc-tomorrow company dashboard diminish
           doom-themes drepl emmet-mode emms exwm flymake geiser
           geiser-mit go-mode gruber-darker-theme gruvbox-theme
           lua-mode magit paredit php-mode rainbow-delimiters
           rainbow-mode rjsx-mode sanityinc-tomorrow-night-theme smex
           web-mode which-key yasnippet))
 '(warning-suppress-log-types '((initialization)))
 '(warning-suppress-types '((initialization) (initialization)))
 '(web-mode-attr-indent-offset 4)
 '(web-mode-attr-value-indent-offset 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
