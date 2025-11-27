;; ========================================================================== ;;
;;                                 THE PACKAGE                                ;;
;; ========================================================================== ;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  )



;; ========================================================================== ;;
;;                                 Keybindings                                ;;
;; ========================================================================== ;;

(use-package which-key
  :ensure t
  :config (which-key-mode 1)
  )

(use-package general
:ensure t)

(use-package hydra
:ensure t)

(use-package evil
	:ensure t
	:config
	(evil-mode 1)
)

;; ========================================================================== ;;
;;                             Programming related                            ;;
;; ========================================================================== ;;

(use-package origami
  :hook ((c-mode c++-mode elisp-mode) . origami-mode)
  )

(defun launch-completion ()
  ;; (if (display-graphic-p)
  ;;     (corfu-mode 1)
    (company-mode 1)
  ;; )
  )

;; (defun launch-lsp ()
;;   (lsp)
;;   (launch-completion)
;;   (yas-minor-mode 1)
;;   )

  
;; (use-package lsp-mode
;;   :init (setq lsp-keymap-prefix "s-m")
;;   :commands lsp
;;   :config
;;   (setq lsp-eldoc-render-all t)
;;   (setq lsp-lens-enable nil)
;;   (lsp-enable-which-key-integration t)
;;   ;:hook ((css-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode) . launch-lsp)
;;   :ensure t)

(defun launch-eglot ()
  "Start Eglot along with other useful minor modes."
  (eglot-ensure)
  (launch-completion)
  (yas-minor-mode 1)
  )

