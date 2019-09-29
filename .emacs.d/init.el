;;; init.el --- my emacs config

;;; Commentary:

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

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
(electric-pair-mode 1)

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
(setq split-height-threshold nil)
(setq uniquify-buffer-name-style 'post-forward)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default line-spacing 3)
(setq-default tab-width 4)

(setq auto-save-file-name-transforms '((".*"  "~/.emacs.d/auto-save/" t)))
(setq backup-directory-alist         '(("." . "~/.emacs.d/backup/")))
(setq custom-file                             "~/.emacs.d/null.el")

(fset 'yes-or-no-p 'y-or-n-p)

(defun my/whitespace-hook ()
  (add-hook 'before-save-hook 'delete-trailing-whitespace nil t))

(add-hook 'text-mode-hook 'my/whitespace-hook)
(add-hook 'prog-mode-hook 'my/whitespace-hook)

(use-package
  subword
  :diminish
  :config (global-subword-mode))

(use-package
  flyspell
  :diminish
  :custom ;;
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (ispell-extra-args '("--run-together"))
  :hook ((text-mode prog-mode) . flyspell-mode))

(use-package
  display-line-numbers
  :bind ("C-c l" . display-line-numbers-mode))

(use-package
  eldoc
  :diminish)

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
  evil
  :ensure t
  :diminish undo-tree-mode
  :init (evil-mode 1)
  :custom (evil-want-C-u-scroll t))

(use-package
  which-key
  :ensure t
  :diminish
  :config (which-key-mode 1))

(use-package
  ace-window
  :ensure t
  :diminish
  :custom ;;
  (aw-dispatch-always t)
  :bind ("M-o" . ace-window))

(use-package
  avy
  :ensure t
  :bind ("C-M-s" . avy-goto-char-timer))

(use-package
  counsel
  :ensure t
  :demand t
  :diminish ivy-mode
  :config (ivy-mode 1)
  (advice-add 'ivy--minibuffer-setup
              :after (lambda ()
                       (setq-local line-spacing 3)))
  :bind ;;
  ("C-s" . swiper)
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-switch-buffer)
  ("C-x C-f" . counsel-find-file)
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
  :hook (special-mode . (lambda ()
                          (company-mode 0)))
  :bind (:map company-mode-map
              ("<tab>" . company-indent-or-complete-common)))

(use-package
  yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config (yas-global-mode)
  :bind ("C-c y" . yas-insert-snippet))

(use-package
  flycheck
  :ensure t
  :config (global-flycheck-mode)
  (add-to-list 'display-buffer-alist '("flycheck errors"            ;
                                       (display-buffer-reuse-window ;
                                        display-buffer-in-side-window)
                                       (window-height . 0.2)))
  :custom (flycheck-display-errors-function nil))

(use-package
  magit
  :ensure t
  :custom ;;
  (magit-diff-refine-hunk 'all)
  (magit-diff-refine-ignore-whitespace nil)
  :bind ("C-x g" . magit-status))

(use-package
  projectile
  :ensure t
  :diminish
  :config (projectile-mode 1)
  :custom ;;
  (projectile-completion-system 'ivy)
  (projectile-dynamic-mode-line nil)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package
  projectile-ripgrep
  :ensure t)

;; multiple

(use-package
  lsp-mode
  :ensure t
  :custom ;;
  (lsp-enable-snippet nil)
  (lsp-file-watch-threshold nil)
  (lsp-prefer-flymake :none)
  (lsp-response-timeout 30)
  :hook (php-mode . lsp)
  :bind (:map lsp-mode-map
              ("C-c d" . lsp-find-definition)
              ("C-c f" . lsp-find-references)
              ("C-c h" . lsp-describe-thing-at-point)))

(use-package
  company-lsp
  :ensure t
  :after lsp-mode
  :config (push 'company-lsp company-backends))

(use-package
  prettier-js
  :ensure t
  :diminish
  :hook ;;
  (json-mode . prettier-js-mode)
  (yaml-mode . prettier-js-mode))

;; emacs-lisp

(defun my/emacs-lisp-hook ()
  (add-hook 'before-save-hook 'elisp-format-buffer nil t))

(use-package
  elisp-format
  :ensure t
  :hook (emacs-lisp-mode . my/emacs-lisp-hook))

;; fish

(defun my/fish-hook ()
  (add-hook 'before-save-hook 'fish_indent nil t))

(use-package
  fish-mode
  :ensure t
  :hook (fish-mode . my/fish-hook))

;; json

(use-package
  json-mode
  :ensure t
  :defer
  :custom (js-indent-level 2))

;; php

(defun my/php-hook ()
  (when (or (not (boundp 'geben-temporary-file-directory))
            (not (string-match geben-temporary-file-directory buffer-file-name)))
    (add-hook 'before-save-hook 'my/php-format nil t)))

(defun my/php-format ()
  (php-cs-fixer-fix)
  (phpcbf))

(use-package
  php-mode
  :ensure t
  :custom ;;
  (flycheck-phpcs-standard "PSR2")
  (php-mode-coding-style 'psr2)
  (php-mode-template-compatibility nil)
  :hook (php-mode . my/php-hook))

(use-package
  phpactor
  :ensure t
  :defer)

(defun my/phpstan-hook ()
  (when (not (php-project-get-root-dir))
    (setq-local php-project-root default-directory))
  (flycheck-select-checker 'phpstan))

(use-package
  flycheck-phpstan
  :ensure t
  :demand t
  :config (flycheck-add-next-checker 'phpstan 'php-phpcs)
  :custom (phpstan-level 4)
  :hook (php-mode . my/phpstan-hook))

(use-package
  phpcbf
  :ensure t
  :defer
  :custom (phpcbf-standard "PSR2"))

(use-package
  php-cs-fixer
  :ensure t
  :defer
  :custom ;;
  (php-cs-fixer-rules-fixer-part-options '())
  (php-cs-fixer-rules-level-part-options '("@PhpCsFixer")))

(use-package
  geben
  :ensure t
  :defer)

;; python

(defun my/python-hook ()
  (add-hook 'after-save-hook 'my/mypy-hook nil t)
  (when (file-exists-p buffer-file-name)
    (my/mypy-hook)))

(defun my/mypy-hook ()
  (remove-hook 'after-save-hook 'my/mypy-hook t)
  (flycheck-select-checker 'python-mypy))

(use-package
  anaconda-mode
  :ensure t
  :hook ;;
  (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode)
  (python-mode . my/python-hook))

(use-package
  company-anaconda
  :ensure t
  :after anaconda-mode
  :config (push 'company-anaconda company-backends))

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

;; yaml

(use-package
  yaml-mode
  :ensure t
  :defer)

;; experimental

;; Local Variables:
;; byte-compile-warnings: (not free-vars noruntime)
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:

(provide 'init)
;;; init.el ends here
