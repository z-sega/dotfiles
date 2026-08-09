;;; init-messages.el --- MESSAGES -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
;; Already made available thanks to the installation of mu in
;; guix home config.
(require 'mu4e)

;; TODO:
;;
;; - Install pcre2el package for regex translation between emacs-regxp
;; and pcre-regexp

(setq mu4e-sent-folder   "/ayoonipe/Sent"       ;; folder for sent messages
      mu4e-drafts-folder "/ayoonipe/Drafts"     ;; unfinished messages
      mu4e-trash-folder  "/ayoonipe/Trash"      ;; trashed messages
      mu4e-refile-folder "/ayoonipe/Archive")

;;; Retrieving Messages
;;;
(setq
 ;; run messages retrieval only when online
 mu4e-get-messages-command
 (lambda ()
   (if (zerop (shell-command "nm-online -q"))
       "mbsync -a"
     "true"))
 ;; update every 5 mins
 mu4e-update-interval 300)

;;; Sending Messages
;;;
(setq message-send-messages-function 'smtpmessages-send-it
      smtpmessages-smtp-server "smtppro.zoho.com")

;;; Headers
;;;
(add-to-list
 'mu4e-header-info-custom
 '(:recipnum . (:name "Number of recipients"                  ;; long name, seen in message-view
                      :shortname "Recip#"                           ;; short name, seen in headers-view
       	              :help "Number of recipients for this message" ;; tooltip
  		      :function (lambda (msg)
  				  (format "%d"
  					  (+ (length (mu4e-message-field msg :to))
  				             (length (mu4e-message-field msg :cc))))))))

(setq mu4e-headers-fields
      '((:human-date . 12)
        (:flags . 6)
        (:recipnum . 6)
        ;; (:messagesing-list . 10)
        (:from-or-to . 22)
        (:thread-subject)))

;;; Messages
;;;
(setq mu4e-view-scroll-to-next nil          ; don't scroll to next msg
      mu4e-attachment-dir "~/Downloads/")   ; attachments -> ~/Downloads

;;; Composer
;;;
(setq message-dont-reply-to-names #'mu4e-personal-or-alternative-address-p
      message-signature "Ayo Onipe")

;;; General
;;;
(setq read-messages-command 'mu4e)
;; (setq messages-user-agent 'mu4e-user-agent)      ; already to mu4e
(setq mu4e-notification-support t
      mu4e-eldoc-support t)

;;; Getting Help
;;;
(add-to-list 'mu4e-bookmarks
  	     ;; add bookmark for recent messages on the Mu messagesing list.
  	     (list :name  "Mu7Days"
  		   :key   ?m
  		   :query "list:mu-discuss.googlegroups.com AND date:7d..now"))

(use-package telega
  :ensure nil)

(provide 'init-messages)
;;; init-messages.el ends here
