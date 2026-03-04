
;;                                 THE PACKAGE                                ;;
;; ========================================================================== ;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  )

(use-package f
	     :ensure t
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
    :custom
    (evil-want-integration t)
    (evil-want-keybinding nil)
	:config
	(evil-mode 1)
)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  )

;; ========================================================================== ;;
;;                             Programming related                            ;;
;; ========================================================================== ;;

;; (defun launch-lsp ()
;;   (lsp)
;;   ; (corfu-mode 1)
;;   (yas-minor-mode 1)
;;   ;; (tree-sitter-hl-mode)
;;   ; (lsp-semantic-tokens-mode 1)
;;   (company-mode -1)
;;   )


;; (use-package lsp-mode
;;   :init (setq lsp-keymap-prefix "C-[")
;;   (setq lsp-clients-clangd-args (list "--header-insertion-decorators=0" "--clang-tidy" "--enable-config" "--log=verbose"))
;;   ;(setq lsp-clients-clangd-executable t)
;;   (setq lsp-clangd-binary-path "/usr/lib/llvm/18/bin/clangd")
;;   :commands lsp
;;   :config
;;   (setq lsp-eldoc-render-all t)
;;   (setq lsp-lens-enable nil)
;;   (lsp-enable-which-key-integration t)
;;   (setq lsp-completion-provider :none)
;;   (setq lsp-semantic-tokens-enable t)
;;   (setq lsp-semantic-tokens-warn-on-missing-face t)
;;   (setq lsp-completion-default-behaviour :insert)
;;   ;; :hook ((c-mode css-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode) . launch-lsp)
;;   :ensure t)

(defun launch-eglot ()
  "Start Eglot along with other useful minor modes."
  (eglot-ensure)
  (company-mode 1)
  ; (corfu-mode 1)
  (yas-minor-mode 1)
  ;(tree-sitter-hl-mode)
  ;(eglot-semtok-font-lock-init)
  )

