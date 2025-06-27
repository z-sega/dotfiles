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
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 150 :width normal :foundry "nil" :family "TX-02"))))
 '(eshell-prompt ((t (:inherit modus-themes-prompt :weight bold)))))

;; Standard Elpaca Bootstrap
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

(setq use-package-always-ensure t)
;; -------- Elpaca done

;; Use latest org-mode. Do this early, to use when loading config
(use-package org
  :ensure (:wait t)
  :mode ("\\.org\\'" . org-mode))

;; Load main emacs config.org
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
 '(safe-local-variable-values
   '((python-shell-process-environment
      "DJANGO_SETTINGS_MODULE=app.settings")
     (python-shell-virtualenv-root . "./venv")
     (python-shell-extra-pythonpaths ".")
     (python-shell-process-environment
      "DJANGO_SETTINGS_MODULE=project.settings")))
 '(scroll-bar-mode nil)
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(visible-bell t))
