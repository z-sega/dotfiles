(define-module (home services desktop)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services niri)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services desktop)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages linux)
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
             (longitude -76.48)))
   (service home-dbus-service-type)
   (service home-pipewire-service-type
            (home-pipewire-configuration
              (pipewire pipewire)
              (wireplumber wireplumber)))
   (simple-service 'xdg-portal-config
		   home-environment-variables-service-type
		   '(("XDG_CURRENT_DESKTOP" . "niri")
		     ("XDG_SESSION_DESKTOP" . "niri")
		     ("XDG_SESSION_TYPE" . "wayland")
                     ("ELECTRON_OZONE_PLATFORM_HINT" . "wayland")
		     ("MOZ_ENABLE_WAYLAND" . "1")
                     ("NIXOS_OZONE_WL" . "1")
		     ("GDK_BACKEND" . "wayland")
                     ("CLUTTER_BACKEND" . "wayland")))
   (simple-service 'xdg-portal-config-file
                home-xdg-configuration-files-service-type
                `(("xdg-desktop-portal/portals.conf"
                   ,(plain-file "portals.conf"
                                "[preferred]\ndefault=gtk\norg.freedesktop.impl.portal.ScreenCast=gnome\norg.freedesktop.impl.portal.Screenshot=gnome\n"))))))
