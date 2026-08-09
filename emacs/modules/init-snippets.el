;;; init-snippets.el --- Snippets -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package yasnippet
  :ensure nil
  :config
  (setq yas-snippet-dirs
        (list (expand-file-name "snippets/" user-emacs-directory)))
  (yas-global-mode 1))

(provide 'init-snippets)
;;; init-snippets.el ends here
