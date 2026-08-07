;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (home)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gnome)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services niri)
  #:use-module (guix gexp)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))

(define old-channels
  (list (channel
	  (name 'nonguix)
	  (url "https://gitlab.com/nonguix/nonguix")
	  (branch "master")
	  (commit "7b7b2c47f9c205ad89ddf54293e7756e797f8980")
	  (introduction
	   (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
	     "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
	(channel
	  (name 'guix)
	  (url "https://codeberg.org/guix/guix")
	  (branch "master")
	  (commit "9da2be5a1f5818c3d6b757d1cc4113b8187c9d65")
	  (introduction
	   (make-channel-introduction
	    "9edb3f66fd807b096b48283debdcddccfea34bad"
	    (openpgp-fingerprint
	     "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

(define inferior
  (inferior-for-channels old-channels))

(define pinned-libreoffice
  (first (lookup-inferior-packages inferior "libreoffice")))

(define %desktop-packages
  (list "waybar"
	"rofi"
	"swaybg" "swaylock-effects" "swayidle" "sway-audio-idle-inhibit" "swaynotificationcenter"
	"wl-color-picker"
	"xwayland-satellite"))

(define %python-packages
  (list "python" "python-lsp-server"))

(define %c-packages
  (list "clang-toolchain"))

(define %lisp-packages
  (list "sbcl" "artanis" "guile" "guile-colorized"))

(define %gnome-packages
  (list "papers" "gnome-tweaks" "gnome-shell-extensions"
	"gnome-shell-extension-clipboard-indicator" "glibc-locales"))

(define %font-packages
  (list "font-nerd-jetbrains-mono"
	"font-nerd-symbols"
	"font-awesome"
	"font-awesome-nonfree"
	"font-monaspace"
	"font-openmoji"))

(define %mail-packages
  (list "mu" "isync"))

(define %general-utility-packages
  (list "redshift" "librewolf" "epiphany" "secrets"))

(define %dev-utility-packages
  (list "blueman"
	"libnotify"
	"pulseaudio"
	"brightnessctl"
	"meson"
	"gnupg"
	"pinentry"
	"scrot"
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
	"stow"
	"direnv"))

(define %literature-packages
  (list "dictd" "book-sicp"))

(define %package-management-packages
  (list "flatpak"))

(define %emacs-packages
  (list "emacs-telega"
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

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (append
   (list pinned-libreoffice)
   (specifications->packages
    (append %desktop-packages
	    %c-packages
	    %python-packages
	    %lisp-packages
	    %gnome-packages
	    %font-packages
	    %mail-packages
	    %general-utility-packages
	    %dev-utility-packages
	    %literature-packages
	    %package-management-packages
	    %emacs-packages))))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (append (list
	   (service home-niri-service-type)

	   (service home-gpg-agent-service-type
		    (home-gpg-agent-configuration
		     (pinentry-program
		      (file-append pinentry-emacs "/bin/pinentry-emacs"))
		     (ssh-support? #t)))

	   (service home-redshift-service-type
		    (home-redshift-configuration
		     (location-provider 'manual)
		     (latitude 44.25)
		     (longitude -76.48)))

	   (service home-bash-service-type
                    (home-bash-configuration
                     (aliases '(("grep" . "grep --color=auto")
                                ("ip" . "ip -color=auto")
                                ("ll" . "ls -l")
                                ("ls" . "ls -p --color=auto")))
		     (environment-variables
		      '(("EDITOR" . "emacsclient -c")
			("VISUAL" . "emacsclient -c")
			("ALTERNATE_EDITOR" . "")
			("EMAIL" . "mail@ayoonipe.com")
			("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share")))
                     (bashrc
		      (list
		       (plain-file "direnv-hook"
				   "eval \"$(direnv hook bash)\"")
		       (local-file ".bashrc" "bashrc")))
                     (bash-profile
		      (list
		       (plain-file
			"flatpak-xdg-data-dirs"
			"export XDG_DATA_DIRS=\"$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share\"\n")
		       (local-file ".bash_profile" "bash_profile")))))

	   ;; Assuming configs live in dotfiles too.
	   (simple-service
	    'rofi-config
	    home-xdg-configuration-files-service-type
	    `(("rofi/config.rasi" ,(local-file "../rofi/config.rasi"))))

	   (simple-service
	    'niri-config
	    home-xdg-configuration-files-service-type
	    `(("niri/config.kdl" ,(local-file "../niri/config.kdl"))))

	   (simple-service
	    'emacs-config
	    home-xdg-configuration-files-service-type
	    `(("emacs/.env" ,(local-file "../emacs/.env" "emacs-env"))
	      ("emacs/early-init.el" ,(local-file "../emacs/early-init.el"))
	      ("emacs/init.el" ,(local-file "../emacs/init.el"))
	      ("emacs/config.el" ,(local-file "../emacs/config.el"))
	      ("emacs/config.org" ,(local-file "../emacs/config.org"))
	      ("emacs/linux.org" ,(local-file "../emacs/linux.org"))
	      ("emacs/linux.el" ,(local-file "../emacs/linux.el"))
	      ("emacs/snippets" ,(local-file "../emacs/snippets" #:recursive? #t)))))

          %base-home-services)))
