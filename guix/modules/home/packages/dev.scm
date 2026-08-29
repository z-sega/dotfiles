(define-module (home packages dev)
  #:export (%dev-packages))


(define %python-packages
  (list "python"
	"python-lsp-server"))

(define %c-packages
  (list "clang-toolchain"))

(define %racket-packages
  (list "racket"))

(define %guile-packages
  (list "guile-colorized"
	"artanis"))

(define %commonlisp-packages
  (list "sbcl"))

(define %literature-packages
  (list "dictd"
	"book-sicp"))

(define %package-management-packages
  (list "flatpak"))

(define %emacs-packages
  (list "emacs-pgtk"
        "emacs-rg"
	"emacs-lorem-ipsum"
	"emacs-org-download"
	"emacs-crux"
	"emacs-telega"
	"emacs-latex-extra"
	"emacs-envrc"
	"emacs-pinentry"
	"emacs-nerd-icons"
	"emacs-sly-quicklisp"
	"emacs-diredfl"
	"emacs-geiser"
	"emacs-geiser-guile"
	"emacs-consult"
	"emacs-dirvish"
	"emacs-exec-path-from-shell"
	"emacs-mct"
	"emacs-guix"
	"emacs-compat"
	"emacs-rainbow-delimiters"
	"emacs-biblio"
	"emacs-speed-type"
	"emacs-ef-themes"
	"emacs-modus-themes"
	"emacs-org"
	"emacs-org-roam"
	"emacs-org-roam-ui"
	"emacs-org-remark"
	"emacs-org-pomodoro"
	"emacs-org-sticky-header"
	"emacs-org-texlive-collection"
	"emacs-org-fragtog"
	"emacs-gptel"
	"emacs-dape"
	"emacs-logview"
	"emacs-paredit"
	"emacs-nhexl-mode"
	"emacs-csv-mode"
	"emacs-mmm-mode"
	"emacs-jinja2-mode"
	"emacs-haskell-mode"
	"emacs-racket-mode"
	"emacs-org-contrib"
	"emacs-ob-racket"
	"emacs-yasnippet-snippets"
	"emacs-yasnippet"
	"emacs-pyvenv"
	"emacs-elm-mode"
	"emacs-rustic"
	"emacs-circadian"
	"emacs-doom-themes"
	"emacs-ligature"
	"emacs-apheleia"
	"emacs-magit"
	"emacs-marginalia"
	"emacs-orderless"
	"emacs-vertico"
	"emacs-minions"
	"emacs-transient"
	"emacs-cape"
	"emacs-corfu"
	"emacs-no-littering"
	"emacs-ement"
	"emacs-nov"
	"emacs-corfu-doc"
	"emacs-vterm"
	"emacs-telega"
	"emacs-embark"
	"emacs-corfu-terminal"))

(define %dev-utility-packages
  (list "gnupg"
	"pinentry"
	"curl"
	"rlwrap"
	"ripgrep"
	"tree"
	"xterm"
	"gcc-toolchain"
	"xdot"
	"cmake"
	"nss-certs"
	"git"
	"direnv"))

(define %dev-packages
  (append %literature-packages
	  %python-packages
	  %c-packages
	  %racket-packages
	  %guile-packages
	  %commonlisp-packages
	  %package-management-packages
	  %emacs-packages
	  %dev-utility-packages))
