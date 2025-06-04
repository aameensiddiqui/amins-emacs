;; gui config
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq default-frame-alist (cons '(undecorated . t) 
                                (assq-delete-all 'undecorated default-frame-alist)))
(ido-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-frame-font "11" nil t)

(global-hl-line-mode t)
(setq scroll-conservatively 100)
