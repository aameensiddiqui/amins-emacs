;; gui config
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq default-frame-alist (cons '(undecorated . t) 
                                (assq-delete-all 'undecorated default-frame-alist)))
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-frame-font "11" nil t)

(global-hl-line-mode t)
(setq scroll-conservatively 100)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-expert t)

;; autocomplete brackets
(electric-pair-mode 1)

;; which-key package
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; smex package config
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; enable disabled commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
