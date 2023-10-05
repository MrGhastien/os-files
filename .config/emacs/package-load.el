;; ========================================================================== ;;
;;                                 THE PACKAGE                                ;;
;; ========================================================================== ;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  )

(use-package quelpa
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
  :config (evil-mode 1)
  )

;; ========================================================================== ;;
;;                             Programming related                            ;;
;; ========================================================================== ;;

(defun launch-lsp ()
  (lsp)
  (company-mode 1)
  (yas-minor-mode 1)
  (tree-sitter-hl-mode)
  (display-fill-column-indicator-mode)
  (whitespace-mode)
  (setq fill-column 80)
  (auto-insert)
)

  
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "s-m")
  :commands lsp
  :config
  (setq lsp-eldoc-render-all t)
  (setq lsp-lens-enable nil)
  (lsp-enable-which-key-integration t)
  ;:hook ((css-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode) . launch-lsp)
  :ensure t)

(defun launch-eglot ()
  "Start Eglot along with other useful minor modes."
  (eglot-ensure)
  (company-mode 1)
  (yas-minor-mode 1)
  (tree-sitter-hl-mode)
  )

(use-package eglot
  :ensure t
  :hook ((css-mode web-mode java-mode js2-mode mhtml-mode rust-mode python-mode LaTeX-mode) . launch-eglot)
  )

(defadvice company-abort (after propagate-escape activate)
  (evil-normal-state)
  )

(use-package quelpa-use-package
  :ensure t)

(use-package gdb-mi :quelpa (gdb-mi :fetcher git
                                    :url "https://github.com/weirdNox/emacs-gdb.git"
                                    :files ("*.el" "*.c" "*.h" "Makefile"))
  :init
  (fmakunbound 'gdb)
  (fmakunbound 'gdb-enable-debug)
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
  :custom
  (company-tooltip-align-annotations t)
  (company-tooltip-margin 2)
  (company-echo-delay 0.1)
  (company-tooltip-flip-when-above t)
  (company-tooltip-width-grow-only t)
  (company-tooltip-maximum-width 80)
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package yasnippet
  :ensure t
  )

(use-package autoinsert
  :config
  (setq auto-insert-query nil)
  (auto-insert-mode 1)
  )

(use-package emmet-mode
  :ensure t
  :hook ((mhtml-mode css-mode) . emmet-mode)
  )

;; ==== Web Developpement ====

(defun on-web-mode ()
  (yas-minor-mode 1)
  (emmet-mode 1)
  )

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  :hook (web-mode . on-web-mode)
  )

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

;; ==== Style & UI ====

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-frame-behavior 'point)
  )

(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-cursor t)
  (lsp-ui-doc-include-signature t)
  )

(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures '(c-mode c++-mode java-mode python-mode) '("->" "<-" "<=" ">=" "==" "!="))
  )

(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :ensure t)

(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character)
  )

;; ==== Language server front-ends ====

(use-package ccls
  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (launch-lsp)))
  :ensure t
  )

(use-package lsp-java
  :ensure t
  )

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

(defun on-treemacs ()
  (setq line-spacing 0)
  )

(use-package treemacs
  :ensure t
  :hook (treemacs-mode . on-treemacs)
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

(defun on-org-mode ()
  (text-scale-increase 1)

  (org-indent-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  )


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
  (plist-put org-format-latex-options :scale 2.0)
  (add-to-list 'org-latex-packages-alist '("" "tikz" t))
  (setq org-preview-latex-default-process 'imagemagick)
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
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  )

(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  ;(global-whitespace-mode t)
)


(defun on-make-frame ()
  ;(set-frame-parameter nil 'alpha-background 100)
  (when (= (length (frames-on-display-list)) 1)
    (use-package org-bullets
      :after org
      :hook (org-mode . org-bullets-mode)
      :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

    
    (use-package all-the-icons
      :config
      (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
      (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append)

      (setq org-ellipsis (all-the-icons-material "arrow_drop_down"))
      :ensure t)

    (use-package treemacs-all-the-icons
      :ensure t
      :config
      (all-the-icons-install-fonts t)
      (treemacs-load-theme "all-the-icons")
      )

    (set-frame-font "Cascadia Code 12" nil t)
    
    ;; Mode line config
    (load "~/.config/emacs/cml.el")
    (load-theme 'test2)
    )
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame (on-make-frame))))
  (on-make-frame)
  )
