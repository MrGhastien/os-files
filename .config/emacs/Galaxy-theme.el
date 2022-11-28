(deftheme Galaxy
  "Created 2022-05-07.")

(custom-theme-set-variables
 'Galaxy
 '(evil-normal-state-cursor '(hbar "#ff8e31"))
 '(evil-insert-state-cursor '(bar "#22ff22"))
 '(evil-replace-state-cursor '(hollow "#b732de"))
 '(evil-visual-state-cursor '(box "#00ffff"))
 '(evil-emacs-state-cursor '(hbar "#a575ec"))
)

(custom-theme-set-faces
 'Galaxy
 '(cursor ((t (:background "green"))))
 '(error ((t (:underline (:color "red" :style wave)))))
 '(mode-line ((t (:box (:line-width (-1 . 8) :color "#24242f") :height 120 :foreground "white smoke" :background "#24242f" :family "Fira Code"))))
 '(mode-line-inactive ((t (:box (:line-width (-1 . 8) :color "#0b0c0e") :height 120 :foreground "gray30" :background "#0b0c0e" :family "Fira Code"))))
 '(font-lock-builtin-face ((t (:weight extra-bold :foreground "SeaGreen2"))))
 '(font-lock-function-name-face ((t (:foreground "SpringGreen2")))) ;((t (:foreground "lawn green")))
 '(font-lock-keyword-face ((t (:weight extra-bold :foreground "RoyalBlue3")))) ;((t (:weight bold :foreground "#ff7800")))) ff7800 or ef6822
 '(font-lock-type-face ((t (:foreground "#c9a4f7"))))
 '(font-lock-variable-name-face ((t (:foreground "lavender"))))
 '(font-lock-string-face ((t (:foreground "DarkSlateGray2"))))
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight extra-bold))))
 '(font-lock-comment-face ((t (:foreground "gray50" :slant italic :family "Courier Prime Code"))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(font-latex-math-face ((t (:inherit font-lock-string-face :weight normal))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))
 '(default ((t (:background "#101016" :foreground "#c2c0c4" :weight normal :width normal :height 120 :family "Fira Code")))))

(provide-theme 'Galaxy)
