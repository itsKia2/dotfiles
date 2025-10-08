
;; zig treesitter not available by default - install manually
(setq treesit-language-source-alist
      '((zig "https://github.com/maxxnino/tree-sitter-zig")))
;; Install the grammar automatically if missing
(unless (treesit-language-available-p 'zig)
  (ignore-errors (treesit-install-language-grammar 'zig)))

(dolist (mapping '((c-mode          . c-ts-mode)
                   (c++-mode        . c++-ts-mode)
                   (python-mode     . python-ts-mode)
                   (bash-mode       . bash-ts-mode)
                   (js-mode         . js-ts-mode)
                   (typescript-mode . typescript-ts-mode)
                   (json-mode       . json-ts-mode)
                   (css-mode        . css-ts-mode)
                   (html-mode       . html-ts-mode)
                   (yaml-mode       . yaml-ts-mode)
                   (go-mode         . go-ts-mode)
                   (rust-mode       . rust-ts-mode)
                   (java-mode       . java-ts-mode)
                   (ruby-mode       . ruby-ts-mode)
                   (toml-mode       . toml-ts-mode)
                   (php-mode        . php-ts-mode)
                   (lua-mode        . lua-ts-mode)
                   (cmake-mode      . cmake-ts-mode)
                   (makefile-mode   . makefile-ts-mode)
                   (dockerfile-mode . dockerfile-ts-mode)
                   (tsx-mode        . tsx-ts-mode)))
  (add-to-list 'major-mode-remap-alist mapping))

(after! lsp-mode
  ;; Map ts-modes to language IDs
  (dolist (mapping '((c-ts-mode          . "c")
		     (c++-ts-mode        . "cpp")
		     (python-ts-mode     . "python")
		     (bash-ts-mode       . "bash")
		     (js-ts-mode         . "javascript")
		     (typescript-ts-mode . "typescript")
		     (json-ts-mode       . "json")
		     (css-ts-mode        . "css")
		     (html-ts-mode       . "html")
		     (yaml-ts-mode       . "yaml")
		     (go-ts-mode         . "go")
		     (rust-ts-mode       . "rust")
		     (java-ts-mode       . "java")
		     (ruby-ts-mode       . "ruby")
		     (toml-ts-mode       . "toml")
		     (php-ts-mode        . "php")
		     (lua-ts-mode        . "lua")
		     (cmake-ts-mode      . "cmake")
		     (makefile-ts-mode   . "make")
		     (dockerfile-ts-mode . "dockerfile")
		     (tsx-ts-mode        . "typescriptreact")))
    (add-to-list 'lsp-language-id-configuration mapping))

  (dolist (mode '(c-ts-mode
		  c++-ts-mode
		  python-ts-mode
		  bash-ts-mode
		  js-ts-mode
		  typescript-ts-mode
		  json-ts-mode
		  css-ts-mode
		  html-ts-mode
		  yaml-ts-mode
		  go-ts-mode
		  rust-ts-mode
		  java-ts-mode
		  ruby-ts-mode
		  toml-ts-mode
		  php-ts-mode
		  lua-ts-mode
		  cmake-ts-mode
		  makefile-ts-mode
		  dockerfile-ts-mode
		  tsx-ts-mode
		  zig-ts-mode))
    (add-hook (intern (format "%s-hook" mode)) #'lsp-deferred)))

;; zig mode isnt supported so install sep from package.el
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode))
