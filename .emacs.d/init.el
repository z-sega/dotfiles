(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; ------------------ BUFFERS

(global-set-key [remap list-buffers] 'ibuffer)

;; ------------------ bsl-scratch

(defun insert-in-buffer (BUFFER-NAME TEXT)
  "Insert TEXT into buffer named BUFFER-NAME"
  (with-current-buffer BUFFER-NAME
    (goto-char (point-max))
    (insert TEXT)))

(defun create-bsl-buffer ()
  (interactive)
  (switch-to-buffer (generate-new-buffer "*bsl*"))
  (racket-mode)
  (insert-in-buffer "*bsl*" "#lang htdp/bsl"))
  

;; ------------------ WINDOWS

(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fido-mode t)
 '(package-selected-packages '(cl-libify speed-type gptel elm-mode magit))
 '(racket-imagemagick-props '(:max-height 500)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ------------------ UTILS TO DO THINGS
;; ------------------ from .env:
;; ------------------ load a variable

(defun load-env-variable (variable-name)
  "Load the value of VARIABLE-NAME from the .env file."
  (interactive "sEnter the name of the variable: ")
  (with-temp-buffer
    (insert-file-contents "/home/ayo/.emacs.d/.env")
    (goto-char (point-min))
    (while (re-search-forward (concat "^" (regexp-quote variable-name) "=\\([^[:space:]]+\\)") nil t)
      (setq temp-variable (match-string 1)))
    (message "%s: %s" variable-name temp-variable)))

;; ------------------ open-ai-api

;; -------- using load-env ...

(load-env-variable "OPEN_API_KEY")
(setq gptel-api-key temp-variable)

;; ------------------ PACKAGE MANAGEMENT

;; ------------------ straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ------------------ racket

(use-package racket-mode
  :straight t
  :hook (racket-mode . racket-xp-mode))

;; ------------------ completion

(use-package company
  :straight t
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.2)
  (setq company-tooltip-align-annotations t)
  :hook
  ((racket-mode . company-mode)
   (racket-repl-mode . company-mode)))

;; ------------------ delimiters

(use-package rainbow-delimiters
  :straight t
  :hook
  ((racket-mode . rainbow-delimiters-mode)
   (racket-repl-mode . rainbow-delimiters-mode)))

;; ------------------ structured-editing

(use-package paredit
  :straight t
  :hook
  ((racket-mode . paredit-mode)
   (racket-repl-mode . paredit-mode)))
