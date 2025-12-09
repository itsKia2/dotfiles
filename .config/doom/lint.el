;;; lint.el --- Flycheck integration for Actionlint, SQLFluff, YAMLLint

;; enable flycheck globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; use prettier for typescript/javascript formatting
(when (executable-find "prettier")
  (setq-hook! '(typescript-ts-mode-hook
		tsx-ts-mode-hook
		js-ts-mode-hook)
    +format-with 'prettier
    +format-with-lsp nil))

(after! flycheck
  ;; Actionlint (GitHub Actions workflows)
  (when (executable-find "actionlint")
    (flycheck-define-checker github-actionlint
      "GitHub Actions workflow checker using actionlint."
      :command ("actionlint" "-no-color" source)
      :error-patterns
      ((error line-start (file-name) ":" line ":" column ": " (message) line-end)
       (warning line-start (file-name) ":" line ":" column ": " (message) line-end))
      :modes (yaml-mode yaml-ts-mode)
      :predicate (lambda ()
                   (and buffer-file-name
                        (string-match-p "/\\.github/workflows/" buffer-file-name))))
    (add-to-list 'flycheck-checkers 'github-actionlint))

  ;; SQLFluff (SQL files)
  (when (executable-find "sqlfluff")
    (flycheck-define-checker sql-sqlfluff
      "SQLFluff SQL linter."
      :command ("sqlfluff" "lint" "--nocolor" source)
      :error-patterns
      ((error line-start (file-name) ":" line ":" column ": " (message) line-end)
       (warning line-start (file-name) ":" line ":" column ": " (message) line-end))
      :modes sql-mode)
    (add-to-list 'flycheck-checkers 'sql-sqlfluff))

  ;; YAMLLint (YAML files)
  (when (executable-find "yamllint")
    (setq flycheck-yamllint-executable "yamllint")))

;; Disable LSP diagnostics only for GitHub workflow files
;; so Actionlint takes precedence
(add-hook 'yaml-ts-mode-hook
          (lambda ()
            (when (and buffer-file-name
                       (string-match-p "/\\.github/workflows/" buffer-file-name))
              (setq-local lsp-diagnostics-provider :none))))

;; use yamllint when available and format on save
(add-hook 'yaml-ts-mode-hook
          (lambda ()
            (when (executable-find "yamllint")
              (setq-local lsp-diagnostics-provider :none)
              (flycheck-select-checker 'yaml-yamllint)
              (add-hook 'after-save-hook #'flycheck-buffer nil t))))
