;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; corfu config
(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt

  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :init
  (global-corfu-mode))

;; corfu - nerd icon config
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; performance settings
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)

;; lsp settings
(setq lsp-java-format-on-type-enabled nil)
(setq lsp-completion-show-detail t)
(setq lsp-enable-on-type-formatting t)

(setq lsp-ui-peek-enable nil)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-signature-render-documentation t)
(setq lsp-completion-show-kind t)

(use-package lsp-mode)

(add-to-list 'default-frame-alist
             '(font . "IBM Plex Mono SmBld-10"))

;; dired settings
(lsp-dired-mode t)
(remove-hook! 'dired-mode-hook #'dired-omit-mode)

;; treesitter settings
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; tabs settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-width 4)
(setq c-basic-offset 4)

;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; enable tramp mode for ssh
(setq tramp-default-method "ssh")
(setq tramp-verbose 1)
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; vertico settings
(setq vertico-resize t)
(setq enable-recursive-minibuffers t)
(use-package vertico
  :general
  (:keymaps 'vertico-map
            "M-RET" #'minibuffer-force-complete-and-exit
            "M-TAB" #'minibuffer-complete
            "<escape>" #'minibuffer-keyboard-quit
            "C-M-n" #'vertico-next-group
            "C-M-p" #'vertico-previous-group))

;; automatically open latex pdf next to editor
(setq +latex-viewers '(pdf-tools))

;;vterm keybinds
(use-package vterm
  :config
  (setq vterm-timer-delay nil)
  )
(global-set-key (kbd "M-T") 'vterm)

;;(require 'org-superstar)
;;(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;;(setq org-agenda-span 30) ;; agenda shows next 30 days
;;(setq org-agenda-todo-ignore-deadlines 1) ;; ignores global todos with deadlines
;;(setq org-deadline-warning-days 1)
;;(setq org-agenda-todo-ignore-scheduled 1)

(custom-set-variables
 '(company-backends '(company-capf) ))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "itskia2"
      user-mail-address "itskia2@proton.me")

;; set calendar beginning of week to monday
(setq calendar-week-start-day 1)

;; save password
(setq epa-file-cache-passphrase-for-symmetric-encryption nil)
(setq password-cache-expiry nil)
(setq password-cache 1)

;; disable custom.el
(setq custom-file "~/.emacs.d/custom-init.el")

;;Recreating scratch buffer
;; If the *scratch* buffer is killed, recreate it automatically
(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))

(defun kill-scratch-buffer ()
  ;; The next line is just in case someone calls this manually
  (set-buffer (get-buffer-create "*scratch*"))
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))
  ;; Make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that.
  nil)

;; fun stuff
(require 'fireplace)

;;Helm keybinds
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "M-x") #'helm-M-x)
;;(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;;(global-set-key (kbd "C-x C-f") #'helm-find-files)
;;(helm-mode 1)

;; used to make lsp faster, using plist instead of hashmap
;; need to include export LSP_USE_PLISTS=true in env var
;;(setq lsp-use-plists t
;;      read-process-output-max (* 1024 1024)) ;; 1mb


;; window custom frame settings
;;(add-to-list 'default-frame-alist '(height . 40))
;;(add-to-list 'default-frame-alist '(width . 140))
;;(set-frame-height (selected-frame) 40)
;;(set-frame-width (selected-frame) 140)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-feather-dark)
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-challenger-deep)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "/home/kia/Documents")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
