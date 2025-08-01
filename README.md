# UI changes

``` {.commonlisp org-language="emacs-lisp"}
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
```

## tab

``` {.commonlisp org-language="emacs-lisp"}
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
```

## subword camelcasing

``` {.commonlisp org-language="emacs-lisp"}
(global-subword-mode 1)
```

## fullscreen modes

``` {.commonlisp org-language="emacs-lisp"}
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
```

# Terminal

``` {.commonlisp org-language="emacs-lisp"}
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
```

# IDO

## enable ido mode

``` {.commonlisp org-language="emacs-lisp"}
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
```

## switch buffers

``` {.commonlisp org-language="emacs-lisp"}
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
```

# buffers

## enable ibuffer

``` {.commonlisp org-language="emacs-lisp"}
(global-set-key (kbd "C-x C-b") 'ibuffer)
```

## expert mode

``` {.commonlisp org-language="emacs-lisp"}
(setq ibuffer-expert t)
```

## always kill current buffer

``` {.commonlisp org-language="emacs-lisp"}
(defun kill-current-buffer()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)
```

## kill all buffers

``` {.commonlisp org-language="emacs-lisp"}
(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-x M-k") 'kill-all-buffers)
```

# dashboard

``` {.commonlisp org-language="emacs-lisp"}
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Welcome back!")
  (setq dashboard-center-content nil)
  (setq dashboard-init-info ""))
```

# Convenient functions

## kill whole word

``` {.commonlisp org-language="emacs-lisp"}
(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))
  (global-set-key (kbd "C-c w w") 'kill-whole-word)
```

## copy whole line

``` {.commonlisp org-language="emacs-lisp"}
(defun copy-whole-line()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
     (point-at-bol)
     (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)
```

## move line or marked region up and down M-\<up\> M-\<down\>

``` {.commonlisp org-language="emacs-lisp"}
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


(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)
```

### move line up

``` {.commonlisp org-language="emacs-lisp"}
;; (defun move-line-up ()
;; (interactive)
;; (transpose-lines 1)
;; (forward-line -2))
;; (global-set-key (kbd "M-<up>") 'move-line-up)
```

### move line down

``` {.commonlisp org-language="emacs-lisp"}
;; (defun move-line-down ()
;; (interactive)
;; (forward-line 1)
;; (transpose-lines 1)
;; (forward-line -1))
;; (global-set-key (kbd "M-<down>") 'move-line-down)
```

## duplicate line or region C-c d

``` {.commonlisp org-language="emacs-lisp"}
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
```

# Company for autocompletion

``` {.commonlisp org-language="emacs-lisp"}
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))
```

# Autocomplete brackets

``` {.commonlisp org-language="emacs-lisp"}
  ;; autocomplete brackets
(electric-pair-mode 1)
```

# Whick key

``` {.commonlisp org-language="emacs-lisp"}
  ;; which-key package
(use-package which-key
  :ensure t
  :init
  (which-key-mode))
```

# Smex

``` {.commonlisp org-language="emacs-lisp"}
  ;; smex package config
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
```

# Enable commands

``` {.commonlisp org-language="emacs-lisp"}
  ;; enable disabled commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
```

# org

``` {.commonlisp org-language="emacs-lisp"}
;;  (use-package org-modern
;;    :ensure t
;;    :hook
;;    (org-mode . org-modern-mode))
```

## shift select in org

``` {.commonlisp org-language="emacs-lisp"}
(setq org-support-shift-select 'always)
```

# yasnippet

``` {.commonlisp org-language="emacs-lisp"}
;;    (use-package yasnippet
;;      ensure t)
```

# config.org edit/reload

## edit

``` {.commonlisp org-language="emacs-lisp"}
(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)
```

## reload

``` {.commonlisp org-language="emacs-lisp"}
(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)
```

# rainbow

``` {.commonlisp org-language="emacs-lisp"}
(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode 1))
```

## for colourful braces

``` {.commonlisp org-language="emacs-lisp"}
(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))
```

# window splitting cursor function

``` {.commonlisp org-language="emacs-lisp"}
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
```

# hungry-delete package

``` {.commonlisp org-language="emacs-lisp"}
;; (use-package hungry-delete
;;   :ensure t
;;   :config (global-hungry-delete-mode))
```

# modeline

``` {.commonlisp org-language="emacs-lisp"}
;;(use-package spaceline
;;  :ensure t
;;  :config
;;  (require 'spaceline-config)
;;  (setq powerline-default-separator (quote arrow))
;;  (spaceline-spacemacs-theme))
```

## show line and column number on modeline

``` {.commonlisp org-language="emacs-lisp"}
(line-number-mode 1)
(column-number-mode 1)
```

## clock

``` {.commonlisp org-language="emacs-lisp"}
(display-time-mode 1)
;;(setq display-time-format "%I:%M:%S")
;;(setq display-time-interval 1) 
```

## file size

``` {.commonlisp org-language="emacs-lisp"}
(size-indication-mode 1)
```

## battery mode

``` {.commonlisp org-language="emacs-lisp"}
(display-battery-mode 0)
```

## diminish (removes minor modes)

``` {.commonlisp org-language="emacs-lisp"}
(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'which-key-mode)
  (diminish 'rainbow-mode)
  (diminish 'company-mode)
  (diminish 'subword-mode))
```
