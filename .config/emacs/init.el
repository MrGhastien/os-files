(set-language-environment "UTF-8")

(setq custom-file "~/.config/emacs/custom.el")
(setq custom-theme-directory "~/.config/emacs/themes")
(load "~/.config/emacs/package-load.el")
(load "~/.config/emacs/foundation-faces.el")
(load "~/.config/emacs/chighlight.el")
(load custom-file)


;(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-grow-only t)
;(add-to-list 'default-frame-alist '(alpha-background . 65))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-set-style "k&r")
(setq c-basic-offset 4)


(setq backup-directory-alist '(("." . "~/emacs-backups")))

(setq lsp-java-completion-overwrite nil)

(setq native-comp-async-report-warnings-errors 'silent)

;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-D") 'compile)
(global-set-key (kbd "C-M-y") 'load-theme)


(dolist (mode '(treemacs-mode-hook
                org-mode-hook
                org-agenda-mode-hook
                help-mode-hook
                ))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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
  "Insert an tcolorbox environment ENV with an optional label."
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


(put 'dired-find-alternate-file 'disabled nil)

(load-theme 'test2)
