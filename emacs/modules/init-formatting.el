;;; init-formatting.el --- Formatting -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package blacken
  :hook (python-mode . blacken-mode))

(use-package apheleia
  :diminish ""
  :defines
  apheleia-formatters
  apheleia-mode-alist
  :functions
  apheleia-global-mode
  :config
  (setf (alist-get 'black apheleia-formatters)
        '("black" "-"))
  (setf (alist-get 'prettier-json apheleia-formatters)
        '("prettier" "--stdin-filepath" filepath))
  (setf (alist-get 'prettier apheleia-formatters)
        '("prettier" "--stdin-filepath" filepath))
  (add-to-list 'apheleia-mode-alist '(typescript-mode . prettier))
  (add-to-list 'apheleia-mode-alist '(web-mode . prettier))
  (add-to-list 'apheleia-mode-alist '(html-mode . prettier))    
  (apheleia-global-mode +1))

(provide 'init-formatting)
;;; init-formatting.el ends here