(use-package eglot
  :defer t
  :config
  (evil-define-key 'normal eglot-mode-map
    (kbd "SPC f") 'eglot-format
    (kbd "SPC r") 'eglot-rename
    (kbd "SPC a") 'eglot-code-actions
    (kbd "SPC n") 'flymake-goto-next-error
    )

  :config  
  (setq eglot-server-programs
        (cl-substitute-if
         (cons
          '(kotlin-mode kotlin-ts-mode)
          '("kotlin-language-server"))
         (lambda (server-program)
           (or (eq (car server-program) 'kotlin-mode)
               (and
                (listp (car server-program))
                (member 'kotlin-mode (car server-program))))
           )
         eglot-server-programs))

  (add-to-list 'eglot-server-programs `(typst-ts-mode . ("tinymist")))
  (add-to-list 'eglot-server-programs
               `((java-ts-mode java-mode) . ,(,(format "%s/.builds/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls" (getenv "HOME"))
                                             "-configuration"
                                             ,(format "%s/.config/emacs.eclipse-jdtls/config" (getenv "HOME"))
                                             "-data"
                                             ,(format "%s/.config/emacs.eclipse-jdtls/data" (getenv "HOME"))
                                             )))

  :hook ((c-mode c-ts-mode c++-mode css-mode csharp-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode typst-ts-mode python-ts-mode) . launch-eglot)
  )

(use-package c-ts-mode
  :ensure nil
  :custom
  (c-ts-mode-indent-offset 4)
  )

(use-package treesit
  :custom (treesit-font-lock-level 4)
  )

(use-package eglot-java
  :hook ((java-mode) . eglot-java-mode)
  )

(use-package company
  :defer t
  :bind (
         ("C-SPC" . company-complete)
          :map company-active-map
         ("M-j" . company-select-next)
         ("M-k" . company-select-previous)
         ("<escape>" . company-abort)
         )
  :config
  (setq company-idle-delay (lambda () (if (company-in-string-or-comment) nil 0)))
  (setq company-minimum-prefix-length 1)
  :custom
  (company-tooltip-align-annotations t)
  (company-tooltip-margin 2)
  (company-echo-delay 0.1)
  (company-tooltip-flip-when-above t)
  (company-tooltip-width-grow-only t)
  (company-tooltip-maximum-width 80)
  )

(use-package compat
  :ensure t)

;; (use-package corfu
;;   :ensure t
;;   :config
;;   (setq corfu-auto t)
;;   (setq corfu-auto-delay 0)
;;   )

(use-package autoinsert
  :defer t
  :config
  (setq auto-insert-query nil)
  (auto-insert-mode 1)
  (add-to-list 'auto-insert-alist '(("\\.\\([Hh]\\|hh\\|hpp\\|hxx\\|h\\+\\+\\)\\'" . "C / C++ header")
  (replace-regexp-in-string "[^A-Z0-9]" "_"
                            (string-replace "+" "P"
                                            (upcase
                                             (file-name-nondirectory buffer-file-name))))
  "#ifndef " str n "#define " str "

" _ "

#endif /* ! " str " */"))
  )

(use-package yasnippet
  :ensure t
  )

(use-package emmet-mode
  :defer t
  :hook ((mhtml-mode css-mode) . emmet-mode)
  )

(use-package typst-ts-mode
  :defer t
  :mode ("\\.type\\'" . typst-ts-mode)
  )

;; ==== Web Developpement ====

(defun on-web-mode ()
  (yas-minor-mode 1)
  (emmet-mode 1)
  )

(use-package web-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  :hook (web-mode . on-web-mode)
  )

(use-package js2-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

;; ==== OCaml ====

(defun on-ocaml-mode ()
  (merlin-mode)
  (launch-completion)
  )

(use-package tuareg
  :hook (tuareg-mode . on-ocaml-mode)
  :hook (caml-mode . tuareg-mode)
  :config
  (setq max-lisp-eval-depth 3200)
  )

(use-package merlin
  :defer t
  )

;; ==== Style & UI ====

;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode)
;;   :custom
;;   (company-box-frame-behavior 'point)
;;   )

;; (use-package lsp-ui
;;   :ensure t
;;   :custom
;;   (lsp-ui-doc-header t)
;;   (lsp-ui-doc-position 'at-point)
;;   (lsp-ui-doc-show-cursor t)
;;   (lsp-ui-doc-include-signature t)
;;   )

(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures '(c-mode c++-mode java-mode python-mode org-agenda-mode) '("->" "<-" "<=" ">=" "==" "!=" "--"))
  )

(use-package indent-bars
  :ensure t
  :custom
  (indent-bars-color '(highlight :face-bg t :blend 0.325))
  (indent-bars-starting-column 0)
  (indent-bars-pattern ". . ")
  (indent-bars-width-frac 0.1)
  (indent-bars-pad-frac 0.1)
  (indent-bars-zigzag nil)
  (indent-bars-display-on-blank-lines t)
  (indent-bars-prefer-character t)
  :hook ((c-mode c-ts-mode c++-mode c++-ts-mode java-mode python-mode vhdl-mode) . indent-bars-mode)
  )

;; ==== Language server front-ends ====

;; (use-package ccls
;;   :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (launch-eglot)))
;;   :ensure t
;;   )

;; (use-package lsp-java
;;   :ensure t
;;   )

;; ========================================================================== ;;
;;                                File managers                               ;;
;; ========================================================================== ;;

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )

(use-package dired-single
  :ensure t)

;; (defun on-treemacs ()
;;   (setq line-spacing 0)
;;   )

;; (use-package treemacs
;;   :ensure t
;;   :hook (treemacs-mode . on-treemacs)
;;   )

(use-package vhdl-mode
  :hook (vhdl-mode . (lambda () vhdl-stutter-mode vhdl-electric-mode))
  )

;; ========================================================================== ;;
;;                             Navigation & Search                            ;;
;; ========================================================================== ;;

(use-package ivy
  :ensure t
  :bind (:map ivy-minibuffer-map
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              )
  :config (ivy-mode 1)
 )


(use-package ivy-rich
  :ensure t
  :config (ivy-rich-mode 1)
  )

(use-package counsel
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f"  . counsel-find-file)
         )
  :ensure t)

;; ========================================================================== ;;
;;                               Org Mode & co.                               ;;
;; ========================================================================== ;;

(use-package calendar
  :ensure nil
  :defer t
  :config
  (setq calendar-week-start-day 1
        calendar-day-name-array ["Dimanche" "Lundi" "Mardi" "Mercredi"
                                 "Jeudi" "Vendredi" "Samedi"]
        calendar-month-name-array ["Janvier" "Février" "Mars" "Avril" "Mai"
                                   "Juin" "Juillet" "Août" "Septembre"
                                   "Octobre" "Novembre" "Décembre"])
  )

(require 'french-holidays "~/.config/emacs/french-holidays.el")
(setq calendar-holidays holiday-french-holidays)

(defun on-org-mode ()
  (text-scale-increase 1)

  (org-indent-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  )


(load-file "~/epita/lessons/publication.el")
(use-package org
  :ensure t
  :hook (org-mode . on-org-mode)
  :config
  (setq org-log-done 'time)
  (setq org-todo-keyword-faces
        '(("BUG" . mg/org-bug)
          ("CRASH" . mg/org-crash)
          )
        )
  (plist-put org-format-latex-options :scale 1.5)
  (add-to-list 'org-latex-packages-alist '("" "tikz" t))
  (setq org-preview-latex-default-process 'imagemagick)
  (setq org-agenda-files '("~/agenda/"))
  (setq org-agenda-block-separator 8411
        org-priority-faces
        '((?A :foreground "#ff4934" :weight bold)
          (?B :foreground "#fe8019" :weight bold)
          (?C :foreground "#b8bb26" :weight bold)
          )
        )
  (setq org-src-preserve-indentation t)
  (setq org-edit-src-content-indentation 0)
  (setq-default org-display-custom-times t)
  (setq org-time-stamp-custom-formats '("<%a %e %b %Y>" . "<%a %e %b %Y %H:%M>"))

  (epipub-setup)
)

(use-package org-modern
  :after org
  :config
  (global-org-modern-mode 1)
  (setq org-time-stamp-custom-formats '("<%a %b %e %Y>" . "<%a %b %e %Y %H:%M>"))
  (setq org-modern-timestamp '("  %a %e %b %Y  " . "  %H:%M  "))
  )

(use-package htmlize
  :ensure t
  :config
  (setq org-html-htmlize-output-type 'css)
  )
  

(defun org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  )

(use-package visual-fill-column
  :ensure t
  :hook (org-mode . org-mode-visual-fill))
;; specify the justification you want

(use-package org-super-agenda 
  :ensure t
  :config
  (setq org-super-agenda-groups
        '(;; Each group has an implicit boolean OR operator between its selectors.

          ;; This is the first filter, anything found here
          ;; will be placed in this group
          ;; even if it matches following groups
          (:name " En retard" ; Name
                 :scheduled past ; Filter criteria
                 :order 2 ; Order it should appear in agenda view
                 :face 'error) ; Font face used for text

          ;; This is the second filter, anything not found
          ;; from the first filter, but found here,
          ;; will be placed in this group
          ;; even if it matches following groups
          (:name "personnel" ; Name
                 :file-path "personal" ; Filter criteria
                 :order 3 ; Order it should appear in the agenda view
                 :face 'error) ; Font faced used for text

          (:name "EPITA"  ; Name
                 :file-path "epita" ; Filter criteria
                 :order 3 ; Order it should appear in the agenda view
                 :face 'error) ; Font face used for text

          (:name "JECT"  ; Name
                 :file-path "ject" ; Filter criteria
                 :order 3 ; Order it should appear in the agenda view
                 :face 'error) ; Font face used for text

          (:name " Today "  ; Optionally specify section name
                 :time-grid t ; Use the time grid
                 :date today ; Filter criteria
                 :scheduled today ; Another filter criteria
                 :order 1 ; Order it should appear in the agenda view
                 :face 'warning) ; Font face used for text
          )
        )
  )

(use-package org-modern
  :after 'org
  :hook (org-mode . org-modern-mode)
  )

;; ========================================================================== ;;
;;                                    Icons                                   ;;
;; ========================================================================== ;;
  
(use-package svg-lib
  :ensure t)

(window-divider-mode 1)

;; ========================================================================== ;;
;;                                Miscellaneous                               ;;
;; ========================================================================== ;;

(use-package tex
  :ensure auctex)

(use-package pdf-tools
  :defer t)

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content nil)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-set-heading-icons nil)
  (setq dashboard-set-file-icons nil)
  ;; (dashboard-modify-heading-icons '((recents   . "file-text")
  ;;                                 (bookmarks . "book")))
  (setq dashboard-item-names '(("Recent Files:"               . "Fichiers récents")
                               ("Bookmarks:" . "Marque-pages")
                               ("Agenda for the coming week:" . "Agenda")))

  (dashboard-setup-startup-hook)
  )

;; (use-package pixel-scroll
;;   :config
;;   (setq pixel-scroll-precision-interpolate-mice nil)
;;   (setq pixel-scroll-precision-interpolate-page t)
;;   (setq pixel-scroll-precision-use-momentum nil)
;;   (pixel-scroll-precision-mode -1)
;;   )

(use-package ultra-scroll
  ;:load-path "~/code/emacs/ultra-scroll" ; if you git clone'd instead of using vc
  ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; For Emacs>=30
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0) 
  :config
  (ultra-scroll-mode 1))

;; replaced by org-modern
;; (use-package org-bullets
;;   :after org
;;   :hook (org-mode . org-bullets-mode)
;;   :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(use-package all-the-icons
  :config
  (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'prepend)

  (setq org-ellipsis (all-the-icons-material "arrow_drop_down"))
  :ensure t)


;; (use-package treemacs-all-the-icons
;;   :ensure t
;;   :config
;;   (treemacs-load-theme "all-the-icons")
;;   )

(defun on-make-frame ()
  (when (= (length (frames-on-display-list)) 1)

    ;(load-theme 'test-dark)
    )
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame (on-make-frame))))
  (on-make-frame)
  )

;; Mode line config
(require 'cml "~/.config/emacs/cml.el")
