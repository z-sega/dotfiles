(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fido-mode t)
 '(package-selected-packages
   '(lorem-ipsum gptel magit elm-mode racket-mode highlight-indent-guides vue-mode lsp-mode markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ------------------ LOOK & FEEL

(menu-bar-mode -1)

;; ------------------ BUFFERS

(global-set-key [remap list-buffers] 'ibuffer)

;; ------------------ WINDOWS

(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings)

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

;; ----------------- return a variable

(defun grab-env (variable-name)
  "Grab the value of VARIABLE-NAME from the .env file."
  (insert-file-contents "/home/ayo/.emacs.d/.env")
  (goto-char (point-min))
  (while (re-search-forward (concat "^" (regexp-quote variable-name) "=\\([^[:space:]]+\\)") nil t)
    (match-string 1)))


;; ------------------ open-ai-api
;; -------- using load-env ...

(load-env-variable "OPEN_API_KEY")
(setq gptel-api-key temp-variable)

;; -------- using grab-env ...

;; (setq gptel-api-key (grab-env "OPEN_API_KEY"))
