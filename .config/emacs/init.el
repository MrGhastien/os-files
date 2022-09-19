(set-language-environment "UTF-8")

(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-linum-mode t)

(load-theme 'Test)
(set-face-attribute 'default nil :font "Source Code Pro" :height 125 :weight 'normal)

;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) 

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(require 'evil)
(evil-mode 1)

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
