;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(require 'fireplace)

;; whoami
(setq user-full-name "itskia2"
      user-mail-address "itskia2@proton.me")

;; start in max window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; blink cursor
(blink-cursor-mode 1)

;; doom theme - line numbers - font
(setq doom-theme 'doom-moonlight)
(setq display-line-numbers-mode t)
(setq global-completion-preview-mode t)
(setq doom-font (font-spec :family "IBM Plex Mono" :size 14 :weight 'bold)
      doom-variable-pitch-font (font-spec :family "IBM Plex Mono"))

;; tabs settings
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq tab-width 4)

;; disable ugly indentation highlighting
(setq global-whitespace-mode nil)
(setq whitespace-global-modes nil)

;; Version control optimization
(setq vc-handled-backends '(Git))

;; scrolling settings (supposedly makes it faster)
(pixel-scroll-precision-mode 1)
(pixel-scroll-mode nil)
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; treesitter settings
(use-package treesit
  :config
  (setq treesit-font-lock-level 4))

(use-package! treesit-auto
  :init
  (setq treesit-auto-install t)
  :config
  (global-treesit-auto-mode -1))

(load! "treesit")

;; lsp settings
(setq lsp-java-format-on-type-enabled nil)
(setq lsp-completion-show-detail t)
(setq lsp-enable-on-type-formatting t)
(setq lsp-enable-format-on-save t)

(setq lsp-ui-peek-enable nil)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-signature-render-documentation nil)
(setq lsp-completion-show-kind t)

(use-package lsp-mode)

;; enable tramp mode for ssh
(setq tramp-inline-compress-start-size 1000)
(setq remote-file-name-inhibit-cache nil)
(setq tramp-chunksize 3000)
(setq tramp-copy-size-limit 10000)
(setq tramp-default-method "ssh")
(setq projectile-mode-line "Projectile")
(setq tramp-verbose 0)

;; autosave (disabled with tramp)
(setq auto-save-default t)

;; dired settings
;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)
(lsp-dired-mode t)
(remove-hook! 'dired-mode-hook #'dired-omit-mode)
(setq dired-kill-when-opening-new-dired-buffer t)

;; doom dashboard settings
;;(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(setq fancy-splash-image (concat doom-user-dir "vagabond.png"))
(setq +doom-dashboard-banner-padding '(2 . 3))
(setq +doom-dashboard-menu-sections
      (seq-filter (lambda (item)
		    (member (car item) '("Recently opened files" "Open project" "Open private configuration")))
		  +doom-dashboard-menu-sections))

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

;; corfu config
(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
  (corfu-echo-mode t)       ;; Shows documentation next to corfu popup
  (corfu-auto-delay 0.3)

  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
	("TAB" . corfu-next)
	([tab] . corfu-next)
	("S-TAB" . corfu-previous)
	([backtab] . corfu-previous))

  :init
  (global-corfu-mode)
  (corfu-history-mode))

;; org mode settings
(setq org-hide-emphasis-markers t)
(setq org-src-fontify-natively t)

;; corfu - nerd icon config
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; performance settings
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))
(setq read-process-output-max (* 64 1024 1024))

;; automatically open latex pdf next to editor
(setq +latex-viewers '(pdf-tools))

;; custom file
(setq custom-file "~/.config/doom/custom.el")

;;vterm keybinds
(use-package vterm
  :config
  (setq vterm-timer-delay nil)
  )
(global-set-key (kbd "M-T") 'vterm)

;; set calendar beginning of week to monday
(setq calendar-week-start-day 1)
(setq epa-file-cache-passphrase-for-symmetric-encryption nil)
(setq password-cache-expiry nil)
(setq password-cache 1)

;; python virtual envs
;; (use-package pet
;;   :config
;;   (add-hook 'python-base-mode-hook 'pet-mode -10)
;;   (add-hook 'python-ts-mode-hook
;;             (lambda ()
;;               (setq-local python-shell-interpreter (pet-executable-find "python")
;;                           python-shell-virtualenv-root (pet-virtualenv-root)))))

;;Recreating scratch buffer
;; If the *scratch* buffer is killed, recreate it automatically
(with-current-buffer
    (set-buffer (get-buffer-create "*scratch*"))
  (org-mode)
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
  (org-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that.
  nil)
