;;; init-ai.el --- AI -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package gptel
  :config
  ;; prompt view
  (setq gptel-default-mode 'org-mode)
  (setf (alist-get 'org-mode gptel-prompt-prefix-alist) "@user\n\n")
  (setf (alist-get 'org-mode gptel-response-prefix-alist) "@assistant\n\n")
  ;; default model
  (setq gptel-model 'Deepseek:deepseek-chat
        gptel-backend (gptel-make-deepseek "Deepseek"
  					   :key (lambda () (auth-source-pick-first-password :host "api.deepseek.com"))
  					   :stream t))
  ;; available
  (gptel-make-anthropic
   "Claude"
   :key (lambda () (auth-source-pick-first-password :host "api.anthropic.com"))
   :stream t))

(provide 'init-ai)
;;; init-ai.el ends here
