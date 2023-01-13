(deftheme Test
  "Created 2022-05-07.")

(custom-theme-set-variables
 'Test
 '(evil-normal-state-cursor '(hbar "#fe8019"))
 '(evil-insert-state-cursor '(bar "#b8bb26"))
 '(evil-replace-state-cursor '(hollow "#b732de"))
 '(evil-visual-state-cursor '(box "turquoise"))
 '(evil-emacs-state-cursor '(hbar "#a575ec"))
 '(cml-visual-mode-bg "turquoise")
 '(cml-normal-mode-bg "#fe8019")

 '(ccls-sem-highlight-method 'font-lock)
 '(ccls-sem-type-faces [font-lock-type-face])
 '(ccls-sem-variable-faces [default])
 '(ccls-sem-macro-faces [chl-macro-face])
)

(custom-theme-set-faces
 'Test
 ; General
 ; :background "#22201d"
 '(default ((t (:background "#282828" :foreground "#fbf1c7" :height 105 :family "Iosevka Custom Extended"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(fringe ((t (:background "#20201d"))))
 '(linum ((t (:background "#20201d" :foreground "gray40"))))
 ; :background "#292623"
 '(mode-line ((t (:box (:line-width (-1 . 6) :color "#2f2f2f") :height 120 :foreground "white smoke" :background "#2f2f2f" :family "Fira Code"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 6) :color "#22201d") :height 120 :foreground "gray30" :background "#22201d" :family "Fira Code"))))
 '(highlight ((t (:background "#fb8b24" :foreground "gray10"))))

 ; Dired
 '(dired-marked ((t (:foreground "#f25c54" :weight bold))))
 '(dired-flagged ((t (:background "#f25c54" :foreground "gray10" :weight ultrabold))))
 '(dired-symlink ((t (:foreground "turquoise"))))
 '(dired-broken-symlink ((t (:foreground "turquoise" :strike-through t))))

 ; Font lock
 '(font-lock-builtin-face ((t (:foreground "#8ec07c"))))
 '(font-lock-function-name-face ((t (:foreground "#b8bb26"))))
 '(font-lock-keyword-face ((t (:foreground "#fe8019"))))
 '(font-lock-type-face ((t (:foreground "#fabd2f"))))
 '(font-lock-variable-name-face ((t (:foreground "#83a598"))))
 '(font-lock-string-face ((t (:foreground "#ec7d6e"))))
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold))))
 '(font-lock-comment-face ((t (:foreground "gray50" :width expanded :slant italic :family "Iosevka Custom"))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(chl-number-face ((t (:weight normal :foreground "#d3869b"))))

 ; Latex
 '(font-latex-math-face ((t (:weight normal :foreground "#c1ffc8"))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))

 ; Org mode
 '(outline-1 ((t (:inherit font-lock-keyword-face :weight ultrabold))))
 '(outline-2 ((t (:inherit font-lock-function-name-face :weight ultrabold))))
 '(outline-3 ((t (:inherit font-lock-builtin-face))))
 )

(provide-theme 'Test)
