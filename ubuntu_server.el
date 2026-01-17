
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 Manage Packages                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up repos and ensure desired files are installed
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
;;(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
;;(package-initialize)

;; Set exec-path
;; (when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

;; Pacakges to ensure are installed
(ensure-package-installed
 'rainbow-delimiters
 'magit
 'yasnippet
 'org-download
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Load Common Init File                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq emacs-repo-dir "~/repos/Emacs/")
(load-file (expand-file-name "rw_common.el" emacs-repo-dir))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             Abbreviations & Yas Handler            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set global abbrev mode and file location
(setq-default abbrev-mode t) ;;gloablly set abbreviation mode on
(setq abbrev-file-name  (expand-file-name "abbreviations" emacs-repo-dir)) ;;store abbreviations here

;;set yas directory and turn snippets on
(yas-global-mode 1) ;;Globally turn yas mode on
(setq yas-snippets-dir (concat emacs-repo-dir "mysnippets"))
(yas-load-directory yas-snippets-dir)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Org Mode                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(org-babel-do-load-languages
 'org-babel-load-languages
   (quote
    (
     (sql . t)
     (python . t)
     (shell . t)
    )
  )
   )
