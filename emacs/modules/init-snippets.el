;;; init-snippets.el --- Snippets -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package yasnippet
  :ensure nil
  :config
  (setq yas-snippet-dirs
        (list (expand-file-name "snippets/" user-emacs-directory)
	      (expand-file-name "yasnippet-snippets/snippets" user-emacs-directory)))
  (yas-global-mode 1))

(add-to-list 'load-path (concat user-emacs-directory "yasnippet-snippets"))
(require 'yasnippet-snippets)

(provide 'init-snippets)
;;; init-snippets.el ends here
