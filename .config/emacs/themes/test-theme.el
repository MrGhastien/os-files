(deftheme test
  "Created 2022-05-07.")

(custom-theme-set-variables
 'test
 '(evil-normal-state-cursor '(hbar "#fe8019"))
 '(evil-insert-state-cursor '(bar "#b8bb26"))
 '(evil-replace-state-cursor '(hollow "#b732de"))
 '(evil-visual-state-cursor '(box "turquoise"))
 '(evil-emacs-state-cursor '(hbar "#a575ec"))
 '(cml-visual-mode-bg "turquoise")
 '(cml-visual-mode-fg "#003b50")
 '(cml-normal-mode-bg "#fe8300")
 '(cml-normal-mode-fg "#801100")
 '(cml-insert-mode-bg "#aff212")
 '(cml-insert-mode-fg "#005200")
 '(cml-replace-mode-fg "#29005e")

 '(ccls-sem-highlight-method 'overlay)
 '(ccls-sem-type-faces [font-lock-type-face])
 '(ccls-sem-variable-faces [default])
 '(ccls-sem-macro-faces [chl-macro-face])
)

(custom-theme-set-faces
 'test
 ; General ; :background "#1d2021"
 '(default ((t (:background "#282828" :foreground "#fbf1c0" :weight regular :width expanded :height 110 :family "Iosevka Custom"))))
 '(variable-pitch ((t (:inherit default :family "Inter" :width normal :weight regular :slant normal :height 140))))
 '(fixed-pitch ((t (:inherit default :family "Iosevka Custom Extended"))))
 '(error ((t (:foreground "red" :weight ultrabold :underline nil))))
 '(link ((t (:foreground "aquamarine" :underline t))))
 '(fringe ((t (:background "#3c3836"))))
 '(line-number ((t (:background "#3c3836" :foreground "#7c6f64"))))
 '(line-number-current-line ((t (:background "#504945" :foreground "#fe8019"))))
 '(line-number-major-tick ((t (:inherit (line-number) :foreground "#bdae93" :weight bold))))
 '(line-number-minor-tick ((t (:inherit (line-number) :foreground "#928374" :weight bold))))
 '(mode-line ((t (:box (:line-width (-1 . 6) :color "#303030") :foreground "#fbf1c7" :background "#303030" :family "Fira Code"))))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "#928374"))))
 ;'(mode-line-inactive ((t (:inherit mode-line :box ( :line-width (-1 . 6) :color "#282828") :foreground "gray30" :background "#282828"))))
 '(highlight ((t (:background "#83a598" :foreground "gray10"))))
 '(hl-line ((t (:background "#323335" :inherit nil))))
 '(minibuffer-prompt ((t (:foreground "#b8bb26" :weight bold))))
 '(region ((t (:background "#4a4742" :extend t))))

 ; Dired
 '(ff-dired ((t (:inherit default :family "Iosevka Custom" :weight regular))))
 '(dired-directory ((t (:inherit ff-dired))))
 '(dired-marked ((t (:foreground "#f25c54" :weight bold :inherit ff-dired))))
 '(dired-flagged ((t (:background "#f25c54" :foreground "gray10" :weight ultrabold :inherit ff-dired))))
 '(dired-symlink ((t (:foreground "turquoise" :inherit ff-dired))))
 '(dired-broken-symlink ((t (:foreground "turquoise" :strike-through t :inherit ff-dired))))

 ; Treemacs
 '(ff-treemacs ((t (:family "Iosevka Custom" :weight medium))))
 '(treemacs-directory-face ((t (:inherit ff-treemacs))))
 '(treemacs-file-face ((t (:inherit ff-treemacs))))
 '(treemacs-git-ignored-face ((t (:inherit (treemacs-file-face font-lock-comment-face)))))
 '(treemacs-git-modified-face ((t (:inherit treemacs-file-face :foreground "#83a598"))))
 '(treemacs-git-renamed-face ((t (:inherit treemacs-file-face :foreground "#d65d0e"))))
 '(treemacs-git-untracked-face ((t (:inherit treemacs-file-face :foreground "#fb4934"))))
 '(treemacs-git-added-face ((t (:inherit treemacs-file-face :foreground "#8ec07c"))))
 '(treemacs-root-face ((t (:height 1.2 :weight bold :inherit (treemacs-directory-face font-lock-constant-face)))))
 '(treemacs-all-the-icons-file-face ((t (:height 130 :foreground "#928374"))))
 '(treemacs-all-the-icons-root-face ((t (:height 130 :foreground "#fe8019"))))

 ; Font lock
 '(font-lock-builtin-face ((t (:foreground "#fe8019"))))
 '(font-lock-function-name-face ((t (:foreground "#b8bb26"))))
 '(font-lock-keyword-face ((t (:foreground "#fe8019"))))
 '(font-lock-type-face ((t (:foreground "#fabd2f"))))
 '(font-lock-variable-name-face ((t (:foreground "#83a598"))))
 '(font-lock-string-face ((t (:foreground "#8ec07c")))) ;8ec07c
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold :foreground "#d3869b"))))
 '(font-lock-comment-face ((t (:foreground "gray50" :width expanded :slant italic))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(ccls-sem-member-face ((t (:slant normal :foreground "#83a598"))))
 '(ccls-sem-static-face ((t (:weight bold))))
 '(chl-number-face ((t (:weight normal :foreground "#d3869b"))))

 '(lsp-ui-doc-background ((t (:background "#32302f"))))
 '(lsp-ui-doc-header ((t (:background "#fb4934" :foreground "#282828"))))

 ; Latex
 '(font-latex-math-face ((t (:weight normal :foreground "#c1ffc8"))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))

 ; Org mode
 '(org-level-1 ((t (:foreground "#fb4934" :weight extrabold))))
 '(org-level-2 ((t (:foreground "#fe8019" :weight bold))))
 '(org-level-3 ((t (:foreground "#b8bb26" :weight normal))))
 '(org-hide ((t (:foreground "#282828"))))
 '(org-block ((t (:inherit fixed-pitch :foreground nil :background "#1d2021" :extend t)))) ;171919
 '(org-code ((t (:inherit (fixed-pitch) :background "#1d2021"))))
 '(org-verbatim ((t (:inherit (fixed-pitch)))))
 '(org-checkbox ((t (:inherit fixed-pitch :foreground "#689d6a" :weight bold))))
 '(org-table ((t (:inherit (fixed-pitch)))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch) :background "#1d2021" :extend t))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-special-keyword ((t (:inherit fixed-pitch :foreground "#689d6a" :slant italic :weight bold :height 0.75))))
 '(org-todo ((t (:weight extrabold :foreground "#fabd2f"))))
 '(org-done ((t (:weight extrabold :foreground "#6eeb42"))))
 '(org-headline-done ((t (:foreground "#a89984"))))
 '(org-date ((t (:inherit (link org-special-keyword) :underline nil :foreground nil :height unspecified))))
 '(org-agenda-date ((t (:foreground "#fbf1c0" :family "Cantarell"))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :underline t))))
 '(org-agenda-structure ((t (:family "Cantarell" :height 160 :weight ultrabold :foreground "#fb4934"))))
 '(org-agenda-done ((t (:foreground "#96eb42"))))
 '(org-time-grid ((t (:foreground "#7c6f64"))))
 '(org-agenda-current-time ((t (:inherit org-time-grid :weight extrabold))))
 '(org-link ((t (:foreground "aquamarine" :underline t))))
 '(mg/org-bug ((t (:inherit org-todo :foreground "#d3869b"))))
 '(mg/org-crash ((t (:inherit org-todo :foreground "#fb4934"))))

 ;; Tree sitter
 '(tree-sitter-hl-face:type.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:variable.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:operator ((t (:foreground "#bee4a5"))))
 '(tree-sitter-hl-face:function.call ((t (:inherit font-lock-function-name-face :foreground unspecified))))
 '(tree-sitter-hl-face:label ((t (:foreground "#83a598"))))
 )

(provide-theme 'test)
