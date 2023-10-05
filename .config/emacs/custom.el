(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-insert-alist
   '((("\\.\\([Hh]\\|hh\\|hpp\\|hxx\\|h\\+\\+\\)\\'" . "C / C++ header")
      (replace-regexp-in-string "[^A-Z0-9]" "_"
                                (string-replace "+" "P"
                                                (upcase
                                                 (file-name-nondirectory buffer-file-name))))
      "#ifndef " str n "#define " str "

" _ "

#endif /* ! " str " */")
     (("\\.\\([Cc]\\|cc\\|cpp\\|cxx\\|c\\+\\+\\)\\'" . "C / C++ program")
      nil "#include \""
      (let
          ((stem
            (file-name-sans-extension buffer-file-name))
           ret)
        (dolist
            (ext
             '("H" "h" "hh" "hpp" "hxx" "h++")
             ret)
          (when
              (file-exists-p
               (concat stem "." ext))
            (setq ret
                  (file-name-nondirectory
                   (concat stem "." ext))))))
      & 34 | -10)
     (("[Mm]akefile\\'" . "Makefile")
      . "makefile.inc")
     (html-mode lambda nil
                (sgml-tag "html"))
     (plain-tex-mode . "tex-insert.tex")
     (bibtex-mode . "tex-insert.tex")
     (latex-mode "options, RET: " "\\documentclass[" str & 93 | -1 123
                 (read-string "class: ")
                 "}
"
                 ("package, %s: " "\\usepackage["
                  (read-string "options, RET: ")
                  & 93 | -1 123 str "}
")
                 _ "
\\begin{document}
" _ "
\\end{document}")
     (("/bin/.*[^/]\\'" . "Shell-Script mode magic number")
      lambda nil
      (if
          (eq major-mode
              (default-value 'major-mode))
          (sh-mode)))
     (ada-mode . ada-header)
     (("\\.[1-9]\\'" . "Man page skeleton")
      "Short description: " ".\\\" Copyright (C), "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH "
      (file-name-base
       (buffer-file-name))
      " "
      (file-name-extension
       (buffer-file-name))
      " "
      (format-time-string "%Y-%m-%d ")
      "
.SH NAME
"
      (file-name-base
       (buffer-file-name))
      " \\- " str "
.SH SYNOPSIS
.B "
      (file-name-base
       (buffer-file-name))
      "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
"
      (user-full-name)
      '(if
           (search-backward "&"
                            (line-beginning-position)
                            t)
           (replace-match
            (capitalize
             (user-login-name))
            t t))
      '(end-of-line 1)
      " <"
      (progn user-mail-address)
      ">
")
     (".dir-locals.el" nil ";;; Directory Local Variables
" ";;; For more information see (info \"(emacs) Directory Variables\")

" "(("
'(setq v1
       (let
           (modes)
         (mapatoms
          (lambda
            (mode)
            (let
                ((name
                  (symbol-name mode)))
              (when
                  (string-match "-mode$" name)
                (push name modes)))))
         (sort modes 'string<)))
(completing-read "Local variables for mode: " v1 nil t)
" . (("
(let
    ((all-variables
      (apropos-internal ".*"
                        (lambda
                          (symbol)
                          (and
                           (boundp symbol)
                           (get symbol 'variable-documentation))))))
  (completing-read "Variable to set: " all-variables))
" . "
(completing-read "Value to set it to: " nil)
"))))
")
     (("\\.el\\'" . "Emacs Lisp header")
      "Short description: " ";;; "
      (file-name-nondirectory
       (buffer-file-name))
      " --- " str
      (make-string
       (max 2
            (- 80
               (current-column)
               27))
       32)
      "-*- lexical-binding: t; -*-"
      '(setq lexical-binding t)
      "

;; Copyright (C) "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

;; Author: "
      (user-full-name)
      '(if
           (search-backward "&"
                            (line-beginning-position)
                            t)
           (replace-match
            (capitalize
             (user-login-name))
            t t))
      '(end-of-line 1)
      " <"
      (progn user-mail-address)
      ">
;; Keywords: "
      '(require 'finder)
      '(setq v1
             (mapcar
              (lambda
                (x)
                (list
                 (symbol-name
                  (car x))))
              finder-known-keywords)
             v2
             (mapconcat
              (lambda
                (x)
                (format "%12s:  %s"
                        (car x)
                        (cdr x)))
              finder-known-keywords "
"))
      ((let
           ((minibuffer-help-form v2))
         (completing-read "Keyword, C-h: " v1 nil t))
       str ", ")
      & -2 "

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; " _ "

;;; Code:



(provide '"
      (file-name-base
       (buffer-file-name))
      ")
;;; "
      (file-name-nondirectory
       (buffer-file-name))
      " ends here
")
     (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton")
      "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename "
      (file-name-base
       (buffer-file-name))
      ".info
" "@settitle " str "
@c %**end of header
@copying
"
      (setq short-description
            (read-string "Short description: "))
      ".

" "Copyright @copyright{} "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{https://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{https://www.gnu.org/software/texinfo/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      " <"
      (progn user-mail-address)
      ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from https://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye
")))
 '(custom-safe-themes
   '("99f1f18be94a5696af764aafd61323dc814814169709936d5c0fcd66d9ba4043" "da5ec8628afa36cd5b26f9d2485aa0c52394510b821b2d045fffe258b4424657" "0c860c4fe9df8cff6484c54d2ae263f19d935e4ff57019999edbda9c7eda50b8" "acbb8fceca3c1f3a5bb68a5dd0c14b16bdbe365927a1b4d93f7c7e0eaf94e86d" "74cca8c87073390d3d7ff60b7df796eaf13ab6438ce929119e007d8142d3fd86" "eb1cada70b036c6b568a89ed262ff703703c5546456bf2eb1ff16d28dc65eeca" "4ca291db8b9aa3c4d6e4954b965b5bdc5cd0da0ac07981bf13723296ce354b02" "1d5df37116ad534de9e1d73312576bec28d688b9ad97de4ce6536083b66217a3" "e71c089f5b9fb8dff6d8dfc6047e367fc5e7d93ee8f08ecf30364223b533b18f" "94ac9ce4d7d31529f274e1cf40bc7b9a105eacac85ce1a9be453c2aaa9e74e1e" "0b31a898a828fd258a12af60e3288070f6858ebcc0210b7fb8b908c85e5fdb3a" "85eec1af5d49d4980389711294b9200461572fbfe477f038da20759e9bbf656e" "f5f8e3b1a688f8d96ac688fbb4f170f123047f33b1bc697cb2e10320e1c0e03d" "f2d57f12a352d0fb5f066c2458ac0698b57fe87c6935d439ab6d24f133b23cfc" "1e8ca0d4abbb6ca4d26a0e9812e334fee2fe6992e562616838695fb0102f1a31" "db260180afeae6b23775b6dfa6b470b61a4b247461d14f9ebc012e1064fa77b5" "4435cd9c3578a1885195d4b7cea93a0248bbef72b62b62994d012e87903cd160" "d2c79ed6ec5712549e797378a4240c150704650350cc60cb0fe35ee84efefa2d" "191b4e2ad8a5a6f2d2cd35f040472df25a0dba4ad951a8200edb0e1b1048f7df" "ca58df520c44378b6509b0e3545f5cc5b1ed6ea921db5c50ab7492df275ffb70" "4344ac5c1a6120c1edf8bc6729a76c627a4aea82edcb055957bc4a3c182cdaee" "f312b80ef5021f6f04060d00dea694afee6055c11da6b65fd77ab34762a144e5" "ddc5f7c0dd164f565a1d1e5f08ff291e73795274ef4d6388b59355466748742c" "eed447c72ea389c61cb1b9320cdaf28e4500f15e1d78a4a5419e47bb6cedd442" "7299119ddd3389cf8dd878ec0906eea7ff709b370df674babb4831a3dfad9779" "c06b9382bfb2b013278f551f8e5ad81bbfe4e1b59b646248c577cf51b4e3166f" "8fbd0de6a86bc3e4b3fa078958bd406afbd9cfb64672c680d118963b9e9ecc3d" "d4cce5845c48f9ec6e52e3094055baee0755f8e7e00b3d1d40de7612ceba4b87" "7a544661f461f24a1785b56d25c328434c57baaf2265c70af81fdf7203f3f85d" "2eabe5b82f7839eff0093ec584a966814b7ac7d312f27b3bd23e72704b020dd5" "a4c8c3023691b8461c5238475eaa29f896d932682b89a77707bfdf13485085f4" "680d7a484a610589ea9275c4cdc7d9b4eec36dd89ab1878987121daa5f92cd63" "81669db325d4793bc6c2f256e8500672ea38a5b1b3ed42c5c77e9f0c9460d362" "8715fa73f49a4d964a61a05c1952686b872dde4d8c04ac1826c94f3fd6455f81" "dff8859e99c8163d82fbbd5ce2b0042a709421efcc13a47d91301b1dd255d011" "2b0c49f0a89df85a4d5d38453d047c2bc826b6af52c4eae3cbe62c5ef89c9b02" "c10f42d25409116d1aafcc72e738d5816beef45d932c0cd55aaf7e78a9183228" "3f7645abc5fb942e4b08e1433c9be5c07e661eae1d2b742aeca2712b22874837" "0a084768e1732696e75373bb40b69b04ab1ff8eca7bea15a1cd0f3d74ff338d3" "8c97ca18f22c78f9e6bc9c3c16f1d2eb0a2203479f2f8a93cb7f185f8071e7ab" "114021f89fc722b3458aec6c1cd198b182f8e413ea6804d6a83d648a01d10983" "2714d17d890455bfaccec19947348800dd1187fba30ff748fc72d0a4806f3cda" "90163178875876f56a11cac1b88cca1694c7ccaea796f7ee77ad586c24febe9f" "b06287b3d9084f39ece0ae1858c7701dec241921f8cc0562997492354400af86" "e21bda1b85dce97c55cbecce45548e13d6af462748684829ebbb06c595bec776" "233ee8aaa54ea50efa02e65d69e7c6c474b38ed76c1a527cae4069647ee333a4" "fe5ff8fdc0d671cdccf3c1cd21637e547fc4383aec9a9bb36c5f3bd97b441d1c" "5fd89e453dba452eeefc16126a181eeed7a17fbe4592471527639a74cc9a4828" "6852214961964e9a1ed08b48d7189519cb71ee3ac761dacaec5c1224681f4b79" "eb48bc0cfef88ab2f94bbeee29d9a1ed46a472b63704ca519df0e7780e94d1d0" "beef7804bfe9143b7a0a7be0567cf607b41115d611a5781151e7ee32bc7f4fee" "b79ccccd808a46be09cc407b8a16a27098b603d06c99ae6b84af518d06d30608" "6349b974af340f5837dea169c364b028ae4070fdb8db3071dbc979989c2f2b40" "d2be14eae8368c8cd99e05853b82d017a8957403c0fe424a9389618bae376c5b" "c0a0aa10b178c7f6d3b5e9edb1adc3ea74a44e59dc68b5fcca5f62c960dc7254" "68d538cc724a613ffb47b289d66cd27cc621e601138c3b96ac1bd196ac939915" "b1ff87aa7767e6669c39bcb7e1c2ec580db0b4c308b78be8fa3ca3ff310e082e" "b619482843bd52ac467e4f83ce7bb6fd92412b2648d00b89e415b81451531742" default))
 '(package-selected-packages
   '(quelpa-use-package quelpa atom-one-dark-theme highlight-indent-guides yasnippet-snippets treemacs-all-the-icons all-the-icons dashboard pdf-tools auctex svg-lib visual-fill-column counsel ivy-rich ivy dired-single lsp-java ccls tree-sitter-langs tree-sitter ligature lsp-ui company-box js2-mode web-mode emmet-mode yasnippet flycheck company eglot lsp-mode evil hydra general which-key use-package tuareg)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
