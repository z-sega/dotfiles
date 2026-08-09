;;; init-dev.el --- Dev -*- lexical-binding: t; -*-
;;; Commentary:
;; - TODO: Get topsy

;;; Code:
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package flycheck
  :config
  (global-flycheck-mode)
  :bind
  (:map flycheck-mode-map
        ("M-n" . flycheck-next-error)
        ("M-p" . flycheck-previous-error)))

(use-package nhexl-mode)

(use-package exec-path-from-shell
  :ensure nil
  :config
  (exec-path-from-shell-initialize))

(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package which-key
  :config (which-key-mode))

(use-package paredit
  :bind
  (:map paredit-mode-map
        ("M-s" . nil)))

(use-package rainbow-delimiters)

(use-package all-the-icons)

(use-package nerd-icons)


(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package vterm)

(use-package logview)

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))

(use-package dape
  ;; :preface
  ;; By default dape shares the same keybinding prefix as `gud'
  ;; If you do not want to use any prefix, set it to nil.
  ;; (setq dape-key-prefix "\C-x\C-a")

  ;; :hook
  ;; Save breakpoints on quit
  ;; (kill-emacs . dape-breakpoint-save)
  ;; Load breakpoints on startup
  ;; (after-init . dape-breakpoint-load)

  ;; :config
  ;; Turn on global bindings for setting breakpoints with mouse
  ;; (dape-breakpoint-global-mode)

  ;; Info buffers to the right
  ;; (setq dape-buffer-window-arrangement 'right)

  ;; Info buffers like gud (gdb-mi)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; (setq dape-info-hide-mode-line nil)

  ;; Pulse source line (performance hit)
  ;; (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

  ;; Showing inlay hints
  ;; (setq dape-inlay-hints t)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

  ;; Kill compile buffer on build success
  ;; (add-hook 'dape-compile-hook 'kill-buffer)

  ;; Projectile users
  ;; (setq dape-cwd-function 'projectile-project-root)
  )

(use-package hideshow ; built-in
  :commands (hs-cycle
             hs-global-cycle)
  :bind (:map prog-mode-map
              ("C-<tab>" . hs-cycle)
              ("<backtab>" . hs-global-cycle)
              ("C-S-<iso-lefttab>" . hs-global-cycle))
  :config
  (setq hs-hide-comments-when-hiding-all nil
        ;; Nicer code-folding overlays (with fringe indicators)
        hs-set-up-overlay #'hideshow-set-up-overlay-fn)

  (defface hideshow-folded-face
    `((t (:inherit font-lock-comment-face :weight light)))
    "Face to hightlight `hideshow' overlays."
    :group 'hideshow)

  (defun hideshow-set-up-overlay-fn (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (overlay-put
       ov 'display (propertize "  [...]  " 'face 'hideshow-folded-face))))

  (dolist (hs-command (list #'hs-cycle
                            #'hs-global-cycle))
    (advice-add hs-command :before
                (lambda (&optional end) "Advice to ensure `hs-minor-mode' is enabled"
                  (unless (bound-and-true-p hs-minor-mode)
                    (hs-minor-mode +1)))))

  (defun hs-cycle (&optional level)
    (interactive "p")
    (save-excursion
      (if (= level 1)
          (pcase last-command
            ('hs-cycle
             (hs-hide-level 1)
             (setq this-command 'hs-cycle-children))
            ('hs-cycle-children
             ;;TODO: Fix this case. `hs-show-block' needs to be called twice to
             ;;open all folds of the parent block.
             (hs-show-block)
             (hs-show-block)
             (setq this-command 'hs-cycle-subtree))
            ('hs-cycle-subtree
             (hs-hide-block))
            (_
             (if (not (hs-already-hidden-p))
                 (hs-hide-block)
               (hs-hide-level 1)
               (setq this-command 'hs-cycle-children))))
        (hs-hide-level level)
        (setq this-command 'hs-hide-level))))

  (defun hs-global-cycle ()
    (interactive)
    (pcase last-command
      ('hs-global-cycle
       (save-excursion (hs-show-all))
       (setq this-command 'hs-global-show))
      (_ (hs-hide-all))))  

  ;; extra folding support for more languages
  (unless (assq 't hs-special-modes-alist)
    (setq hs-special-modes-alist
          (append
           '((vimrc-mode "{{{" "}}}" "\"")
             ;; (yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>"
             ;;            ""
             ;;            "#"
             ;;            +fold-hideshow-forward-block-by-indent-fn nil)
             ;; (haml-mode "[#.%]" "\n" "/" +fold-hideshow-haml-forward-sexp-fn nil)
             ;; (ruby-mode "class\\|d\\(?:ef\\|o\\)\\|module\\|[[{]"
             ;;            "end\\|[]}]"
             ;;            "#\\|=begin"
             ;;            ruby-forward-sexp)
             ;; (enh-ruby-mode "class\\|d\\(?:ef\\|o\\)\\|module\\|[[{]"
             ;;                "end\\|[]}]"
             ;;                "#\\|=begin"
             ;;                enh-ruby-forward-sexp nil)
             (matlab-mode "^\s*if\\|switch\\|case\\|otherwise\\|while\\|^\s*for\\|try\\|catch\\|function"
                          "end"
                          "" (lambda (_arg) (matlab-forward-sexp)))
             (nxml-mode "<!--\\|<[^/>]*[^/]>"
                        "-->\\|</[^/>]*[^/]>"
                        "<!--" sgml-skip-tag-forward nil))
           hs-special-modes-alist
           '((t))))))


(use-package tramp
  :config
  ;; Enable full-featured Dirvish over TRAMP on ssh connections
  ;; https://www.gnu.org/software/tramp/#Improving-performance-of-asynchronous-remote-processes
  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))
  (connection-local-set-profiles
   '(:application tramp :protocol "ssh")
   'remote-direct-async-process)
  ;; Tips to speed up connections
  (setq tramp-verbose 0)
  (setq tramp-chunksize 2000)
  (setq tramp-ssh-controlmaster-options nil))

(with-eval-after-load 'tramp
  ;; Tell Tramp to respect the remote system's $PATH
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; tree-sitter
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (tsx-mode . tsx-ts-mode)
        (js-mode . js-ts-mode)
        (js2-mode . js-ts-mode)
        (python-mode . python-ts-mode)))

;; Vue
(use-package mmm-mode
  :ensure nil
  :hook
  (mmm-mode . (lambda ()
                (set-face-background 'mmm-default-submode-face nil))))

(add-to-list 'load-path (concat user-emacs-directory "vue-html-mode"))
(require 'vue-html-mode)

(add-to-list 'load-path (concat user-emacs-directory "ssass-mode"))
(require 'ssass-mode)

(add-to-list 'load-path (concat user-emacs-directory "vue-mode"))
(require 'vue-mode)

;; Rust
(use-package rustic
  :config
  (setq rustic-format-on-save t))

;; Elm
(use-package elm-mode)

;; Haskell
(use-package haskell-mode)

;; Javascript/Typescript
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(use-package tide
  :after (corfu flycheck)
  :hook ((typescript-ts-mode . tide-setup)
    	 (tsx-ts-mode . tide-setup)
    	 (typescript-ts-mode . tide-hl-identifier-mode)
    	 (before-save . tide-format-before-save)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (corfu-mode +1))

;; aligns annotation to the right hand side
					; (setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)

(add-hook 'tsx-ts-mode-hook #'setup-tide-mode)


;; CSV
(use-package csv-mode)
(require 'color)
(defun csv-highlight (&optional separator)
  (interactive (list (when current-prefix-arg (read-char "Separator: "))))
  (font-lock-mode 1)
  (let* ((separator (or separator ?\,))
         (n (count-matches (string separator) (pos-bol) (pos-eol)))
         (colors (cl-loop for i from 0 to 1.0 by (/ 2.0 n)
                          collect (apply #'color-rgb-to-hex 
                                         (color-hsl-to-rgb i 0.3 0.5)))))
    (cl-loop for i from 2 to n by 2 
             for c in colors
             for r = (format "^\\([^%c\n]+%c\\)\\{%d\\}" separator separator i)
             do (font-lock-add-keywords nil `((,r (1 '(face (:foreground ,c)))))))))

(add-hook 'csv-mode-hook 'csv-highlight)
(add-hook 'csv-mode-hook 'csv-align-mode)
(add-hook 'csv-mode-hook '(lambda () (interactive) (toggle-truncate-lines nil)))


;; Commonlisp
(use-package sly
  :hook
  ((lisp-mode . paredit-mode)
   (lisp-mode . rainbow-delimiters-mode))
  :config
  (setq sly-contribs '(sly-fancy))
  (setq inferior-lisp-program "sbcl"))

(use-package sly-quicklisp)

;; Scheme
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'rainbow-delimiters-mode)

(use-package geiser)

(use-package geiser-guile
  :after geiser)

(use-package racket-mode
  :hook
  ((racket-mode . racket-xp-mode)
   (racket-mode . paredit-mode)
   (racket-mode . rainbow-delimiters-mode)
   (racket-mode . racket-input-mode)))


(provide 'init-dev)
;;; init-dev.el ends here
