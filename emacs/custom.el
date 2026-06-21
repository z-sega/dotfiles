(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#ffffff" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 118 :width normal :foundry "JB" :family "JetBrains Mono"))))
 '(eshell-prompt ((t (:inherit modus-themes-prompt :weight bold))))
 '(gptel-response-highlight ((t (:extend t :background "linen"))))
 '(tooltip ((t (:background "#c9b9b0" :foreground "#000000" :family "Monaspace Neon")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(apheleia-formatters-respect-indent-level nil)
 '(apheleia-global-mode t)
 '(auth-source-save-behavior nil)
 '(browse-url-browser-function 'browse-url-generic)
 '(browse-url-generic-args '("--new-window"))
 '(browse-url-generic-program "epiphany")
 '(company-global-modes nil)
 '(corfu-popupinfo-mode 1 nil nil "Customized with use-package corfu")
 '(css-indent-offset 2)
 '(epg-pinentry-mode 'loopback)
 '(global-hl-line-mode t)
 '(gptel-include-reasoning nil)
 '(js-indent-level 2)
 '(mu4e-use-fancy-chars t)
 '(notmuch-saved-searches
   '((:name "📥 Gmail Inbox" :query "tag:gmail and tag:inbox" :key [103]
	    :sort-order newest-first)
     (:name "📥 Zoho Inbox" :query "tag:zoho and tag:inbox" :key [122]
	    :sort-order newest-first)
     (:name "📤 Gmail Sent" :query "tag:gmail and tag:sent" :key [115]
	    :sort-order newest-first)
     (:name "📤 Zoho Sent" :query "tag:zoho and tag:sent" :key [83]
	    :sort-order newest-first)
     (:name "✉ Gmail All" :query "tag:gmail" :key [71] :sort-order
	    newest-first)
     (:name "✉ Zoho All" :query "tag:zoho" :key [90] :sort-order
	    newest-first)) t)
 '(notmuch-show-logo nil)
 '(org-agenda-files '("~/RoamNotes/20260609085252-important.org"))
 '(package-selected-packages
   '(all-the-icons apheleia async avy biblio bui cape circadian consult
		   corfu-doc corfu-terminal csv-mode dape doom-themes
		   edit-indirect ef-themes elm-mode emacs-guix embark
		   ement geiser-guile gptel ht hydra jinja2-mode kv
		   ligature logview magit magit-popup marginalia
		   memoize minions mmm-mode nhexl-mode no-littering
		   nov ob-racket orderless org-contrib org-fragtog
		   osx-dictionary paredit pinentry pyvenv
		   rainbow-delimiters rustic sly-quicklisp speed-type
		   telega topsy ts vertico vterm yasnippet-snippets))
 '(safe-local-variable-directories
   '("/home/ayo/.config/guix/current/share/guile/site/3.0/"
     "/home/ayo/common-lisp/cfbee.ecomm.store/"
     "/home/ayo/common-lisp/cfbee.ecomm.inventory/"))
 '(safe-local-variable-values
   '((eval put 'mailer-merge-common-variables 'racket-indent-function
	   #'begin)
     (python-shell-process-environment
      "DJANGO_SETTINGS_MODULE=app.settings")
     (python-shell-virtualenv-root . "./venv")
     (python-shell-extra-pythonpaths ".")
     (python-shell-process-environment
      "DJANGO_SETTINGS_MODULE=project.settings")))
 '(scroll-bar-mode nil)
 '(smtpmail-smtp-server "smtppro.zoho.com")
 '(standard-indent 2)
 '(tool-bar-mode t)
 '(user-mail-address "mail@ayoonipe.com")
 '(vc-follow-symlinks nil)
 '(visible-bell t))
