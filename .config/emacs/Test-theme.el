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
)

(custom-theme-set-faces
 'Test
 '(cursor ((t (:background "green"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(mode-line ((t (:box (:line-width (-1 . 8) :color "#2c2726") :height 120 :foreground "white smoke" :background "#2c2726" :family "Fira Code"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 8) :color "#0e0b0b") :height 120 :foreground "gray30" :background "#0e0b0b" :family "Fira Code"))))
 '(font-lock-builtin-face ((t (:weight semi-bold :foreground "turquoise"))))
 '(font-lock-function-name-face ((t (:foreground "#ff5d4a")))) ;((t (:foreground "lawn green")))
 '(font-lock-keyword-face ((t (:weight semi-bold :foreground "#ef6822")))) ;((t (:weight bold :foreground "#ff7800")))) ff7800 or ef6822
 '(font-lock-type-face ((t (:foreground "#febf53"))))
 '(font-lock-variable-name-face ((t (:foreground "#ffc7a6"))))
 '(font-lock-string-face ((t (:foreground "PaleGreen1"))))
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold))))
 '(font-lock-comment-face ((t (:foreground "gray50" :slant italic :family "Courier Prime Code"))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(font-latex-math-face ((t (:inherit font-lock-string-face :weight normal))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))
 '(default ((t (:background "#1b1918" :foreground "AntiqueWhite3" :weight normal :width normal :height 120 :family "Fira Code")))))

(provide-theme 'Test)
