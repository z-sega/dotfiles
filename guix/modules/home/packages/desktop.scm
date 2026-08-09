(define-module (home packages desktop)
  #:export (%desktop-packages))


(define %desktop-environment-packages
  (list "eww"
	"rofi"
	"swaybg"
	"swaylock-effects"
	"swayidle"
        "sway-audio-idle-inhibit"
	"swaynotificationcenter"
        "wl-color-picker"
	"xwayland-satellite"))

(define %font-packages
  (list "font-nerd-jetbrains-mono"
	"font-nerd-symbols"
	"font-awesome"
        "font-awesome-nonfree"
	"font-monaspace"
	"font-openmoji"))

(define %gnome-packages
  (list "papers"
	"gnome-tweaks"
	"gnome-shell-extensions"
        "gnome-shell-extension-clipboard-indicator"
	"glibc-locales"))

(define %general-utility-packages
  (list "redshift"
	"librewolf"
	"epiphany"
	"secrets"))

(define %desktop-packages
  (append %desktop-environment-packages
	  %font-packages
	  %gnome-packages
	  %general-utility-packages))
