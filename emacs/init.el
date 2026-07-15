;;; package --- Summary

;;; Commentary:
;; Just my Emacs init.

;;; Code:
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need or want to do this.
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Force litter to XDG config directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backup/" user-emacs-directory))))

(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t)))

(make-directory (expand-file-name "auto-save/" user-emacs-directory) t)

(require 'use-package)

(use-package no-littering)

;; Use latest org-mode. Do this early, to use when loading config
(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode))

;; Load main emacs config.org
(org-babel-load-file
 (expand-file-name "linux.org" user-emacs-directory))
(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))

;; Load saved customizations
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
;; Warn about unsaved customizations when emacs is killed
(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)
