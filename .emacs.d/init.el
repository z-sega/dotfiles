(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(gptel vue-mode elm-mode magit racket-mode)))
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
    (insert-file-contents ".env")
    (goto-char (point-min))
    (while (re-search-forward (concat "^" (regexp-quote variable-name) "=\\([^[:space:]]+\\)") nil t)
      (setq temp-variable (match-string 1)))
    (message "%s: %s" variable-name temp-variable)))

;; ----------------- return a variable
(defun grab-env (variable-name)
  "Grab the value of VARIABLE-NAME from the .env file."
  (insert-file-contents ".env")
  (goto-char (point-min))
  (while (re-search-forward (concat "^" (regexp-quote variable-name) "=\\([^[:space:]]+\\)") nil t)
    match-string 1))

	     
;; ------------------ open-ai-api
;; -------- using load-env ...
;; (load-env-variable "OPEN_API_KEY")
;; (setq gptel-api-key temp-variable)
;; -------- using grab-env ...
(setq gptel-api-key (grab-env "OPEN_API_KEY")
