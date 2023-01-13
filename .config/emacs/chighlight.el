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
  (font-lock-add-keywords nil '(
                                    ("\\_<[0-9]+\\_>" . chl-number-face)
                                    ("\\_<0x[0-9a-fA-F]+\\_>" . chl-number-face)
                                    ("\\_<int\\_>" . font-lock-keyword-face)
                                    ("\\_<float\\_>" . font-lock-keyword-face)
                                    ("\\_<long\\_>" . font-lock-keyword-face)
                                    ("\\_<unsigned\\_>" . font-lock-keyword-face)
                                    ("\\_<double\\_>" . font-lock-keyword-face)
                                    ("\\_<bool\\_>" . font-lock-keyword-face)
                                    ("\\_<boolean\\_>" . font-lock-keyword-face)
                                    )
                          )
  )

(add-hook 'c-mode-hook #'add-custom-highlight)
