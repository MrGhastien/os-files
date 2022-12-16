(defvar-local cml-major-mode nil)
(defvar-local cml-major-mode-txt nil)
(defvar-local cml-evil-mode-str nil)
(defvar-local cml-evil-mode-fg nil)
(defvar-local cml-evil-mode-bg nil)
(defvar-local cml-buf-name nil)

(defvar cml-normal-name-color "#ffffff")
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

(defun cml-set-selwin (win)
	(when (not (minibuffer-window-active-p (frame-selected-window)))
	  (setq cml-selwin (selected-window)))
	(force-mode-line-update)
	)

(add-function :before pre-redisplay-function #'cml-set-selwin)

(defun cml-is-selwin-active ()
	(eq cml-selwin (get-buffer-window)))

(add-hook 'window-configuration-change-hook #'cml-is-selwin-active)
(add-hook 'focus-in-hook #'cml-is-selwin-active)
(add-hook 'focus-out-hook #'cml-is-selwin-active)

;;;###autoload
(put 'cml-right-txt 'risky-local-variable t)
(put 'cml-major-mode 'risky-local-variable t)
(put 'cml-major-mode-txt 'risky-local-variable t)
(put 'cml-evil-mode 'risky-local-variable t)
(put 'cml-buf-name 'risky-local-variable t)

(defun cml-eol-format ()
  (pcase (coding-system-eol-type buffer-file-coding-system)
    (0 "LF ")
    (1 "CRLF ")
    (2 "CR "))
  )

(defun cml-bg-color (active &optional inactive)
  (if (cml-is-selwin-active)
      (if active active (face-attribute 'mode-line ':background nil 'default))
      (if inactive inactive(face-attribute 'mode-line-inactive ':background nil 'default)))
  )

(defun cml-fg-color (active &optional inactive)
  (if (cml-is-selwin-active)
      (if active active (face-attribute 'mode-line ':foreground nil 'default))
      (if inactive inactive(face-attribute 'mode-line-inactive ':foreground nil 'default)))
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

(defun cml-padding ()
  (let ((r-length (length (format-mode-line cml-right-txt))))
    (propertize " "
		'display `(space :align-to (- right ,r-length)))))



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
  (let ((name (if (listp mode-name) (car mode-name) mode-name)))
    (setq cml-major-mode-txt
	  (propertize
	   (if (string= name "ELisp")
	       "Emacs-Lisp"
	     mode-name
	     )
	   'face '(:weight bold))
	  )
    )
  )

  
(add-hook 'buffer-list-update-hook #'cml-update-major)
(add-hook 'buffer-list-update-hook #'cml-update-major-txt)
(add-hook 'after-change-major-mode-hook #'cml-update-major t)
(add-hook 'after-change-major-mode-hook #'cml-update-major-txt t)

(defun cml-get-modified-name (&optional state)
  (let ((name (propertize (buffer-name) 'face `(:weight bold :foreground
							,(cml-fg-color (cond
							  (buffer-read-only cml-read-only-name-color)
							  ((or (buffer-modified-p) (string= state "modified")) cml-modified-name-color)
							  (t cml-normal-name-color))))
			  )))
    (format "%s " name)
    )
  )

(defun cml-get-modified-icon ()
  (cond
   (buffer-read-only
    (propertize (concat (all-the-icons-material "lock" :v-adjust -0.1) " ")
		'face `(:height 1.0 :foreground ,cml-read-only-name-color :box (:line-width 8 :color ,(cml-bg-color nil)))))
   ((buffer-modified-p)
    (propertize (concat (all-the-icons-material "save" :v-adjust -0.1) " ")
		'face `(:height 1.0 :foreground ,(cml-fg-color cml-modified-name-color)
				:box (:line-width 7 :color ,(cml-bg-color nil)))))
   (t "")
   )
  )

;;(defun cml-set-modified ()
;;  (cml-update-modified "modified")
;;  )

;;(add-hook 'first-change-hook #'cml-set-modified)
;;(add-hook 'buffer-list-update-hook #'cml-update-modified)
;;(add-hook 'after-save-hook #'cml-update-modified)
;;(add-hook 'read-only-mode-hook #'cml-update-modified)

(defun cml-update-evil (mode color fg)
  (setq cml-evil-mode-str mode)
  (setq cml-evil-mode-fg fg)
  (setq cml-evil-mode-bg color)
  )

(defun cml-get-evil-mode ()
  (propertize cml-evil-mode-str 'face
	      `(:box (:line-width (2 . -1)
				  :color ,(cml-bg-color cml-evil-mode-bg)
				  :style "flat-button")
		     :background ,(cml-bg-color cml-evil-mode-bg)
		     :foreground ,(cml-fg-color cml-evil-mode-fg)
		     :weight bold))
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
   '(:eval (when (not buffer-read-only) (cml-get-evil-mode)))
   " "
   'cml-major-mode
   '(:eval (cml-get-modified-icon))
   '(:eval (cml-get-modified-name))
   " %l:%c %o"
   '(:eval (cml-padding))
   cml-right-txt
   )
  )

(message "Setting mode line format.")
(setq mode-line-format cml-format)
(setq-default mode-line-format cml-format)
	      
