;;; init-misc.el --- Misc -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package lorem-ipsum
  :config
  (lorem-ipsum-use-default-bindings))

(use-package speed-type)

(use-package biblio)

(use-package nix-mode)

(use-package org-gcal
  :config
  (setq org-gcal-client-id "973395471464-e734oh5ueimj9v60okns0fufelo97i1h.apps.googleusercontent.com")
  (setq org-gcal-client-secret (auth-source-pick-first-password :host org-gcal-client-id))
  (setq org-gcal-fetch-file-alist '(("ayosemail@gmail.com" .  "~/schedule.org")))
  (org-gcal-reload-client-id-secret)
  (setq plstore-cache-passphrase-for-symmetric-encryption t))

;; Ensure =brew install gnu-sed=
;; (setq Man-sed-command "sed")

(provide 'init-misc)
;;; init-misc.el ends here
