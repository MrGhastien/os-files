(require 'svg-lib)
(require 'all-the-icons)

(defvar-local cml-major-mode nil)
(defvar-local cml-major-mode-txt nil)
(defvar-local cml-evil-mode-str nil)
(defvar-local cml-evil-mode-fg nil)
(defvar-local cml-evil-mode-bg nil)
(defvar cml-right-txt "")

(defvar cml-normal-name-color nil)
(defvar cml-modified-name-color "#de4f32")
(defvar cml-read-only-name-color "light goldenrod")

(defvar cml-normal-mode-bg "#ff8e31")
(defvar cml-insert-mode-bg "#98d64e")
(defvar cml-visual-mode-bg "#00ffff")
(defvar cml-replace-mode-bg "#b732de")
(defvar cml-emacs-mode-bg "#7f5ab6")

(defvar cml-normal-mode-fg "#ffffff")
(defvar cml-insert-mode-fg "#000000")
(defvar cml-visual-mode-fg "#000000")
(defvar cml-replace-mode-fg "#000000")
(defvar cml-emacs-mode-fg "#ffffff")

(defvar cml-selwin nil)
(defvar-local cml-mode-icon "")

(defun cml-set-selwin (win)
	(when (not (minibuffer-window-active-p (frame-selected-window)))
	  (setq cml-selwin (selected-window)))
	(force-mode-line-update)
	)

(add-function :before pre-redisplay-function #'cml-set-selwin)

(defun cml-is-selwin-active ()
  "Check if the selected window is active."
  (eq cml-selwin (get-buffer-window))
  )

(add-hook 'window-configuration-change-hook #'cml-is-selwin-active)

(add-function :before after-focus-change-function #'cml-is-selwin-active)

;;(put 'cml-right-txt 'risky-local-variable t)
;;(put 'cml-major-mode 'risky-local-variable t)
;;(put 'cml-major-mode-txt 'risky-local-variable t)
;;(put 'cml-evil-mode 'risky-local-variable t)
;;(put 'cml-buf-name 'risky-local-variable t)
;;(put 'cml-buf-icon 'risky-local-variable t)

(defun cml-eol-format ()
  "Return a string representing the current line break encoding."
  (pcase (coding-system-eol-type buffer-file-coding-system)
    (0 "LF ")
    (1 "CRLF ")
    (2 "CR "))
  )

(defun cml-bg-color (active &optional inactive)
  (if (cml-is-selwin-active)
      (if active active (face-attribute 'mode-line ':background nil 'default))
      (if inactive inactive (face-attribute 'mode-line-inactive ':background nil 'default)))
  )

(defun cml-fg-color (active &optional inactive)
  (if (cml-is-selwin-active)
      (if active active (face-attribute 'mode-line ':foreground nil 'default))
      (if inactive inactive (face-attribute 'mode-line-inactive ':foreground nil 'default)))
  )


(defun cml-char-format ()
  (concat
   (if (memq (coding-system-get buffer-file-coding-system :category) '(coding-category-undecided coding-category-utf-8))
       "UTF-8"
     (upcase (symbol-name (coding-system-get buffer-file-coding-system :name)))
     )
   " ")
  )

(setq cml-right-txt
      '(""
	    (:eval (cml-eol-format))
	    (:eval (cml-char-format))
	    cml-major-mode-txt
        "  "
	    )
      )

(defun cml-get-face-factor (face)
  (let ((h (face-attribute face ':height)) (ph (face-attribute 'default ':height)))
    (+ (/ h (float ph)) 0.08)
    )
  )

(defun cml-padding ()
  (let ((r-length (length (format-mode-line cml-right-txt))))
    (propertize " "
		        'display `(space :align-to (- (+ right right-margin right-fringe) ,(* (- r-length 1.0) (cml-get-face-factor 'mode-line))))
                'face 'mode-line)))

(defun cml-icon-for-buffer ()

  )

(defun cml-update-major (&rest _)
  (let ((icon (all-the-icons-icon-for-buffer)))
    (unless (symbolp icon)
      (setq cml-major-mode
	        (format " %s "
		            (propertize icon
                                'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer))
				                'help-echo (format "Major mode: `%s`" major-mode))))))
  )

(defun cml-update-major-txt (&rest _)
  (setq cml-major-mode-txt
        (propertize
         (format-mode-line mode-name)
         'face '(:weight bold))
        )
  )

  
(add-hook 'buffer-list-update-hook #'cml-update-major)
(add-hook 'buffer-list-update-hook #'cml-update-major-txt)
(add-hook 'after-change-major-mode-hook #'cml-update-major t)
(add-hook 'after-change-major-mode-hook #'cml-update-major-txt t)

(defun cml-get-buf-name ()
  (propertize (buffer-name)
              'face `(:weight bold
                              :foreground
							  ,(cml-fg-color (cond
							                  (buffer-read-only cml-read-only-name-color)
							                  ((buffer-modified-p) cml-modified-name-color)
							                  (t cml-normal-name-color))
                                             )
                              )
			  )
  )

;; ==== ICONS ====

(defun cml-propertize-icon (icon collection face &optional text &rest props)
  "Create an icon from svg ICON using svg-lib.
The resulting icon is actually TEXT with a display property specifying the icon,
with the face FACE.

If TEXT is nil, it is replaced with a single white space (\" \").
PROPS is a plist, used by svg-lib to create the icon."
  (let ((txt (if text text " "))
         (properties
          (map-merge 'plist
           props
           `(:collection ,collection :foreground ,(plist-get face :foreground) :background ,(plist-get face :background))
           )
          )
         )
    (propertize txt
                'display (svg-lib-icon icon properties)
                'face face
                )
    )
  )

(defvar cml-modif-icon nil)
(defvar cml-ro-icon nil)
(defvar cml-modif-icon-inactive nil)
(defvar cml-ro-icon-inactive nil)

(defvar after-theme-load-hook nil
  "Hook run when loading a theme."
  )


(defadvice load-theme (after run-after-theme-load-hook activate)
  "Run the `after-theme-load-hook'."
  (run-hooks 'after-theme-load-hook)
  )

;; We regenerate the icons each time we load a theme (colors might change).
;; This is better than using 'propertize' with ':eval' keys, the latter causing incredible amounts of lag.

(defun cml-on-theme-change ()
  "Rebuilds all cml icons, mainly to update colors."
  (setq cml-modif-icon
        (cml-propertize-icon "content-save" "material"
                             `(:foreground ,cml-modified-name-color :background ,(face-attribute 'mode-line :background nil 'default))
                             " "
                             :stroke 0
                             :padding 0
                             :margin 0
                             :scale 0.9
                             )
        )
  (setq cml-ro-icon
        (cml-propertize-icon "lock" "material"
                             `(:foreground ,cml-read-only-name-color :background ,(face-attribute 'mode-line :background nil 'default))
                             " "
                             :stroke 0
                             :padding 0
                             :margin 0
                             :scale 0.9
                             )
        )

  (setq cml-modif-icon-inactive
        (cml-propertize-icon "content-save" "material"
                             `(:foreground ,(face-attribute 'mode-line-inactive :foreground nil 'default)
                                           :background ,(face-attribute 'mode-line-inactive :background nil 'default))
                             " "
                             :stroke 0
                             :padding 0
                             :margin 0
                             :scale 0.9
                             )
        )
  (setq cml-ro-icon-inactive
        (cml-propertize-icon "lock" "material"
                             `(:foreground ,(face-attribute 'mode-line-inactive :foreground nil 'default)
                                           :background ,(face-attribute 'mode-line-inactive :background nil 'default))
                             " "
                             :stroke 0
                             :padding 0
                             :margin 0
                             :scale 0.9
                             )
        )
  )

(add-hook 'after-theme-load-hook #'cml-on-theme-change)

(defun cml-get-buf-icon ()
  (cond
   (buffer-read-only (if (cml-is-selwin-active) cml-ro-icon cml-ro-icon-inactive))
   ((buffer-modified-p) (if (cml-is-selwin-active) cml-modif-icon cml-modif-icon-inactive))
   (t "")
  )
)

(defun cml-update-evil (mode color fg)
  (setq cml-evil-mode-str mode)
  (setq cml-evil-mode-fg fg)
  (setq cml-evil-mode-bg color)
  )

(defun cml-get-evil-mode ()
  (propertize
   cml-evil-mode-str
   'face
   `(:box
     (:line-width
      (2 . -1)
	  :color ,(cml-bg-color cml-evil-mode-bg)
	  :style "flat-button"
      )
	 :background ,(cml-bg-color cml-evil-mode-bg)
	 :foreground ,(cml-fg-color cml-evil-mode-fg)
	 :weight bold
     )
   )
  )

(defun cml-evil-normal ()
  (cml-update-evil " NORMAL " cml-normal-mode-bg cml-normal-mode-fg)
  )
(defun cml-evil-insert ()
  (cml-update-evil " INSERT " cml-insert-mode-bg cml-insert-mode-fg)
  )
(defun cml-evil-visual ()
  (cml-update-evil " VISUAL " cml-visual-mode-bg cml-visual-mode-fg)
  )
(defun cml-evil-replace ()
  (cml-update-evil " REPLACE " cml-replace-mode-bg cml-replace-mode-fg)
  )
(defun cml-evil-emacs ()
  (cml-update-evil " EMACS " cml-emacs-mode-bg cml-emacs-mode-fg)
  )

(add-hook 'evil-insert-state-entry-hook 'cml-evil-insert)
(add-hook 'evil-normal-state-entry-hook 'cml-evil-normal)
(add-hook 'evil-visual-state-entry-hook 'cml-evil-visual)
(add-hook 'evil-replace-state-entry-hook 'cml-evil-replace)
(add-hook 'evil-emacs-state-entry-hook 'cml-evil-emacs)

(defvar cml-format
  (list
   "%e"
   '(:eval (unless buffer-read-only (cml-get-evil-mode)))
   " "
   'cml-major-mode
   '(:eval (cml-get-buf-icon))
   " "
   '(:eval (cml-get-buf-name))
   " %l:%c %o"
   '(:eval (cml-padding))
   cml-right-txt
   )
  )


(message "Setting mode line format.")
(setq mode-line-format cml-format)
(setq-default mode-line-format cml-format)
(cml-on-theme-change)

(provide 'cml)
