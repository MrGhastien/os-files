;;; cml-faces.el --- Faces for the custom mode line  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  

;; Author:  <mrghastien@pc-raclette>
;; Keywords: faces, frames

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

;; faces.

;;; Code:

(defface cml-modeline-default nil
  "Default face for the mode line"
  :group 'cml)

(defface cml-modeline-secondary '((t . (:inherit cml-modeline-default)))
  "Face for secondary text on the mode line"
  :group 'cml)

(defface cml-modeline-primary '((t . (:inherit cml-modeline-default)))
  "Face for primary text on the mode line.
   Primary text includes the buffer name."
  :group 'cml)


(provide 'cml-faces)
;;; cml-faces.el ends here
