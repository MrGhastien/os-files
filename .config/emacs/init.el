(set-language-environment "UTF-8")

(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-linum-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-set-style "k&r")
(setq c-basic-offset 4)

(load "~/.config/emacs/chighlight.el")

(setq backup-directory-alist '(("." . "~/emacs-backups")))

;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) 
(global-set-key (kbd "M-D") 'compile) 

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package evil)
(evil-mode 1)

(use-package tex
  :ensure auctex)

(use-package lsp-mode
  :init (setq lsp-keymap-prefix "s-m")
  :commands lsp
  :config (setq lsp-eldoc-render-all t)
  :config (setq lsp-lens-enable nil)
  :ensure t)


(use-package ccls
  :hook ((c-mode c++-mode java-mode) . (lambda () (require 'ccls) (lsp)))
  :ensure t)

(add-hook 'c-mode-hook #'ligature-mode)
(add-hook 'c++-mode-hook #'ligature-mode)
(add-hook 'java-mode-hook #'ligature-mode)

(use-package pdf-tools
  :ensure t)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )

(use-package dired-single
  :ensure t)


(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

(define-skeleton latex-insert-inline-math
  "Inserts \\( \\) to enable math mode in LaTeX."
  nil
  "\\("
  _
  "\\)"
  )

(defun onTeXStyleHook (&rest _)
  (LaTeX-add-environments
   '("definition" latex-tcolorbox-env)
   '("prop" latex-tcolorbox-env)
   '("theorem" latex-tcolorbox-env)
   '("corollary" latex-tcolorbox-env)
   '("algo" latex-tcolorbox-env)
   '("lemma" latex-tcolorbox-env)
   )
  )

(add-hook 'LaTeX-mode-hook 'onTeXStyleHook)

(defun latex-tcolorbox-env (env)
  "Insert an tcolorbox environment with an optional label."
  (let ((title (read-string "(Optional) Title :"))) ;; Set the 'title' variable to the input typed in the mini-buffer
    (let ((label (if (string-blank-p title) ;; Prompt for the label if the title isn't empty
                     ""
                   (read-string "(Optional) Label :")
                   )
                 )
          )
      (LaTeX-insert-environment env (format "{%s}{%s}" title label))
      )
    )
  )

(load-theme 'Test)

(defun on-make-frame ()
  
  	
  (use-package org
  	:config (setq org-ellipsis (all-the-icons-material "arrow_drop_down")))
  
  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

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
  
  ;; Mode line config
  (load "~/.config/emacs/modeline.el")
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame (on-make-frame))))
  (on-make-frame)
  )
(put 'dired-find-alternate-file 'disabled nil)
