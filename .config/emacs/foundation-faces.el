(defgroup foundation-faces nil
  "Base faces for special buffers."
  :group 'faces
  )

(defface ff-dired
  '((t (:height 140 :family "Fira Code Retina")))
  "Base face for Dired buffers."
  :group 'foundation-faces
  )

(defface ff-treemacs
  '((t (:inherit ff-dired)))
  "Base face for Treemacs buffers."
  :group 'foundation-faces
  )

(defface mg/org-bug
  '((t (:inherit org-todo)))
  "Face for 'BUG' keywords in Org"
  )

(defface mg/org-crash
  '((t (:inherit org-todo)))
  "Face for 'CRASH' keywords in Org"
  )
