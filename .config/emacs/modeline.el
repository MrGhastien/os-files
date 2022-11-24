(defvar-local custom-mode-line/major-mode nil)
(defvar-local custom-mode-line/major-mode-txt nil)
(defvar-local custom-mode-line/evil-mode-str nil)
(defvar-local custom-mode-line/evil-mode-fg nil)
(defvar-local custom-mode-line/evil-mode-bg nil)
(defvar-local custom-mode-line/buf-name nil)

(defvar custom-mode-line/normal-name-color "#ffffff")
(defvar custom-mode-line/modified-name-color "#de4f32")
(defvar custom-mode-line/read-only-name-color "light goldenrod")

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

(defvar custom-mode-line/selwin nil)

(defun custom-mode-line/set-selwin (win)
	(when (not (minibuffer-window-active-p (frame-selected-window)))
	  (setq custom-mode-line/selwin (selected-window)))
	(force-mode-line-update)
	)

(add-function :before pre-redisplay-function #'custom-mode-line/set-selwin)

(defun custom-mode-line/is-selwin-active ()
	(eq custom-mode-line/selwin (get-buffer-window)))

(add-hook 'window-configuration-change-hook #'custom-mode-line/is-selwin-active)
(add-hook 'focus-in-hook #'custom-mode-line/is-selwin-active)
(add-hook 'focus-out-hook #'custom-mode-line/is-selwin-active)

;;;###autoload
(put 'custom-mode-line/right-txt 'risky-local-variable t)
(put 'custom-mode-line/major-mode 'risky-local-variable t)
(put 'custom-mode-line/major-mode-txt 'risky-local-variable t)
(put 'custom-mode-line/evil-mode 'risky-local-variable t)
(put 'custom-mode-line/buf-name 'risky-local-variable t)

(defun custom-mode-line/eol-format ()
  (pcase (coding-system-eol-type buffer-file-coding-system)
    (0 "LF ")
    (1 "CRLF ")
    (2 "CR "))
  )

(defun custom-mode-line/bg-color (active &optional inactive)
  (if (custom-mode-line/is-selwin-active)
      (if active active (face-attribute 'mode-line ':background nil 'default))
      (if inactive inactive(face-attribute 'mode-line-inactive ':background nil 'default)))
  )

(defun custom-mode-line/fg-color (active &optional inactive)
  (if (custom-mode-line/is-selwin-active)
      (if active active (face-attribute 'mode-line ':foreground nil 'default))
      (if inactive inactive(face-attribute 'mode-line-inactive ':foreground nil 'default)))
  )

(defun custom-mode-line/char-format ()
  (concat
   (if (memq (coding-system-get buffer-file-coding-system :category) '(coding-category-undecided coding-category-utf-8))
       "UTF-8"
     (upcase (symbol-name (coding-system-get buffer-file-coding-system :name)))
     )
   " ")
  )

(setq custom-mode-line/right-txt
       `(""
	,(custom-mode-line/eol-format)
	,(custom-mode-line/char-format)
	custom-mode-line/major-mode-txt
	" "
	)
      )

(defun custom-mode-line/padding ()
  (let ((r-length (length (format-mode-line custom-mode-line/right-txt))))
    (propertize " "
		'display `(space :align-to (- right ,r-length)))))

(defun custom-mode-line/update-major (&rest _)
  (let ((icon (all-the-icons-icon-for-buffer)))
    (unless (symbolp icon)
      (setq custom-mode-line/major-mode
	    (format " %s "
		    (propertize icon
				'display '(raise -0.1)
				'help-echo (format "Major mode: `%s`" major-mode))))))
  )

(defun custom-mode-line/update-major-txt (&rest _)
  (let ((name (if (listp mode-name) (car mode-name) mode-name)))
    (setq custom-mode-line/major-mode-txt
	  (propertize
	   (if (string= name "ELisp")
	       "Emacs-Lisp"
	     mode-name
	     )
	   'face '(:weight bold))
	  )
    )
  )

  
(add-hook 'buffer-list-update-hook #'custom-mode-line/update-major)
(add-hook 'buffer-list-update-hook #'custom-mode-line/update-major-txt)
(add-hook 'after-change-major-mode-hook #'custom-mode-line/update-major t)
(add-hook 'after-change-major-mode-hook #'custom-mode-line/update-major-txt t)

(defun custom-mode-line/get-modified-name (&optional state)
  (let ((name (propertize (buffer-name) 'face `(:weight bold :foreground
							,(custom-mode-line/fg-color (cond
							  (buffer-read-only custom-mode-line/read-only-name-color)
							  ((or (buffer-modified-p) (string= state "modified")) custom-mode-line/modified-name-color)
							  (t custom-mode-line/normal-name-color))))
			  )))
    (format "%s " name)
    )
  )

(defun custom-mode-line/get-modified-icon ()
  (cond
   (buffer-read-only
    (propertize (concat (all-the-icons-material "lock" :v-adjust -0.1) " ")
		'face `(:height 1.1 :foreground ,custom-mode-line/read-only-name-color :box (:line-width 8 :color ,(custom-mode-line/bg-color nil)))))
   ((buffer-modified-p)
    (propertize (concat (all-the-icons-material "save" :v-adjust -0.1) " ")
		'face `(:height 1.1 :foreground ,(custom-mode-line/fg-color custom-mode-line/modified-name-color)
				:box (:line-width 7 :color ,(custom-mode-line/bg-color nil)))))
   (t "")
   )
  )

;;(defun custom-mode-line/set-modified ()
;;  (custom-mode-line/update-modified "modified")
;;  )

;;(add-hook 'first-change-hook #'custom-mode-line/set-modified)
;;(add-hook 'buffer-list-update-hook #'custom-mode-line/update-modified)
;;(add-hook 'after-save-hook #'custom-mode-line/update-modified)
;;(add-hook 'read-only-mode-hook #'custom-mode-line/update-modified)

(defun custom-mode-line/update-evil (mode color fg)
  (setq custom-mode-line/evil-mode-str mode)
  (setq custom-mode-line/evil-mode-fg fg)
  (setq custom-mode-line/evil-mode-bg color)
  )

(defun custom-mode-line/get-evil-mode ()
  (propertize custom-mode-line/evil-mode-str 'face
	      `(:box (:line-width (2 . -1)
				  :color ,(custom-mode-line/bg-color custom-mode-line/evil-mode-bg)
				  :style "flat-button")
		     :background ,(custom-mode-line/bg-color custom-mode-line/evil-mode-bg)
		     :foreground ,(custom-mode-line/fg-color custom-mode-line/evil-mode-fg)
		     :weight bold))
  )

(defun custom-mode-line/evil-normal ()
  (custom-mode-line/update-evil " NORMAL " cml-normal-mode-bg cml-normal-mode-fg)
  )
(defun custom-mode-line/evil-insert ()
  (custom-mode-line/update-evil " INSERT " cml-insert-mode-bg cml-insert-mode-fg)
  )
(defun custom-mode-line/evil-visual ()
  (custom-mode-line/update-evil " VISUAL " cml-visual-mode-bg cml-visual-mode-fg)
  )
(defun custom-mode-line/evil-replace ()
  (custom-mode-line/update-evil " REPLACE " cml-replace-mode-bg cml-replace-mode-fg)
  )
(defun custom-mode-line/evil-emacs ()
  (custom-mode-line/update-evil " EMACS " cml-emacs-mode-bg cml-emacs-mode-fg)
  )

(add-hook 'evil-insert-state-entry-hook 'custom-mode-line/evil-insert)
(add-hook 'evil-normal-state-entry-hook 'custom-mode-line/evil-normal)
(add-hook 'evil-visual-state-entry-hook 'custom-mode-line/evil-visual)
(add-hook 'evil-replace-state-entry-hook 'custom-mode-line/evil-replace)
(add-hook 'evil-emacs-state-entry-hook 'custom-mode-line/evil-emacs)

(defvar cml/format
  (list
   ""
   '(:eval (when (not buffer-read-only) (custom-mode-line/get-evil-mode)))
   " "
   'custom-mode-line/major-mode
   '(:eval (custom-mode-line/get-modified-icon))
   '(:eval (custom-mode-line/get-modified-name))
   " %l:%c %o"
   '(:eval (custom-mode-line/padding))
   'custom-mode-line/right-txt
   )
  )

(message "Setting mode line format.")
(setq mode-line-format cml/format)
(setq-default mode-line-format cml/format)
	      
