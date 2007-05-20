;;; qi-mode-el -- Major mode for editing Qi files

;; Author: Michael Ilseman
;; Created: 12 May 2007
;; Keywords: Qi major-mode

;; Copyright (C) 2007 Michael Ilseman

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:
;; based on the information from the tutorial below
;; and the scheme major mode
;;
;; http://two-wugs.net/emacs/mode-tutorial.html
;; 

;;; Code:
(defvar qi-mode-hook nil)
(defvar qi-mode-map
  (let ((qi-mode-map (make-keymap)))
    (define-key qi-mode-map "\C-j" 'newline-and-indent)
    qi-mode-map)
  "Keymap for Qi major mode")

(add-to-list 'auto-mode-alist '("\\.qi\\'" . qi-mode))

(defconst qi-font-lock-keywords-1
  (list
   '("\\<define\\|datatype\\|/.\\>" . font-lock-keyword-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for Qi mode.")

(defconst qi-font-lock-keywords-2
  (append qi-font-lock-keywords-1
          (list
           '("\\<\\(true\\|false\\|number\\|list\\|boolean\\)\\>" . font-lock-constant-face)))
  "Additional Keywords to highlight in Qi mode.")

(defconst qi-font-lock-keywords-3
  (append qi-font-lock-keywords-2
          (list
           '("\\<\\(if\\|tc\\)\\>" . font-lock-function-name-face)
           '("\\<\\([A-Z]\\w*\\)\\>" . font-lock-variable-name-face)
           '("\\<where\\|:=\\|@p\\>" . font-lock-type-face)
;           '("\\<test\\>" . font-lock-comment-face)
;           '("\\<test1\\>" . font-lock-keyword-face)
;           '("\\<test2\\>" . font-lock-builtin-face)
;           '("\\<test3\\>" . font-lock-variable-name-face)
;           '("\\<test4\\>" . font-lock-type-face)
;           '("\\<test5\\>" . font-lock-constant-face)
;           '("\\<test6\\>" . font-lock-warning-face)
           ))
  "more highlighting in Qi mode.")

(defvar qi-font-lock-keywords qi-font-lock-keywords-3
  "Default highlighting expressions for Qi mode.")

;; Copied from scheme-mode, which in turn is from lisp-mode
(defun qi-indent-function (indent-point state)
  (let ((normal-indent (current-column)))
    (goto-char (1+ (elt state 1)))
    (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
    (if (and (elt state 2)
             (not (looking-at "\\sw\\|\\s_")))
        ;; car of form doesn't seem to be a symbol
        (progn
          (if (not (> (save-excursion (forward-line 1) (point))
                      calculate-lisp-indent-last-sexp))
              (progn (goto-char calculate-lisp-indent-last-sexp)
                     (beginning-of-line)
                     (parse-partial-sexp (point)
					 calculate-lisp-indent-last-sexp 0 t)))
          ;; Indent under the list or under the first sexp on the same
          ;; line as calculate-lisp-indent-last-sexp.  Note that first
          ;; thing on that line has to be complete sexp since we are
          ;; inside the innermost containing sexp.
          (backward-prefix-chars)
          (current-column))
      (let ((function (buffer-substring (point)
					(progn (forward-sexp 1) (point))))
	    method)
	(setq method (or (get (intern-soft function) 'qi-indent-function)
			 (get (intern-soft function) 'qi-indent-hook)))
	(cond ((or (eq method 'defun)
		   (and (null method)
			(> (length function) 3)
			(string-match "\\`def" function)))
	       (lisp-indent-defform state indent-point))
	      ((integerp method)
	       (lisp-indent-specform method state
				     indent-point normal-indent))
	      (method
		(funcall method state indent-point normal-indent)))))))


(defun qi-let-indent (state indent-point normal-indent)
  (skip-chars-forward " \t")
  (if (looking-at "[-a-zA-Z0-9+*/?!@$%^&_:~]")
      (lisp-indent-specform 2 state indent-point normal-indent)
    (lisp-indent-specform 1 state indent-point normal-indent)))

;; (put 'begin 'qi-indent-function 0), say, causes begin to be indented
;; like defun if the first form is placed on the next line, otherwise
;; it is indented like any other form (i.e. forms line up under first).

(put '/. 'qi-indent-function 1)
(put 'datatype 'qi-indent-function 1)
(put 'let 'qi-indent-function 'qi-let-indent)

(defvar qi-mode-syntax-table
  (let ((qi-mode-syntax-table (make-syntax-table)))
	
                                        ; This is added so entity names with underscores can be more easily parsed
    (modify-syntax-entry ?\\ "! " qi-mode-syntax-table)
    qi-mode-syntax-table)
  "Syntax table for qi-mode")
  
(defun qi-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map qi-mode-map)
  (set-syntax-table qi-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(qi-font-lock-keywords))
  ;; Register our indentation function
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'lisp-indent-line)
  (make-local-variable 'comment-indent-function)
  (setq comment-indent-function 'lisp-comment-indent)
  (make-local-variable 'lisp-indent-function)
  (set lisp-indent-function 'qi-indent-function)
  (setq major-mode 'qi-mode)
  (setq mode-name "Qi")
  (run-hooks 'qi-mode-hook))

(provide 'qi-mode)

;;; qi-mode.el ends here





