;;; init-completion.el --- Completion -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package corfu
  :demand t                      ; need this when using :bind or :hook
  :config
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.75)
  ;; show documentation tooltips after some delay
  (corfu-popupinfo-mode 1)
  (corfu-popupinfo-delay '(0.5 . 0.1))
  ;; quit when the popup appears and I type anything else
  (corfu-quit-no-match t) 
  ;; Might want to customize corfu-sort-function
  :bind
  (("M-RET" . completion-at-point)))

;; corfu extension (in corfu/extensions/corfu-history.el); load after corfu
(use-package corfu-history
  :after corfu
  :config
  (corfu-history-mode)
  (savehist-mode 1)
  (add-to-list 'savehist-additional-variables 'corfu-history))

(use-package corfu-terminal
  :after corfu
  :init
  (defvar corfu-terminal-mode))

;; Additional capf completion sources
(use-package cape
  :config
  ;; Note: order matters here. First one returning a result wins. Use
  ;; ~add-hook~ to add these, since it sets the global (default) value
  ;; of capf, instead of ~setq~ which would make it buffer-local
  ;; (which would be bad): capf is automatically buffer-local when
  ;; set.
  ;; The buffer-local value, which takes precedence over these, calls these as long
  ;; as it ends with ~t~.
  (add-hook 'completion-at-point-functions #'cape-history)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (message (format "Loading my capf extensions: %s" completion-at-point-functions)))

(provide 'init-completion)
;;; init-completion.el ends here
