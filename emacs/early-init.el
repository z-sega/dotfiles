;;; early-init.el --- Early Init -*- lexical-binding: t; -*-
;;; package --- Summary

;;; Commentary:
;; Just my Emacs early init.

;;; Code:
(setq user-emacs-directory (file-name-directory load-file-name))

(setenv "LSP_USE_PLISTS" "true")

(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
