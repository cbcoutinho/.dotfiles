(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)
(package-refresh-contents)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
             :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
    'minibuffer-complete-word
    'self-insert-command
    minibuffer-local-completion-map)
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))


;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
             :init (global-flycheck-mode))

(use-package lsp-mode
             ;; Optional - enable lsp-mode automatically in scala files
             :hook  (scala-mode . lsp)
             (lsp-mode . lsp-lens-mode)
             :config (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Enable nice rendering of documentation on hover
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(use-package company-lsp)

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe)
;; Posframe is a pop-up tool that must be manually installed for dap-mode

(use-package dap-mode
             :hook
             (lsp-mode . dap-mode)
             (lsp-mode . dap-ui-mode))


;; Use the Tree View Protocol for viewing the project structure and triggering compilation
(use-package lsp-treemacs
             :config
             (lsp-metals-treeview-enable t)
             (setq lsp-metals-treeview-show-when-views-received t))


;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'notmuch)
(require 'evil)
(evil-mode 1)

(use-package parinfer
             :ensure t
             :bind
             (("C-," . parinfer-toggle-mode))
             :init
             (progn
               (setq parinfer-extensions
                     '(defaults       ; should be included.
                        pretty-parens  ; different paren styles for different modes.
                        evil           ; If you use Evil.
                        lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
                        paredit        ; Introduce some paredit commands.
                        smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
                        smart-yank))   ; Yank behavior depend on mode.
               (add-hook 'clojure-mode-hook #'parinfer-mode)
               (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
               (add-hook 'common-lisp-mode-hook #'parinfer-mode)
               (add-hook 'scheme-mode-hook #'parinfer-mode)
               (add-hook 'lisp-mode-hook #'parinfer-mode)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(ansi-color-faces-vector
    [default default default italic underline success warning error])
  '(ansi-color-names-vector
    ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
  '(custom-enabled-themes (quote (deeper-blue)))
  '(delete-selection-mode nil)
  '(package-selected-packages
    (quote
      (org evil clojure-mode rainbow-delimiters parinfer))))
(custom-set-faces)
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
