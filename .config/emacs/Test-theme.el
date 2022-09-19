(deftheme Test
  "Created 2022-05-07.")

(custom-theme-set-variables
 'Test
 '(cursor-type 'hbar))

(custom-theme-set-faces
 'Test
 '(cursor ((t (:background "green"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(default ((t (:background "#1b1918":foreground "gray70" :weight semi-bold :height 125 :family "Source Code Pro"))))

 ;; Mode line
 '(mode-line ((t (:box (:line-width (-1 . 8) :color "#2c2726") :foreground "white smoke" :background "#2c2726"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 8) :color "#0e0b0b") :foreground "gray30" :background "#0e0b0b"))))

 ;; Font lock faces
 '(font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
 '(font-lock-function-name-face ((t (:foreground "tomato"))))
 '(font-lock-keyword-face ((t (:foreground "tan2"))))
 '(font-lock-type-face ((t (:foreground "medium slate blue"))))
 '(font-lock-variable-name-face ((((class grayscale) (background light)) (:slant italic :weight bold :foreground "Gray90")) (((class grayscale) (background dark)) (:slant italic :weight bold :foreground "DimGray")) (((class color) (min-colors 88) (background light)) (:foreground "sienna")) (((class color) (min-colors 88) (background dark)) (:foreground "LightGoldenrod")) (((class color) (min-colors 16) (background light)) (:foreground "DarkGoldenrod")) (((class color) (min-colors 16) (background dark)) (:foreground "LightGoldenrod")) (((class color) (min-colors 8)) (:weight light :foreground "yellow")) (t (:slant italic :weight bold))))
 '(font-lock-string-face ((t (:foreground "dark salmon"))))
 '(font-lock-constant-face ((t (:weight bold :inherit font-lock-variable-name-face))))
 '(font-lock-comment-face ((t (:foreground "gray50"))))
)

(provide-theme 'Test)
