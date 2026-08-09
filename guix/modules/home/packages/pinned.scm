(define-module (home packages pinned)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1)
  #:export (%pinned-packages))


(define* (pin-package name #:key channels)
  "Return package NAME as looked up from an inferior built from CHANNELS."
  (first (lookup-inferior-packages (inferior-for-channels channels) name)))

(define %libreoffice-channels
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

(define pinned-libreoffice
  (pin-package "libreoffice" #:channels %libreoffice-channels))

(define %pinned-packages
  (list pinned-libreoffice))
