(deftheme test-dark
  :family 'test
  :kind 'color-scheme
  :background-mode 'dark
  "Created 2022-05-07.")

(custom-theme-set-variables
 'test-dark
 '(evil-normal-state-cursor '(hbar "#fe8019"))
 '(evil-insert-state-cursor '(bar "#b8bb26"))
 '(evil-replace-state-cursor '(hollow "#b732de"))
 '(evil-visual-state-cursor '(box "turquoise"))
 '(evil-emacs-state-cursor '(hbar "#a575ec"))
 '(cml-visual-mode-bg (if (display-graphic-p)
                          "turquoise"
                        "blue"
                        ))
 '(cml-visual-mode-fg (if (display-graphic-p)
                          "#003b50"
                        "cyan"
                        ))
 '(cml-normal-mode-bg (if (display-graphic-p)
                          "#fe8300"
                        "red"
                        ))
 '(cml-normal-mode-fg (if (display-graphic-p)
                          "#801100"
                        "yellow"
                        ))
 '(cml-insert-mode-bg (if (display-graphic-p)
                          "#aff212"
                        "green"
                        )
                      )
 '(cml-insert-mode-fg (if (display-graphic-p)
                          "#005200"
                        "green"
                        ))
 '(cml-replace-mode-fg "#29005e")
 '(cml-modified-name-color "#fb4934")
 '(cml-read-only-name-color "#fe8019")

 '(ccls-sem-highlight-method 'overlay)
 '(ccls-sem-type-faces [font-lock-type-face])
 '(ccls-sem-variable-faces [default])
 '(ccls-sem-parameter-faces ['default])
 '(ccls-sem-macro-faces [chl-macro-face])

 '(window-divider-default-places 'right-only)
 '(window-divider-default-right-width 2)
 '(window-divider-default-bottom-width 1)

 '(lsp-ui-doc-border "#504b48")
)

