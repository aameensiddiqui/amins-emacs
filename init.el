(message "xX-init.el load ho gaya!-Xx")
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; theme
(unless (package-installed-p 'gruber-darker-theme)
  (package-refresh-contents)
  (package-install 'gruber-darker-theme))

;; backup files configuration
(setq backup-directory-alist `(("." . "~/Programming/.emacs_backups/backups")))

;; Custom variables (auto-generated)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(package-selected-packages '(rainbow-mode smex gruber-darker-theme chess))
 '(warning-suppress-log-types '((initialization)))
 '(warning-suppress-types '((initialization) (initialization))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 `(default ((t (:background "#000000"))))
 )
