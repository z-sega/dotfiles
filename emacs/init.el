;;; package --- Summary

;;; Commentary:
;; Just my Emacs init.

;;; Code:
;;(package-initialize)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#222327" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 152 :width normal :foundry "nil" :family "TX-02")))))


(org-babel-load-file  "~/.emacs.d/mac.org")
(org-babel-load-file  "~/.emacs.d/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(notmuch-saved-searches
   '((:name "inbox" :query "tag:inbox" :key [105] :sort-order
	    newest-first)
     (:name "unread" :query "tag:unread" :key [117] :sort-order
	    newest-first)
     (:name "flagged" :query "tag:flagged" :key [102] :sort-order
	    newest-first)
     (:name "sent" :query "tag:sent" :key [116] :sort-order
	    newest-first)
     (:name "drafts" :query "tag:draft" :key [100] :sort-order
	    newest-first)
     (:name "all mail" :query "*" :key [97] :sort-order newest-first)))
 '(scroll-bar-mode nil)
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(visible-bell t))
