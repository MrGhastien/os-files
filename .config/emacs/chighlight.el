(defgroup chl-faces nil
  "Faces for custom c syntax highlighting."
  :group 'faces
  )

(defface chl-number-face
  '((t :foreground "#ff0000"))
  "The face used to highlight numbers."
  :group 'chl-faces
  )

(defface chl-macro-face
  '((t (:inherit font-lock-builtin-face :foreground "#eac4d5")))
  "The face used to highlight macros."
  :group 'chl-faces
  )

(defvar chl-number-face 'chl-number-face)
(defvar chl-macro-face 'chl-macro-face)

(defun add-custom-highlight ()
  (font-lock-add-keywords
   nil
   '(
     ("\\_<[0-9]+\\(\\.[0-9]+f?\\)?\\_>"         . chl-number-face)
     ("\\_<0x[0-9a-fA-F]+\\_>" . chl-number-face)
     ("\\<char\\>"           . font-lock-keyword-face)
     ("\\<void\\>"           . font-lock-keyword-face)
     ("\\<int\\>"            . font-lock-keyword-face)
     ("\\<float\\>"          . font-lock-keyword-face)
     ("\\<long\\>"           . font-lock-keyword-face)
     ("\\<unsigned\\>"       . font-lock-keyword-face)
     ("\\<double\\>"         . font-lock-keyword-face)
     ("\\<delete\\(\\[\\]\\)"    1 font-lock-keyword-face prepend)
     )
   )
  )

(defun hack-c-not-decl-init-keywords ()
  (add-custom-highlight)
  (setq c-not-decl-init-keywords
        (concat "\\(\\(static\\|const\\)?\\<\\(char\\|void\\|int\\|short\\|float\\|double\\|long\\|signed\\|unsigned\\|bool\\)\\>\\)\\|"
                c-not-decl-init-keywords)
        )
  )

;(add-hook 'c-mode-hook #'add-custom-highlight)
;(add-hook 'c++-mode-hook #'hack-c-not-decl-init-keywords)
