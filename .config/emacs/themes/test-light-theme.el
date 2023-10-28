(deftheme test-light
  "Created 2022-05-07.")

(custom-theme-set-variables
 'test-light
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
 '(cml-modified-name-color "#cc241d")
 '(cml-read-only-name-color "#b57614")

 '(ccls-sem-highlight-method 'font-lock)
 '(ccls-sem-type-faces [font-lock-type-face])
 '(ccls-sem-variable-faces [default])
 '(ccls-sem-macro-faces [chl-macro-face])

 '(window-divider-default-places 'right-only)
 '(window-divider-default-right-width 2)
 '(window-divider-default-bottom-width 1)

 '(lsp-ui-doc-border "#504b48")
)

(custom-theme-set-faces
 'test-light
 ; General ; :background "#f9f5d7"
 '(default ((t (:background "#f9f9ec" :foreground "#3c3836" :weight regular :width expanded :height 110 :family "Iosevka Custom"))))
 '(variable-pitch ((t (:inherit default :family "Cantarell" :width normal :weight regular :slant normal :height 140))))
 '(fixed-pitch ((t (:inherit default :family "Iosevka Custom Extended" :weight regular))))
 '(error ((t (:foreground "#dd0006" :weight ultrabold :underline nil))))
 '(link ((t (:foreground "RoyalBlue2" :underline t))))
 '(fringe ((t (:background "#f2efe5"))))
 '(line-number ((t (:background "#f2efe5" :foreground "#7c6f64"))))
 '(line-number-current-line ((t (:background "#f9f9ec" :foreground "#d65d0e"))))
 '(line-number-major-tick ((t (:inherit (line-number) :foreground "#665c54" :weight bold))))
 '(line-number-minor-tick ((t (:inherit (line-number) :weight bold))))
 '(mode-line ((t (:box (:line-width (-1 . 6) :color "#f0ece1") :height 120 :foreground "#3c3836" :background "#f0ece1" :family "Fira Code"))))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "#99938c"))))
 '(highlight ((t (:background "#83a598" :foreground "gray10"))))
 '(hl-line ((t (:background "#fffff7" :inherit nil))))
 '(minibuffer-prompt ((t (:foreground "#d65d0e" :weight bold))))
 '(region ((t (:background "#a4d6e0" :extend t))))

 '(ivy-current-match ((t (:background "#65a7e2" :foreground "#fbf1c7" :underline nil))))
 '(ivy-minibuffer-match-face-2 ((t (:background "#b8bb26" :foreground "#3c3836" :underline nil))))

 '(window-divider ((t (:foreground "#504b48"))))
 '(fill-column-indicator ((t (:foreground "#d5c4a1"))))

 ; Dired
 '(ff-dired ((t (:inherit fixed-pitch))))
 '(dired-directory ((t (:inherit default))))
 '(dired-marked ((t (:foreground "#f25c54" :weight bold :inherit ff-dired))))
 '(dired-flagged ((t (:background "#f25c54" :foreground "gray10" :weight ultrabold :inherit ff-dired))))
 '(dired-symlink ((t (:foreground "turquoise" :inherit ff-dired))))
 '(dired-broken-symlink ((t (:foreground "turquoise" :strike-through t :inherit ff-dired))))

 ; Treemacs
 '(ff-treemacs ((t (:family "Cantarell" :weight medium :height 130))))
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
 '(font-lock-builtin-face ((t (:foreground "#d65d0e"))))
 '(font-lock-function-name-face ((t (:foreground "#d65d0e"))))
 '(font-lock-keyword-face ((t (:foreground "#cc241d"))))
 '(font-lock-type-face ((t (:foreground "#d79921"))))
 '(font-lock-variable-name-face ((t (:foreground "#458588"))))
 '(font-lock-string-face ((t (:foreground "#98971a")))) ;8ec07c
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold :foreground "#b16286"))))
 '(font-lock-comment-face ((t (:foreground "gray50" :width expanded :slant italic))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(ccls-sem-member-face ((t (:slant normal :foreground "#076678"))))
 '(ccls-sem-static-face ((t (:weight bold))))
 '(chl-number-face ((t (:weight normal :foreground "#d3869b"))))
 '(chl-macro-face ((t (:foreground "#b16286"))))

 '(lsp-ui-doc-background ((t (:background "#fffbdc"))))
 '(lsp-ui-doc-header ((t (:background "#282828" :foreground "#3c3836"))))

 '(show-paren-match ((t (:inherit default :underline t :foreground "#65a7e2" :weight extrabold))))

 '(company-tooltip ((t (:background "#fffbdc" :extend t))))
 '(company-tooltip-annotation ((t (:foreground "#d65d0e" :slant italic))))
 '(company-box-scrollbar ((t (:background "#d65d0e"))))
 '(company-tooltip-selection ((t (:background "#f9e3d0"))))
 '(company-tooltip-common ((t (:foreground "#d65d0e" :weight bold))))

 ; Latex
 '(font-latex-math-face ((t (:weight normal :foreground "#c1ffc8"))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "misty rose"))))
 '(font-latex-script-char-face ((t (:foreground "cyan"))))
 '(italic ((t (:slant italic))))
 '(font-latex-sectioning-5-face ((t (:weight extra-bold :underline t :inherit font-lock-function-name-face))))

 ; Org mode
 '(org-level-1 ((t (:foreground "#cc241d" :weight ultrabold))))
 '(org-level-2 ((t (:foreground "#d65d0e" :weight extrabold))))
 '(org-level-3 ((t (:foreground "#98971a" :weight bold))))
 '(org-hide ((t (:foreground "#f9f5d7"))))
 `(org-block ((t (:inherit fixed-pitch :foreground nil :background "#fbf1c7" :extend t)))) ;171919
 '(org-code ((t (:inherit (fixed-pitch) :background nil))))
 '(org-verbatim ((t (:inherit (fixed-pitch)))))
 '(org-checkbox ((t (:inherit fixed-pitch :foreground "#427b58" :weight bold))))
 '(org-table ((t (:inherit (fixed-pitch)))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch) :background "#fbf1c7" :extend t))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-special-keyword ((t (:inherit fixed-pitch :foreground "#689d6a" :slant italic :weight bold :height 0.75))))
 '(org-todo ((t (:weight extrabold :foreground "#d79921"))))
 '(org-headline-done ((t (:foreground "#a89984"))))
 '(org-date ((t (:inherit org-special-keyword :foreground "RoyalBlue2" :underline t))))
 '(org-agenda-date ((t (:foreground "#d65d0e"))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :underline t))))
 '(org-agenda-structure ((t (:height 160 :weight ultrabold :foreground "#076678"))))
 '(org-upcoming-deadline ((t (:inherit fixed-pitch :slant italic :foreground "#d65d0e"))))
 '(org-upcoming-distant-deadline ((t (:inherit org-upcoming-deadline :slant normal :foreground "#3c3836"))))
 '(org-time-grid ((t (:foreground "#928374"))))
 '(org-agenda-current-time ((t (:inherit org-time-grid :weight extrabold))))
 '(org-link ((t (:inherit link :foreground nil :underline nil))))
 '(mg/org-bug ((t (:inherit org-todo :foreground "#d3869b"))))
 '(mg/org-crash ((t (:inherit org-todo :foreground "#fb4934"))))

 ;; Tree Sitter
 '(tree-sitter-hl-face:type.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:variable.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:operator ((t (:foreground "#427b58"))))
 '(tree-sitter-hl-face:function.call ((t (:inherit font-lock-function-name-face :foreground unspecified))))
 '(tree-sitter-hl-face:property ((t (:inherit font-lock-variable-name-face :slant italic))))

 ;;which key
 '(which-key-key-face ((t (:foreground "#d65d0e" :weight bold))))
 '(which-key-separator-face ((t (:foreground "#427b56" :weight normal))))
 '(which-key-command-description-face ((t (:inherit default))))
 '(which-key-group-description-face ((t (:foreground "#076678"))))

 ;;whitespace mode
 '(whitespace-line ((t (:foreground "hot pink" :background "#ebdbb2"))))

 '(highlight-indent-guides-character-face ((t (:foreground "#00ff00"))))
 )

(provide-theme 'test-light)
