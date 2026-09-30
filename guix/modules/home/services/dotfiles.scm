(define-module (home services dotfiles)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:export (dotfiles-services))


(define (dotfiles-services dotfiles-root)
  "Return the simple-services that symlink dotfiles from DOTFILES-ROOT."
  (define (dotfile path)
    (local-file (string-append dotfiles-root "/" path)))
  
  (list
   (simple-service 'redshift-config
		   home-xdg-configuration-files-service-type
		   `(("redshift/redshift.conf" ,(dotfile "redshift/redshift.conf"))))
   (simple-service 'rofi-config
                   home-xdg-configuration-files-service-type
                   `(("rofi/config.rasi" ,(dotfile "rofi/config.rasi"))))
   (simple-service 'niri-config
                   home-xdg-configuration-files-service-type
                   `(("niri/config.kdl" ,(dotfile "niri/config.kdl"))))
   (simple-service 'waybar-config
                   home-xdg-configuration-files-service-type
                   `(("waybar/config.jsonc" ,(dotfile "waybar/config.jsonc"))
		     ("waybar/cava.sh" ,(local-file
					 (string-append dotfiles-root "/waybar/cava.sh")
					 #:recursive? #t))
		     ("waybar/style.css" ,(dotfile "waybar/style.css"))))
   (simple-service 'wlogout-config
                   home-xdg-configuration-files-service-type
                   `(("wlogout/layout" ,(dotfile "wlogout/layout"))
		     ("wlogout/icons" ,(local-file
					 (string-append dotfiles-root "/wlogout/icons")
					 #:recursive? #t))
		     ("wlogout/style.css" ,(dotfile "wlogout/style.css"))))
   (simple-service 'emacs-config
                   home-xdg-configuration-files-service-type
                   `(("emacs/early-init.el" ,(dotfile "emacs/early-init.el"))
                     ("emacs/init.el" ,(dotfile "emacs/init.el"))
		     ("emacs/modules" ,(local-file
					(string-append dotfiles-root "/emacs/modules")
					#:recursive? #t))
                     ("emacs/snippets" ,(local-file
                                         (string-append dotfiles-root "/emacs/snippets")
                                         #:recursive? #t))))
   (simple-service 'guix-channels-config
		   home-xdg-configuration-files-service-type
		   `(("guix/channels.scm" ,(dotfile "guix/channels.scm"))))))
