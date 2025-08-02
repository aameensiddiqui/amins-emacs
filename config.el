(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq default-frame-alist (cons '(undecorated . t) 
				(assq-delete-all 'undecorated default-frame-alist)))
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-frame-font "Monospace 11" nil t)
;; (global-hl-line-mode t)
(setq scroll-conservatively 100)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(global-subword-mode 1)

(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(defun switch-fullscreen nil
  (interactive)
  (let* ((modes '(nil fullboth fullwidth fullheight))
	 (cm (cdr (assoc 'fullscreen (frame-parameters) ) ) )
	 (next (cadr (member cm modes) ) ) )
    (modify-frame-parameters
     (selected-frame)
     (list (cons 'fullscreen next)))))

(define-key global-map [f11] 'switch-fullscreen)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-expert t)

(defun kill-current-buffer()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-x M-k") 'kill-all-buffers)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Welcome back!")
  (setq dashboard-center-content nil)
  (setq dashboard-init-info ""))

(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))
  (global-set-key (kbd "C-c w w") 'kill-whole-word)

(defun copy-whole-line()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
     (point-at-bol)
     (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

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
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

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

;; (defun move-line-up ()
;; (interactive)
;; (transpose-lines 1)
;; (forward-line -2))
;; (global-set-key (kbd "M-<up>") 'move-line-up)

;; (defun move-line-down ()
;; (interactive)
;; (forward-line 1)
;; (transpose-lines 1)
;; (forward-line -1))
;; (global-set-key (kbd "M-<down>") 'move-line-down)

(defun duplicate-line-or-region ()
  "Duplicate current line, or region if active."
  (interactive)
  (let (beg end (origin (point)))
    (if (use-region-p)
        ;; Duplicate region
        (setq beg (region-beginning)
              end (region-end))
      ;; Duplicate current line
      (setq beg (line-beginning-position)
            end (line-end-position)))
    (let ((region (buffer-substring beg end)))
      (goto-char end)
      (newline)
      (insert region)
      (goto-char origin))))
(global-set-key (kbd "C-c d") 'duplicate-line-or-region)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

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

;;  (use-package org-modern
;;    :ensure t
;;    :hook
;;    (org-mode . org-modern-mode))

(setq org-support-shift-select 'always)

;;    (use-package yasnippet
;;      ensure t)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; (use-package hungry-delete
;;   :ensure t
;;   :config (global-hungry-delete-mode))

;;(use-package spaceline
;;  :ensure t
;;  :config
;;  (require 'spaceline-config)
;;  (setq powerline-default-separator (quote arrow))
;;  (spaceline-spacemacs-theme))

(line-number-mode 1)
(column-number-mode 1)

(display-time-mode 1)
;;(setq display-time-format "%I:%M:%S")
;;(setq display-time-interval 1)

(size-indication-mode 1)

(display-battery-mode 0)

(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'which-key-mode)
  (diminish 'rainbow-mode)
  (diminish 'company-mode)
  (diminish 'subword-mode))
