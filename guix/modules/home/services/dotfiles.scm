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
   (simple-service 'rofi-config
                   home-xdg-configuration-files-service-type
                   `(("rofi/config.rasi" ,(dotfile "rofi/config.rasi"))))
   (simple-service 'niri-config
                   home-xdg-configuration-files-service-type
                   `(("niri/config.kdl" ,(dotfile "niri/config.kdl"))))
   (simple-service 'emacs-config
                   home-xdg-configuration-files-service-type
                   `(("emacs/early-init.el" ,(dotfile "emacs/early-init.el"))
                     ("emacs/init.el" ,(dotfile "emacs/init.el"))
                     ("emacs/config.el" ,(dotfile "emacs/config.el"))
                     ("emacs/linux.el" ,(dotfile "emacs/linux.el"))
                     ("emacs/snippets" ,(local-file
                                         (string-append dotfiles-root "/emacs/snippets")
                                         #:recursive? #t))))))
