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
  (require 'use-package))

(add-hook 'window-setup-hook 'toggle-frame-fullscreen)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)

(line-number-mode 1)
(column-number-mode 1)

(delete-selection-mode 1)
(electric-pair-mode 1)
(show-paren-mode 1)

(set-face-attribute 'default nil
                    :family "Hack"
                    :height (if (eq system-type 'darwin) 140 130))

(setq enable-recursive-minibuffers t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq require-final-newline t)
(setq save-interprogram-paste-before-kill t)
(setq split-height-threshold nil)
(setq uniquify-buffer-name-style 'post-forward)

(setq-default indent-tabs-mode nil)
(setq-default line-spacing 3)
(setq-default tab-width 4)
(setq-default truncate-lines t)

(setq auto-save-file-name-transforms '((".*"  "~/.config/emacs/auto-save/" t)))
(setq backup-directory-alist         '(("." . "~/.config/emacs/backup/")))
(setq custom-file                             "~/.config/emacs/null.el")
(setq trash-directory                         "~/.config/emacs/trash/")

(fset 'yes-or-no-p 'y-or-n-p)

(defgroup my nil
  ""
  :group 'placeholder)

(defun my-whitespace-hook ()
  (add-hook 'before-save-hook 'whitespace-cleanup nil t))

(add-hook 'text-mode-hook 'my-whitespace-hook)
(add-hook 'prog-mode-hook 'my-whitespace-hook)
(add-hook 'conf-mode-hook 'my-whitespace-hook)

(define-minor-mode indent-on-save-mode ""
  :lighter nil
  (if indent-on-save-mode
      (add-hook 'before-save-hook 'my-indent-buffer nil t)
    (remove-hook 'before-save-hook 'my-indent-buffer t)))

(defun my-indent-buffer ()
  (save-excursion (indent-region (point-min)
                                 (point-max))))

(bind-key "C-c l" 'display-line-numbers-mode)
(bind-key "C-c v" 'visual-line-mode)

(bind-key "C-c a" 'align-regexp)
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
  :custom
  (ispell-extra-args '("--run-together"))
  (ispell-program-name "aspell")
  :hook ((text-mode prog-mode conf-mode) . flyspell-mode))

(defun my-colourise-compilation ()
  (ansi-color-apply-on-region compilation-filter-start
                              (point)))

(use-package
  ansi-color
  :hook (compilation-filter . my-colourise-compilation))

(use-package
  eldoc
  :diminish)

(use-package
  vc
  :config (delete '(vc-mode vc-mode) mode-line-format))

(use-package
  exec-path-from-shell
  :if (eq window-system 'ns)
  :ensure t
  :config
  (push "ASPELL_CONF" exec-path-from-shell-variables)
  (push "NODE_PATH" exec-path-from-shell-variables)
  (exec-path-from-shell-initialize))

(use-package
  solarized-theme
  :ensure t
  :config (load-theme 'solarized-light t))

(use-package
  diminish
  :ensure t)

(defun my-prefix ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-c"))))

(use-package
  evil
  :ensure t
  :init (evil-mode 1)
  :config
  (evil-global-set-key 'normal (kbd "SPC") 'my-prefix)
  (evil-global-set-key 'visual (kbd "SPC") 'my-prefix)
  (evil-global-set-key 'normal (kbd "M-.") nil)
  :custom
  (evil-cross-lines t)
  (evil-default-state "emacs")
  (evil-normal-state-modes '(text-mode prog-mode conf-mode))
  (evil-undo-system 'undo-tree)
  (evil-want-C-u-delete t)
  (evil-want-C-u-scroll t))

(use-package
  undo-tree
  :ensure t
  :diminish
  :config (global-undo-tree-mode))

(use-package
  which-key
  :ensure t
  :diminish
  :config (which-key-mode 1))

(use-package
  ace-window
  :ensure t
  :diminish
  :custom (aw-dispatch-always t)
  :bind ("M-o" . ace-window))

(use-package
  avy
  :ensure t
  :bind ("C-c SPC" . avy-goto-char-timer))

(defun my-ivy-setup ()
  (ivy-mode 1)
  (advice-add 'ivy--minibuffer-setup
              :after (lambda ()
                       (setq line-spacing 3)))
  (ivy-configure 'counsel-M-x :sort-fn #'ivy-string<)
  (ivy-configure 'counsel-describe-function :sort-fn #'ivy-string<)
  (ivy-configure 'counsel-describe-variable :sort-fn #'ivy-string<))

(use-package
  counsel
  :ensure t
  :demand t
  :diminish ivy-mode
  :config (my-ivy-setup)
  :bind
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
  :config (global-company-mode)
  :custom
  (company-idle-delay 0.3)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  :bind (:map company-mode-map
              ("<tab>" . company-indent-or-complete-common)
              ("<backtab>" . company-other-backend))
  :hook (special-mode . (lambda ()
                          (company-mode 0))))

(use-package
  yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config (yas-global-mode))

(use-package
  dumb-jump
  :ensure t
  :config (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :custom (dumb-jump-force-searcher 'rg))

(defvar my-flycheck-buffer
  '("flycheck errors"
    (display-buffer-reuse-window display-buffer-in-side-window)
    (window-height . 0.2)))

(use-package
  flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (add-to-list 'display-buffer-alist my-flycheck-buffer))

(defun my-flycheck-icons (info warnings errors)
  (list
   (my-flycheck-icon "info" info)
   (my-flycheck-icon "warning" warnings)
   (my-flycheck-icon "error" errors)))

(defun my-flycheck-icon (type count)
  (cond
   ((> count 0)
    (let ((icon (intern-soft (concat "flycheck-indicator-icon-" type)))
          (face (intern-soft (concat "flycheck-indicator-" type))))
      (propertize (format " %c%s" (symbol-value icon) count)
                  'font-lock-face face)))
   (t "")))

(use-package
  flycheck-indicator
  :ensure t
  :config (advice-add 'flycheck-indicator--icons-formatter
                      :override #'my-flycheck-icons)
  :hook (flycheck-mode . flycheck-indicator-mode))

(use-package
  reformatter
  :ensure t)

(use-package
  magit
  :ensure t
  :custom
  (magit-diff-refine-hunk 'all)
  (magit-diff-refine-ignore-whitespace nil)
  :bind
  ("C-x g" . magit-status)
  ("C-c g" . magit-file-dispatch))

(use-package
  projectile
  :ensure t
  :diminish
  :commands projectile-project-root
  :config (projectile-mode 1)
  :custom (projectile-completion-system 'ivy)
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

;; docker

(use-package
  dockerfile-mode
  :ensure t
  :hook (dockerfile-mode . indent-on-save-mode))

;; dotenv

(use-package
  dotenv-mode
  :ensure t
  :mode "\\.env\\..*\\'"
  :hook (dotenv-mode . indent-on-save-mode))

;; emacs-lisp

(use-package
  elisp-mode
  :hook (emacs-lisp-mode . indent-on-save-mode))

;; fish

(reformatter-define fish-format
  :program "fish_indent")

(use-package
  fish-mode
  :ensure t
  :hook (fish-mode . fish-format-on-save-mode))

;; git

(use-package
  gitconfig-mode
  :ensure t
  :hook (gitconfig-mode . indent-on-save-mode))

(use-package
  gitignore-mode
  :ensure t
  :hook (gitignore-mode . indent-on-save-mode))

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

(use-package
  edit-indirect
  :ensure t
  :defer)

;; nix

(reformatter-define nix-format
  :program "nixfmt")

(use-package
  nix-mode
  :ensure t
  :hook (nix-mode . nix-format-on-save-mode))

;; ocaml

(reformatter-define ocaml-format
  :program "ocamlformat"
  :args (list "--name" buffer-file-name
              "-"))

(use-package
  tuareg
  :ensure t
  :hook (tuareg-mode . ocaml-format-on-save-mode))

(use-package
  merlin
  :ensure t
  :diminish
  :custom
  (merlin-command "ocamlmerlin")
  (merlin-completion-with-doc t)
  (merlin-error-after-save nil)
  :custom-face
  (merlin-type-face ((t (:inherit 'highlight))))
  :bind (:map merlin-mode-map
              ("M-/" . merlin-document))
  :hook
  (tuareg-mode . merlin-mode)
  (tuareg-mode
   . (lambda ()
       (add-hook 'xref-backend-functions #'merlin-xref-backend nil t))))

(use-package
  merlin-eldoc
  :ensure t
  :custom (merlin-eldoc-type-verbosity 'min)
  :hook (merlin-mode . merlin-eldoc-setup))

(use-package
  flycheck-ocaml
  :ensure t
  :config (flycheck-ocaml-setup))

(use-package
  utop
  :ensure t
  :diminish utop-minor-mode
  :config
  (defun tuareg--after-double-colon () nil)
  (defun tuareg--skip-double-colon () nil)
  :hook (tuareg-mode . utop-minor-mode))

(use-package
  dune
  :ensure t
  :hook (dune-mode . indent-on-save-mode))

;; python

(use-package
  anaconda-mode
  :ensure t
  :diminish
  :bind (:map anaconda-mode-map
              ("M-." . nil)
              ("M-/" . anaconda-mode-show-doc)
              ("M-?" . nil))
  :hook
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

;; ruby

(reformatter-define ruby-format
  :program "rubocopfmt"
  :args (list buffer-file-name))

(use-package
  ruby-mode
  :hook (ruby-mode . ruby-format-on-save-mode))

(use-package
  robe
  :ensure t
  :diminish
  :init (push 'company-robe company-backends)
  :config (advice-add 'robe-find-file
                      :filter-args #'my-robe-path-mapping)
  :bind (:map robe-mode-map
              ("M-/" . robe-doc))
  :hook
  (ruby-mode . robe-mode))

(defun my-robe-path-mapping (args)
  (if (bound-and-true-p docker-cwd)
      (cons (concat (projectile-project-root)
                    (file-relative-name (car args) docker-cwd))
            (cdr args))
    args))

;; scheme

(use-package
  scheme
  :hook (scheme-mode . indent-on-save-mode))

;; shell

(reformatter-define shell-format
  :program "shfmt")

(use-package
  sh-script
  :hook (sh-mode . shell-format-on-save-mode))

(defvar my-shell-backend
  '(:separate company-fish-shell
              company-shell
              company-shell-env
              :with
              company-files
              company-dabbrev-code))

(use-package
  company-shell
  :ensure t
  :after (:any sh-script
               fish-mode)
  :config (push my-shell-backend company-backends)
  :custom (company-shell-clean-manpage t))

;; sql

(reformatter-define sql-format
  :program "sqlformat"
  :args (list "--keywords" "upper"
              "--reindent"
              "-"))

(use-package
  sql
  :hook (sql-mode . sql-format-on-save-mode))

;; web

(defun my-auto-enable-minor-mode (mode extension)
  (when (string= (file-name-extension buffer-file-name)
                 extension)
    (funcall mode 1)))

(use-package
  web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.erb\\'")
  :config (flycheck-add-mode 'html-tidy 'web-mode)
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-script-padding 2)
  (web-mode-style-padding 2)
  :hook
  (web-mode . indent-on-save-mode)
  (web-mode . (lambda ()
                (my-auto-enable-minor-mode 'robe-mode "erb"))))

(defvar my-web-backend
  '(:separate company-web-html
              :with
              company-dabbrev-code))

(use-package
  company-web
  :ensure t
  :after web-mode
  :config (push my-web-backend company-backends))

(use-package
  css-mode
  :custom (css-indent-offset 2)
  :hook (css-mode . prettier-js-mode))

(use-package
  emmet-mode
  :ensure t
  :diminish
  :custom
  (emmet-move-cursor-between-quotes t)
  (emmet-self-closing-tag-style " /")
  :hook (web-mode css-mode))

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
;; byte-compile-warnings: (not free-vars noruntime unresolved)
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
