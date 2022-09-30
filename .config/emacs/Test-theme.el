(deftheme Test
  "Created 2022-05-07.")

(custom-theme-set-variables
 'Test
 '(cursor-type 'hbar))

(custom-theme-set-faces
 'Test
 '(cursor ((t (:background "green"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(mode-line ((t (:box (:line-width (-1 . 8) :color "#2c2726") :foreground "white smoke" :background "#2c2726"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 8) :color "#0e0b0b") :foreground "gray30" :background "#0e0b0b"))))
 '(font-lock-builtin-face ((t (:foreground "turquoise"))))
 '(font-lock-function-name-face ((t (:foreground "#ff5d4a"))))
 '(font-lock-keyword-face ((t (:foreground "#ff7800"))))
 '(font-lock-type-face ((t (:foreground "#ee9f53"))))
 '(font-lock-variable-name-face ((t (:foreground "bisque"))))
 '(font-lock-string-face ((t (:foreground "PaleGreen1"))))
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight bold))))
 '(font-lock-comment-face ((t (:foreground "gray50" :slant italic))))
 '(font-latex-math-face ((t (:inherit font-lock-string-face :weight normal))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))
 '(default ((t (:background "#1b1918" :foreground "gray70" :weight semi-bold :height 130 :family "Source Code Pro")))))

(provide-theme 'Test)
