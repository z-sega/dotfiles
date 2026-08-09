(define-module (home services shell)
  #:use-module (gnu services)
  #:use-module (gnu home services shells)
  #:use-module (guix gexp)
  #:export (shell-services))


(define (shell-services dotfiles-root)
  "Return the shell-related services, resolving dotfiles from DOTFILES-ROOT."
  (define* (dotfile path #:optional name)
    (local-file (string-append dotfiles-root "/" path)
		(or name (string-trim-left (basename path) #\.))))
  
  (list
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
               (plain-file "direnv-hook" "eval \"$(direnv hook bash)\"")
               (dotfile ".bashrc" "bashrc")))
             (bash-profile
              (list
               (plain-file "flatpak-xdg-data-dirs"
                           "export XDG_DATA_DIRS=\"$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share\"\n")
               (dotfile ".bash_profile" "bash_profile")))))))
