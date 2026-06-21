;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (gnu services dict)
	     (gnu services databases)
	     (gnu packages databases)
	     (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
  (locale "en_CA.utf8")
  (timezone "America/Toronto")
  (keyboard-layout (keyboard-layout "us"
				    #:options '("ctrl:nocaps"
						"altwin:swap_lalt_lwin")))
  (host-name "sysone")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "ayo")
                  (comment "Ayodeji Onipe")
                  (group "users")
                  (home-directory "/home/ayo")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "lp")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages
   (append (list (specification->package "niri")
		 (specification->package "st")
		 (specification->package "bluez"))
	   %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append 
    (list (service gnome-desktop-service-type)
	  (service postgresql-service-type
	      (postgresql-configuration
		(postgresql postgresql-17)))
	  (service bluetooth-service-type
		   (bluetooth-configuration
		    (auto-enable? #t)))
	  (service dicod-service-type)

          ;; To configure OpenSSH, pass an 'openssh-configuration'
          ;; record as a second argument to 'service' below.
          (service openssh-service-type)
          (set-xorg-configuration
           (xorg-configuration (keyboard-layout keyboard-layout))))

    ;; This is the default list of services we
    ;; are appending to.
    %desktop-services))
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "f7970e02-db34-4022-b1f9-c318a6fd4d26")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "4E09-B0C5"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "30421a22-6339-45a9-8bc4-0149aada1b4d"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
