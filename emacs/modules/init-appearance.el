;;; init-appearance.el --- Appearance -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(use-package modus-themes
  :ensure nil)

(use-package ef-themes
  :ensure nil)

(use-package circadian
  :config
  (setq calendar-latitude 44.255359)
  (setq calendar-longitude -76.481560)
  (setq circadian-themes '((:sunrise . modus-operandi)
  			   (:sunset  . modus-operandi)))
  (circadian-setup))

(use-package ligature
  :config
  ;; Enable the www ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable ligatures in programming modes                                                           
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                       ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                       "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                       "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                       "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                       "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                       "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                       "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                       "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                       "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  (global-ligature-mode 't))

(provide 'init-appearance)
;;; init-appearance.el ends here
