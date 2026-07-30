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
  #:use-module (gnu home services shells)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services niri)
  #:use-module (guix gexp))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (specifications->packages
   (list "xscreensaver"
	 ;; desktop environment programs
	 "waybar"
	 "swaybg"
	 "fuzzel"        ; app launcher
	 "gtklock"
	 "swaynotificationcenter"
	 "xwayland-satellite"
	 ;; lisp
	 "sbcl"
	 "artanis"
	 "guile"
	 "guile-colorized"
	 ;; bluetooth
	 "blueman"
	 ;; other package management tools
	 "flatpak"
	 ;; web browsing
         "librewolf"
	 "epiphany"
	 ;; general utilities
	 "wl-color-picker"
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
	 ;; gnome
	 "papers"
         "gnome-tweaks"
	 "gnome-shell-extensions"
	 "gnome-shell-extension-clipboard-indicator"	 
         "glibc-locales"
	 ;; fonts
	 "font-nerd-jetbrains-mono"
	 "font-nerd-symbols"
	 ;; literature
	 "dictd"
	 "book-sicp"
	 ;; programming utilities
	 ;; -- python
	 "python-lsp-server"
	 ;; -- c
	 "clang-toolchain"
	 ;; -- general
	 "direnv"
	 ;; mail
	 "mu"
	 "isync"
	 ;; emacs packages
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
         "emacs-all-the-icons"
         "emacs-telega"
         "emacs-embark"
         "emacs-corfu-terminal")))

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

	   ;; Assumes emacs configs live in dotfiles too.
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
