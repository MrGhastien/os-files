(deftheme Test
  "Created 2022-05-07.")

(custom-theme-set-variables
 'Test
 '(evil-normal-state-cursor '(hbar "#ef6822"))
 '(evil-insert-state-cursor '(bar "#98d64e"))
 '(evil-replace-state-cursor '(hollow "#b732de"))
 '(evil-visual-state-cursor '(box "turquoise"))
 '(evil-emacs-state-cursor '(hbar "#a575ec"))
 '(cml-visual-mode-bg "turquoise")
 '(cml-normal-mode-bg "#ef6822")

 '(ccls-sem-highlight-method 'font-lock)
 '(ccls-sem-type-faces [font-lock-type-face])
 '(ccls-sem-variable-faces [default])
 '(ccls-sem-macro-faces [chl-macro-face])
)

(custom-theme-set-faces
 'Test
 '(default ((t (:background "#22201d" :foreground "AntiqueWhite2" :weight normal :width expanded :height 110 :family "Iosevka Custom"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(fringe ((t (:background "#20201d"))))
 '(linum ((t (:background "#20201d" :foreground "gray40"))))
 '(mode-line ((t (:box (:line-width (-1 . 6) :color "#292623") :height 120 :foreground "white smoke" :background "#292623" :family "Fira Code"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 6) :color "#22201d") :height 120 :foreground "gray30" :background "#22201d" :family "Fira Code"))))
 '(highlight ((t (:background "#fb8b24" :foreground "gray10"))))
 '(dired-marked ((t (:foreground "#f25c54" :weight bold))))
 '(dired-flagged ((t (:background "#f25c54" :foreground "gray10" :weight ultrabold))))
 '(dired-symlink ((t (:foreground "turquoise"))))
 '(dired-broken-symlink ((t (:foreground "turquoise" :strike-through t))))

 '(font-lock-builtin-face ((t (:foreground "turquoise"))))
 '(font-lock-function-name-face ((t (:foreground "#fb8b24")))) ;ff5d4a;((t (:foreground "lawn green")))
 '(font-lock-keyword-face ((t (:foreground "#f25c54")))) ;((t (:weight bold :foreground "#ff7800")))) ff7800 or ef6822
 '(font-lock-type-face ((t (:foreground "#94d2bd"))))
 '(font-lock-variable-name-face ((t (:foreground "#d8f3dc"))))
 '(font-lock-string-face ((t (:foreground "#ffcdb2"))))
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold))))
 '(font-lock-comment-face ((t (:foreground "gray50" :slant italic :family "Iosevka Custom"))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(chl-number-face ((t (:weight normal :foreground "#e9aaa1"))))

 '(font-latex-math-face ((t (:weight normal :foreground "#c1ffc8"))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))
 ;'(ccls-sem-member-face ((t (:inherit font-lock-variable-face :foreground "#febf53"))))
 )

(provide-theme 'Test)
