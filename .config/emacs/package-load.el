(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package evil)
(evil-mode 1)

(use-package tex
  :ensure auctex)

(defun launch-lsp ()
  (lsp)
  (company-mode 1)
  (yas-minor-mode)
  )
  
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "s-m")
  :commands lsp
  :config (setq lsp-eldoc-render-all t)
  :config (setq lsp-lens-enable nil)
  :config (lsp-enable-which-key-integration t)
  :hook ((css-mode web-mode java-mode) . launch-lsp)
  :ensure t)

(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-cursor t)
  (lsp-ui-doc-include-signature t)
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
  :custom
  (company-tooltip-align-annotations t)
  (company-tooltip-margin 2)
  (company-echo-delay 0.1)
  (company-tooltip-flip-when-above t)
  (company-tooltip-width-grow-only t)
  (company-tooltip-maximum-width 80)
  )

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-frame-behavior 'point)
  )

(use-package ccls
  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (launch-lsp)))
  :ensure t)

(use-package pdf-tools
  :ensure t)

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
  :hook (treemacs-mode . on-treemacs)
  )

(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")

(setq company-idle-delay (lambda () (if (company-in-string-or-comment) nil 0)))
(setq company-minimum-prefix-length 1)

(defun on-org-mode ()
  (text-scale-increase 1)

  (org-indent-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  )

(use-package org
  :hook (org-mode . on-org-mode)
  :config (setq org-ellipsis (all-the-icons-material "arrow_drop_down"))
  :config (setq org-agenda-files
                '(
                  "~/agenda/Dorset.org"
                  "~/agenda/Perso.org"
                  ))
  :config (setq org-log-done 'time)
  :config (setq org-todo-keyword-faces
                '(("BUG" . mg/org-bug)
                  ("CRASH" . mg/org-crash)
                  )
                )
  )


(use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;(set-face-attribute 'org-block nil :inherit 'fixed-pitch :foreground nil :background "#191b1c")

(defun org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  )

(use-package visual-fill-column
  :hook (org-mode . org-mode-visual-fill))


  (ligature-set-ligatures 'c-mode '("->" "<-" "<=" ">=" "==" "!="))
  
(use-package all-the-icons
    :if (display-graphic-p)
    :ensure t)
  (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append)

(use-package svg-lib
  :ensure t)

(use-package which-key)
(which-key-mode 1)

(use-package general)

(use-package ivy
  :ensure t
  :bind (:map ivy-minibuffer-map
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              )
 )

(ivy-mode 1)

(use-package ivy-rich
  :ensure t)

(use-package counsel
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f"  . counsel-find-file)
         )
  :ensure t)

(ivy-rich-mode 1)

(use-package hydra)

(window-divider-mode 1)

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

(use-package yasnippet
  :ensure t
  )