(custom-theme-set-faces
 'test-dark
 ; General ; :background "#1d2021" :foreground "#fbf1c0"
 '(default (
            (((min-colors 256)) . (:background "#282828" :foreground "#ebdbb2" :weight regular :width expanded :height 110 :family "Iosevka"))
            (((type tty) (min-colors 8)) . (:background "black" :foreground "white"))
            )
           )
 '(variable-pitch ((t (:inherit default :family "Inter Display" :width normal :weight regular :slant normal :height 140))))
 '(fixed-pitch ((t (:inherit default :family "Iosevka"))))
 '(error ((t (:foreground "red" :weight ultrabold :underline nil))))
 '(link ((t (:foreground "aquamarine" :underline t))))
 '(fringe ((t (:background "#3c3836"))))
 '(line-number ((t (:background "#3a3432" :foreground "#7c6f64"))))
 '(line-number-current-line (
                             (((min-colors 256)) (:background "#504945" :foreground "#fe8019"))
                             (((type tty) (min-colors 8)) (:background "red" :foreground "yellow" :weight black))
                             )
                            )
 '(line-number-major-tick ((t (:inherit (line-number) :foreground "#bdae93" :weight bold))))
 '(line-number-minor-tick ((t (:inherit (line-number) :foreground "#928374" :weight bold))))
 '(mode-line ((t (:box nil :foreground "#fbf1c7" :background "#303030" :family "Fira Code"))))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "#928374"))))
 ;'(mode-line-inactive ((t (:inherit mode-line :box ( :line-width (-1 . 6) :color "#333") :foreground "gray30" :background "#282828"))))
 '(highlight (
              (((min-colors 256)) (:background "#83a598" :foreground "gray10"))
              (((type tty) (min-colors 8)) (:background "blue" :foreground "white"))
              )
             )
 '(hl-line (
            (((min-colors 256)) (:background "#323335" :inherit nil))
            (((type tty) (min-colors 8)) (:background "cyan" :foreground "black" :inherit nil))
            )
           )
 '(minibuffer-prompt ((t (:foreground "#b8bb26" :weight bold))))
 '(region (
           (((min-colors 256)) (:background "#4a4742" :extend t))
           (((type tty) (min-colors 8)) (:background "blue" :foreground "white"))
           )
          )
 '(ivy-current-match ((t (:background "#65a7e2" :foreground "black" :extend t))))

 '(window-divider ((t (:foreground "#504b48"))))
 '(shadow (
           (((type tty)) (:inherit font-lock-comment-face))
           )
          )

 ; Dired
 '(ff-dired ((t (:inherit default :weight regular))))
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
 '(font-lock-builtin-face (
                           (((min-colors 256)) . (:foreground "#fe8019"))
                           (((type tty) (min-colors 8)) . (:foreground "red" :weight bold))
                           )
                          )
 '(font-lock-function-name-face (
                                 (((min-colors 256)) (:foreground "#b8bb26" :weight bold))
                                 (((type tty) (min-colors 8)) (:foreground "green" :weight bold))
                                 )
                                )
 '(font-lock-keyword-face ((t (:foreground "#fb4934"))))
 '(font-lock-type-face (
                        (((min-colors 256)) (:foreground "#fabd2f"))
                        (((type tty) (min-colors 8)) (:foreground "yellow" :weight bold))
                        )
                       )
 '(font-lock-variable-name-face (
                                 (((min-colors 256)) (:foreground "#83a598"))
                                 (((type tty) (min-colors 8)) (:foreground "cyan"))
                                 )
                                )
 '(font-lock-string-face (
                          (((min-colors 256)) (:foreground "#b8bb26" :slant italic))
                          (((type tty) (min-colors 256)) (:foreground "green" :weight bold))
                          )
                         ) ;8ec07c
 '(font-lock-constant-face ((t (:inherit font-lock-variable-name-face :weight semi-bold :foreground "#d3869b"))))
 '(font-lock-comment-face ((t (:foreground "gray50" :width expanded :slant italic))))
 '(font-lock-negation-char-face ((t (:weight normal :inherit font-lock-keyword-face))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(ccls-sem-member-face ((t (:slant normal :foreground "#83a598"))))
 '(ccls-sem-static-face ((t (:weight bold))))
 '(chl-number-face ((t (:weight normal :foreground "#d3869b"))))

 '(lsp-ui-doc-background ((t (:background "#32302f"))))
 '(lsp-ui-doc-header ((t (:background "#fb4934" :foreground "#282828"))))

 '(company-tooltip ((t (:background "#32302f" :extend t))))
 '(company-tooltip-annotation ((t (:foreground "#fe8019" :slant italic))))
 '(company-box-scrollbar ((t (:background "#fe8019"))))
 '(company-tooltip-selection (
                              (((min-colors 256)) (:background "#504945"))
                              (((type tty) (min-colors 8)) (:background "blue" :foregroudn "white"))
                              )
                             )
 '(company-tooltip-common ((t (:foreground "#fe8019" :weight bold))))

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

 ;; Dashboard
 '(dashboard-heading ((t (:inherit variable-pitch :foreground "#fe8019" :weight semi-bold))))
 '(dashboard-no-items-face ((t (:inherit variable-pitch :slant italic))))
 '(dashboard-items-face ((t (:inherit fixed-pitch))))
 '(dashboard-banner-logo-title ((t (:inherit variable-pitch))))
 '(dashboard-footer-face ((t (:inherit (font-lock-comment-face variable-pitch)))))


 ;; Tree sitter
 '(tree-sitter-hl-face:type.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:variable.builtin ((t (:inherit font-lock-keyword-face))))
 '(tree-sitter-hl-face:property (
                                 (default (:inherit font-lock-variable-name-face))
                                 (((min-colors 256)) (:slant italic))
                                 )
                                )
 '(tree-sitter-hl-face:operator ((t (:foreground "#fe8019"))))
 '(tree-sitter-hl-face:punctuation ((t (:foreground "#fe8019"))))
 '(tree-sitter-hl-face:function.call ((t (:inherit font-lock-function-name-face :foreground unspecified))))
 '(tree-sitter-hl-face:label ((t (:foreground "#83a598"))))

 ;; which key
 '(help-key-binding ((t (:inherit fixed-pitch :foreground "#8ec07c" :background "#3c3836" :box (:line-width (-1 . -1) :color "#504b48")))))
 '(which-key-key-face ((t (:foreground "#fe8019" :weight bold))))
 '(which-key-command-description-face ((t (:inherit default ))))
 '(which-key-group-description-face ((t (:foreground "#b8bb26" ))))
 '(which-key-separator-face ((t (:slant normal :foreground "#8ec07c"))))
 )

(provide-theme 'test-dark)
