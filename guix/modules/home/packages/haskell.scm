(define-module (home packages haskell)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages base)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (haskell-language-server-bin))


(define-public haskell-language-server-bin
  (package
   (name "haskell-language-server-bin")
   (version "2.14.0.0")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
           "https://downloads.haskell.org/~hls/haskell-language-server-"
           version
           "/haskell-language-server-" version "-x86_64-linux-unknown.tar.xz"))
     (sha256 (base32 "0dklz2qwpnzy9ajlm2a27y728q3lib4r1sl2iy1wayfr9xrfzn95"))))
   (build-system copy-build-system)
   (arguments
    (list
     #:install-plan ''(("." "bin" #:include-regexp ("haskell-language-server.*")))
     #:phases
     #~(modify-phases %standard-phases
		      (add-after 'install 'patch-binaries
				 (lambda* (#:key outputs #:allow-other-keys)
				   (let* ((out (assoc-ref outputs "out"))
					  (bin (string-append out "/bin"))
					  (interp #$(file-append (this-package-input "glibc")
								 "/lib/ld-linux-x86-64.so.2"))
					  (rpath (string-join
						  (map (lambda (p) (string-append p "/lib"))
						       (list #$(this-package-input "glibc")
							     #$(this-package-input "gmp")
							     #$(this-package-input "ncurses")
							     #$(this-package-input "libffi")
							     #$(this-package-input "zlib")))
						  ":")))
				     (for-each
				      (lambda (file)
					(invoke "patchelf" "--set-interpreter" interp file)
					(invoke "patchelf" "--set-rpath" rpath file))
				      (find-files bin "^haskell-language-server")))))))) 
   (native-inputs (list patchelf))
   (inputs (list glibc gmp ncurses libffi zlib))
   (synopsis "Prebuilt Haskell Language Server (multi-GHC binary bundle)")
   (description "Wraps upstream's official HLS binary release, including
haskell-language-server-wrapper, which auto-selects the binary matching the
GHC version on PATH.")
   (home-page "https://haskell-language-server.readthedocs.io/")
   (license license:asl2.0)))
