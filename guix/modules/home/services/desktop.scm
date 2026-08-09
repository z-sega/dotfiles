(define-module (home services desktop)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services niri)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services desktop)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages emacs)
  #:use-module (guix gexp)
  #:export (%desktop-services))

(define %desktop-services
  (list
   (service home-niri-service-type)
   (service home-gpg-agent-service-type
            (home-gpg-agent-configuration
             (pinentry-program (file-append pinentry-emacs "/bin/pinentry-emacs"))
             (ssh-support? #t)))
   (service home-redshift-service-type
            (home-redshift-configuration
             (location-provider 'manual)
             (latitude 44.25)
             (longitude -76.48)))))
