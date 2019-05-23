;;; init.el --- my emacs config

;;; Commentary:

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (require 'cl))

(add-hook 'window-setup-hook 'toggle-frame-fullscreen)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(line-number-mode 1)
(column-number-mode 1)

(delete-selection-mode 1)
(show-paren-mode 1)

(set-face-attribute 'default nil
                    :family "Hack"
                    :height 140)

(setq delete-by-moving-to-trash t)
(setq delete-trailing-lines t)
(setq enable-recursive-minibuffers t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq require-final-newline t)
(setq save-interprogram-paste-before-kill t)
(setq uniquify-buffer-name-style 'post-forward)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq auto-save-file-name-transforms '((".*"  "~/.emacs.d/auto-save/" t)))
(setq backup-directory-alist         '(("." . "~/.emacs.d/backup/")))
(setq custom-file                             "~/.emacs.d/null.el")

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package
  windmove
  :config (windmove-default-keybindings))

(use-package
  misc
  :bind ("M-z" . zap-up-to-char))

(use-package
  subword
  :diminish nil
  :config (global-subword-mode))

(use-package
  flyspell
  :diminish nil
  :custom ;;
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (ispell-extra-args '("--run-together"))
  :hook ((text-mode prog-mode) . flyspell-mode))

(use-package
  eldoc
  :diminish nil)

(use-package
  vc
  :custom (vc-handled-backends nil))

(use-package
  solarized-theme
  :ensure t
  :config (load-theme 'solarized-light t))

(use-package
  diminish
  :ensure t)

(use-package
  which-key
  :ensure t
  :diminish
  :config (which-key-mode 1))

(use-package
  counsel
  :ensure t
  :demand t
  :diminish ivy-mode
  :config (ivy-mode 1)
  :bind ;;
  ("C-s" . swiper)
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-switch-buffer)
  ("C-x C-f" . counsel-find-file)
  ("C-c C-v" . ivy-resume)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f2> u" . counsel-unicode-char)
  (:map ivy-minibuffer-map
        ("C-r" . counsel-minibuffer-history)))

(use-package
  company
  :ensure t
  :demand t
  :diminish
  :config (global-company-mode)
  :custom ;;
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case t)
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  :bind (:map company-mode-map
              ("<tab>" . company-indent-or-complete-common)
              ("<backtab>" . company-other-backend)))

(use-package
  flycheck
  :ensure t
  :config (global-flycheck-mode)
  (add-to-list 'display-buffer-alist '("flycheck errors"            ;
                                       (display-buffer-reuse-window ;
                                        display-buffer-in-side-window)
                                       (window-height . 0.2)))
  :custom ;;
  (flycheck-display-errors-function nil)
  (flycheck-indication-mode nil))

(use-package
  magit
  :ensure t
  :custom ;;
  (magit-diff-refine-hunk 'all)
  (magit-diff-refine-ignore-whitespace nil)
  :hook (magit-mode . (lambda ()
                        (company-mode 0)))
  :bind ("C-x g" . magit-status))

;; emacs-lisp

(use-package
  elisp-format
  :ensure t
  :hook (emacs-lisp-mode . (lambda ()
                             (add-hook 'before-save-hook ;
                                       'elisp-format-buffer nil t))))

;; php

(use-package
  php-mode
  :ensure t
  :custom ;;
  (flycheck-phpcs-standard "PSR2")
  (php-mode-coding-style 'psr2)
  (php-mode-template-compatibility nil)
  :hook (php-mode . (lambda ()
                      (when              ;
                          (not           ;
                           (string-match ;
                            geben-temporary-file-directory buffer-file-name))
                        (add-hook 'before-save-hook (lambda ()
                                                      (php-cs-fixer-fix)
                                                      (phpcbf)) ;
                                  nil t)))))

(use-package
  phpactor
  :ensure t
  :bind (:map php-mode-map
              ("C-c d" . phpactor-goto-definition)
              ("C-c h" . phpactor-hover)))

(use-package
  company-phpactor
  :ensure t
  :hook (php-mode . (lambda ()
                      (set (make-local-variable 'company-idle-delay) 0.4)
                      (set (make-local-variable 'company-backends)
                           '((company-phpactor ;
                              company-keywords)
                             (company-phpactor))))))

(use-package
  flycheck-phpstan
  :ensure t
  :config (flycheck-add-next-checker 'phpstan '(warning . php-phpcs))
  :custom (phpstan-level 4))

(use-package
  phpcbf
  :ensure t
  :custom (phpcbf-standard "PSR2"))

(use-package
  php-cs-fixer
  :ensure t
  :custom ;;
  (php-cs-fixer-rules-fixer-part-options '("array_indentation"))
  (php-cs-fixer-rules-level-part-options '("@PSR2")))

(use-package
  geben
  :ensure t)

;; python

(use-package
  anaconda-mode
  :ensure t
  :hook ;;
  (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode))

(use-package
  company-anaconda
  :ensure t
  :hook (python-mode . (lambda ()
                         (set (make-local-variable 'company-backends)
                              '(company-anaconda)))))

(use-package
  blacken
  :ensure t
  :diminish
  :hook (python-mode . blacken-mode))

(use-package
  pipenv
  :ensure t
  :diminish
  :hook (python-mode . pipenv-mode))

;; experimental

(provide 'init)
;;; init.el ends here