(use-package eglot
  :ensure t
  ;; :init
  ;; (require 'eglot-semtok "/home/mrghastien/os-files/.config/emacs/manual/eglot-supplements/eglot-semtok.el")
  :config
  (evil-define-key 'normal eglot-mode-map
    (kbd "SPC f") 'eglot-format
    (kbd "SPC r") 'eglot-rename
    (kbd "SPC a") 'eglot-code-actions
    )
  (evil-define-key 'normal flymake-mode-map
    (kbd "SPC n") 'flymake-goto-next-error
    (kbd "SPC p") 'flymake-goto-prev-error
    )
  :custom
  (eglot-report-progress nil)


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
  (add-to-list 'eglot-server-programs '((typst-ts-mode) . ("tinymist")))
  (add-to-list 'eglot-server-programs
               `((java-ts-mode java-mode) . (
                                             "/home/mrghastien/builds/eclipse-jdtls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls"
                                             "-configuration"
                                             ,(format "%s/.config/emacs/eclipse-jdtls/config" (getenv "HOME"))
                                             "-data"
                                             ,(format "%s/.config/emacs/eclipse-jdtls/data" (getenv "HOME"))
                                             )
                 )
               )
  :hook ((c-mode c++-mode c-ts-mode css-mode csharp-ts-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode typst-ts-mode python-ts-mode) . launch-eglot)
  ;; (eglot-connect . 'eglot-semtok-on-connected)
  )

(use-package typst-ts-mode
  :mode "\\.typ\\'"
  )

(use-package websocket :ensure t)
(use-package typst-preview
  :ensure nil
  :after websocket
  :after typst-ts-mode
  :load-path "~/.config/emacs/manual-packages"
  :custom
  (typst-preview-invert-colors "never")
  )


(use-package treesit
  :config
  (setq treesit-font-lock-level 4)
  (setf
   (alist-get "\\.c\\'" auto-mode-alist) 'c-ts-mode
   (alist-get "\\.h\\'" auto-mode-alist) 'c-ts-mode
   )
  )

(use-package company
  :ensure t
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
  (setq company-global-modes nil)
  (global-company-mode 1)
  :custom
  (company-tooltip-align-annotations t)
  (company-tooltip-margin 2)
  (company-echo-delay 0.1)
  (company-tooltip-flip-when-above t)
  (company-tooltip-width-grow-only t)
  (company-tooltip-maximum-width 80)
  )

(use-package corfu
  :ensure t
  ;; :config
  ;; (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-on-exact-match nil)
  (tab-always-indent 'complete)
  )

(use-package autoinsert
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
  :defer t
  )

(use-package emmet-mode
  :defer t
  :hook ((mhtml-mode css-mode) . emmet-mode)
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
  (corfu-mode 1)
  )

(use-package tuareg
  :defer t
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
;;   ; :hook (company-mode . company-box-mode)
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
  :defer t
  :config
  (ligature-set-ligatures '(c-mode c++-mode java-mode python-mode ada-mode) '("->" "<-" "<=" ">=" "==" "!="))
  )

(use-package indent-bars
  :ensure t
  :custom
  (indent-bars-color '(highlight :face-bg nil :blend 0.325))
  (indent-bars-starting-column 0)
  (indent-bars-pattern ". . ")
  (indent-bars-width-frac 0.25)
  (indent-bars-pad-frac 0.1)
  (indent-bars-zigzag nil)
  (indent-bars-display-on-blank-lines t)
  (indent-bars-prefer-character t)
  :hook ((c-mode c-ts-mode c++-mode c++-ts-mode java-mode python-mode vhdl-mode) . indent-bars-mode)
  )

;; ==== Language server front-ends ====

;; (use-package ccls
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

;; (defun on-treemacs ()
;;   (setq line-spacing 0)
;;   )

;; (use-package treemacs
;;   :ensure t
;;   :hook (treemacs-mode . on-treemacs)
;;   )



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

(defun on-org-mode ()
  (text-scale-increase 1)

  ;; (org-indent-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  )


;(load-file "~/epita/ing1/lessons/publication.el")
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
  (setq org-latex-pdf-process '("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f"))
  ;(epipub-setup)
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

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :hook (org-agenda-finalize . org-modern-agenda)
  )

(use-package org-novelist
  :vc (:url "https://github.com/sympodius/org-novelist.git"
       :rev :newest)  ; Use the latest commit, rather than the latest release. For latest release, remove ":rev :newest"
  :custom
    (org-novelist-author "Bastien Morino")  ; The default author name to use when exporting a story. Each story can also override this setting
    (org-novelist-author-email "bastien.morino@free.fr")  ; The default author contact email to use when exporting a story. Each story can also override this setting
    (org-novelist-automatic-referencing-p nil)  ; Set this variable to 't' if you want Org Novelist to always keep note links up to date. This may slow down some systems when operating on complex stories. It defaults to 'nil' when not set
  :bind (("C-c n n s" . org-novelist-new-story)
          :map org-novelist-mode-map
          ("C-c n n c" . org-novelist-new-chapter)
          ("C-c n d c" . org-novelist-destroy-chapter)
          ("C-c n r c" . org-novelist-rename-chapter)
          ("C-c n n a" . org-novelist-new-character)
          ("C-c n d a" . org-novelist-destroy-character)
          ("C-c n r a" . org-novelist-rename-character)
          ("C-c n n p" . org-novelist-new-prop)
          ("C-c n d p" . org-novelist-destroy-prop)
          ("C-c n r p" . org-novelist-rename-prop)
          ("C-c n n l" . org-novelist-new-place)
          ("C-c n d l" . org-novelist-destroy-place)
          ("C-c n r l" . org-novelist-rename-place)
          ("C-c n u"   . org-novelist-update-references)
          ("C-c n r s" . org-novelist-rename-story)
          ("C-c n e"   . org-novelist-export-story)
          ("C-c n l l" . org-novelist-link-to-story)
          ("C-c n l u" . org-novelist-unlink-from-story)
          ("C-c n t"   . org-novelist-toggle-automatic-referencing))
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
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content nil)
  (setq dashboard-icon-type nil)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; (dashboard-modify-heading-icons '((recents   . "file-text")
  ;;                                 (bookmarks . "book")))
  )

;; (use-package pixel-scroll
;;   :config
;;   (setq pixel-scroll-precision-interpolate-mice nil)
;;   (setq pixel-scroll-precision-interpolate-page t)
;;   (setq pixel-scroll-precision-use-momentum nil)
;;   (pixel-scroll-precision-mode t)
;;   )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


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
    ;; Mode line config
    (load-theme 'test-dark nil t)
    (load-theme 'test-light nil t)
    (let* (
	   (home (getenv "HOME"))
	   (theme_file_path (format "%s/.config/theme_variant" home))
	   (theme_variant (f-read-text theme_file_path))
	   )
      (enable-theme (intern (format "test-%s" theme_variant)))
      )
    )
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame (on-make-frame))))
  (on-make-frame)
  )

(require 'cml "~/.config/emacs/cml.el")
