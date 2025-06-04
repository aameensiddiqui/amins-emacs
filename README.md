* UI changes
```
#+begin_src emacs-lisp
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
#+end_src
```

* Autocomplete brackets

```
#+begin_src emacs-lisp
  ;; autocomplete brackets
(electric-pair-mode 1)
#+end_src
```

* Whick key

```
#+begin_src emacs-lisp
  ;; which-key package
(use-package which-key
  :ensure t
  :init
  (which-key-mode))
#+end_src
```

* Smex

```
#+begin_src emacs-lisp
  ;; smex package config
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
#+end_src
```

* Enable commands

```
#+begin_src emacs-lisp
  ;; enable disabled commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
#+end_src
```
