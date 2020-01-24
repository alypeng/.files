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
  (require 'use-package))

(add-hook 'window-setup-hook 'toggle-frame-fullscreen)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(line-number-mode 1)
(column-number-mode 1)

(delete-selection-mode 1)
(electric-pair-mode 1)
(winner-mode 1)

(set-face-attribute 'default nil
                    :family "Hack"
                    :height 140)

(setq delete-by-moving-to-trash t)
(setq enable-recursive-minibuffers t)
(setq gc-cons-threshold 30000000)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq require-final-newline t)
(setq ring-bell-function nil)
(setq save-interprogram-paste-before-kill t)
(setq split-height-threshold nil)
(setq uniquify-buffer-name-style 'post-forward)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default line-spacing 3)
(setq-default tab-width 4)
(setq-default truncate-lines t)

(setq auto-save-file-name-transforms '((".*"  "~/.emacs.d/auto-save/" t)))
(setq backup-directory-alist         '(("." . "~/.emacs.d/backup/")))
(setq custom-file                             "~/.emacs.d/null.el")

(fset 'yes-or-no-p 'y-or-n-p)

(defgroup my nil
  ""
  :group 'placeholder)

(defun my/whitespace-hook ()
  (add-hook 'before-save-hook 'whitespace-cleanup nil t))

(add-hook 'text-mode-hook 'my/whitespace-hook)
(add-hook 'prog-mode-hook 'my/whitespace-hook)
(add-hook 'conf-mode-hook 'my/whitespace-hook)

(defun my/indent-hook ()
  (add-hook 'before-save-hook 'my/indent-buffer nil t))

(defun my/indent-buffer ()
  (save-excursion (indent-region (point-min)
                                 (point-max))))

(bind-key "C-c a" 'align-regexp)
(bind-key "C-c l" 'global-display-line-numbers-mode)
(bind-key "C-c t" 'sort-lines)

(use-package
  autorevert
  :config (global-auto-revert-mode))

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
  (ispell-program-name "aspell")
  :hook ((text-mode prog-mode conf-mode) . flyspell-mode))

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

(defun my/prefix ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-c"))))

(use-package
  evil
  :ensure t
  :diminish undo-tree-mode
  :init (evil-mode 1)
  :config ;;
  (evil-define-key '(normal visual) global-map (kbd "SPC") 'my/prefix)
  :custom ;;
  (evil-default-state "emacs")
  (evil-normal-state-modes '(text-mode prog-mode conf-mode))
  (evil-want-C-u-scroll t)
  (evil-want-visual-char-semi-exclusive t)
  :bind ("C-=" . universal-argument))

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
  :bind ("C-c SPC" . avy-goto-char-timer))

(use-package
  counsel
  :ensure t
  :demand t
  :diminish ivy-mode
  :config (ivy-mode 1)
  (ivy-configure 'counsel-M-x
    :sort-fn #'ivy-string<)
  (advice-add 'ivy--minibuffer-setup
              :after (lambda ()
                       (setq-local line-spacing 3)))
  :bind ;;
  ("C-s" . swiper)
  ("C-M-s" . swiper-thing-at-point)
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-switch-buffer)
  ("C-x C-f" . counsel-find-file)
  ("C-c r" . ivy-resume)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f2> u" . counsel-unicode-char)
  (:map ivy-minibuffer-map
        ("C-r" . counsel-minibuffer-history)))

(use-package
  company
  :ensure t
  :demand t
  :config (global-company-mode)
  :custom ;;
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  :hook (special-mode . (lambda ()
                          (company-mode 0)))
  :bind (:map company-mode-map
              ("<tab>" . company-indent-or-complete-common)
              ("<backtab>" . company-other-backend)))

(use-package
  yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config (yas-global-mode)
  :bind ;;
  ("C-c y" . yas-insert-snippet)
  (:map yas-minor-mode-map
        ("<tab>" . nil)))

(defvar my/flycheck-buffer
  '("flycheck errors" ;;
    (display-buffer-reuse-window display-buffer-in-side-window)
    (window-height . 0.2)))

(use-package
  flycheck
  :ensure t
  :config (global-flycheck-mode)
  (add-to-list 'display-buffer-alist my/flycheck-buffer)
  :custom (flycheck-display-errors-function nil))

(use-package
  flycheck-indicator
  :ensure t
  :hook (flycheck-mode . flycheck-indicator-mode))

(use-package
  reformatter
  :ensure t)

(use-package
  magit
  :ensure t
  :custom ;;
  (magit-diff-refine-hunk 'all)
  (magit-diff-refine-ignore-whitespace nil)
  :bind ;;
  ("C-x g" . magit-status)
  ("C-c g" . magit-file-dispatch))

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
  rg
  :ensure t
  :config (rg-enable-menu))

(use-package
  direnv
  :ensure t
  :config (direnv-mode 1)
  :hook (flycheck-before-syntax-check . direnv-update-environment))

(use-package
  docker
  :ensure t
  :bind ("C-c d" . docker))

;; emacs-lisp

(defun my/emacs-lisp-hook ()
  (add-hook 'before-save-hook 'my/emacs-lisp-format nil t))

(defun my/emacs-lisp-format ()
  (elisp-format-buffer)
  (elisp-format-buffer))

(use-package
  elisp-mode
  :hook (emacs-lisp-mode . my/emacs-lisp-hook))

(use-package
  elisp-format
  :ensure t
  :defer)

;; docker

(use-package
  dockerfile-mode
  :ensure t
  :hook (dockerfile-mode . my/indent-hook))

;; dotenv

(use-package
  dotenv-mode
  :ensure t
  :mode "\\.env\\..*\\'"
  :hook (dotenv-mode . my/indent-hook))

;; fish

(defun my/fish-hook ()
  (add-hook 'before-save-hook 'fish_indent nil t))

(use-package
  fish-mode
  :ensure t
  :hook (fish-mode . my/fish-hook))

;; git

(use-package
  gitconfig-mode
  :ensure t
  :hook (gitconfig-mode . my/indent-hook))

(use-package
  gitignore-mode
  :ensure t
  :hook (gitignore-mode . my/indent-hook))

;; json

(use-package
  json-mode
  :ensure t
  :custom (js-indent-level 2)
  :hook (json-mode . prettier-js-mode))

;; markdown

(use-package
  markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :config (flycheck-add-next-checker 'markdown-mdl 'proselint)
  :hook (markdown-mode . prettier-js-mode))

;; python

(use-package
  anaconda-mode
  :ensure t
  :diminish
  :config (evil-define-key 'normal anaconda-mode-map ;
            "gd" 'anaconda-mode-find-definitions     ;
            "gh" 'anaconda-mode-show-doc             ;
            "gr" 'anaconda-mode-find-references      ;
            "gs" 'anaconda-mode-find-assignments)
  :hook ;;
  (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode))

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

;; shell

(reformatter-define shell-format
  :program "shfmt")

(use-package
  sh-script
  :hook (sh-mode . shell-format-on-save-mode))

(defvar my/shell-backend
  '(:separate company-fish-shell
              company-shell
              company-shell-env
              :with ;;
              company-files
              company-dabbrev-code))

(use-package
  company-shell
  :ensure t
  :after (:any sh-script
               fish-mode)
  :config (push my/shell-backend company-backends)
  :custom (company-shell-clean-manpage t))

;; web

(use-package
  web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.erb\\'")
  :config (flycheck-add-mode 'html-tidy 'web-mode)
  :custom ;;
  (flycheck-tidyrc "~/.tidyrc.txt")
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-script-padding 2)
  (web-mode-style-padding 2)
  :hook (web-mode . my/indent-hook)
  :bind ;;
  ("C-c w" . web-mode))

(defvar my/web-backend
  '(:separate company-web-html
              :with ;;
              company-files
              company-dabbrev))

(use-package
  company-web
  :ensure t
  :after web-mode
  :config (push my/web-backend company-backends))

(use-package
  css-mode
  :custom (css-indent-offset 2)
  :hook (css-mode . prettier-js-mode))

(use-package
  prettier-js
  :ensure t
  :diminish
  :defer)

;; yaml

(use-package
  yaml-mode
  :ensure t
  :hook (yaml-mode . prettier-js-mode))

;; experimental

(provide 'init)
;;; init.el ends here

;; Local Variables:
;; byte-compile-warnings: (not free-vars noruntime)
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
