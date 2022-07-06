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
(package-initialize)

;; Set exec-path
;; (when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

;; Pacakges to ensure are installed
(ensure-package-installed
 'rainbow-delimiters
 'xkcd
 'magit
 'powershell
 'htmlize
 'yasnippet
 'org-download
 'ssh
 'tramp
 'humanoid-themes
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Load Common Init File                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-file "C:/Users/rxw064/Documents/emacs/Emacs/rw_common.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Abbreviations Yas Handler            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set global abbrev mode and file location
(setq-default abbrev-mode t) ;;gloablly set abbreviation mode on
(setq abbrev-file-name "C:/Users/rxw064/Documents/emacs/Emacs/abbreviations") ;;store abbreviations here

;;set yas directory and turn snippets on
(yas-global-mode 1) ;;Globally turn yas mode on
(yas-load-directory "C:/Users/rxw064/Documents/emacs/Emacs/mysnippets")
(setq yas-snippet-dirs '("C:/Users/rwilso14/Documents/emacs/Emacs/mysnippets"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        DOT                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;This overwrites a function in ob-dot.el to modify the command to call dot
;;I had to do this because I can't edit the PATH variables on my work machine.

(defun org-babel-execute:dot (body params)
  "Execute a block of Dot code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((out-file (cdr (or (assq :file params)
			    (error "You need to specify a :file parameter"))))
	 (cmdline (or (cdr (assq :cmdline params))
		      (format "-T%s" (file-name-extension out-file))))
	 (cmd (or (cdr (assq :cmd params)) "C:/Users/rwilso14/Documents/graphviz/bin/dot.exe"))
	 (in-file (org-babel-temp-file "dot-")))
    (with-temp-file in-file
      (insert (org-babel-expand-body:dot body params)))
    (org-babel-eval
     (concat cmd 
	     " " (org-babel-process-file-name in-file)
	     " " cmdline
	     " -o " (org-babel-process-file-name out-file)) "")
    nil)) ;; signal that output has already been written to file

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
     (dot . t)
    )
  )
)

;; Drag-and-drop to `dired`, used for copy/pasting images/files into org
(require 'org-download)
(add-hook 'dired-mode-hook 'org-download-enable)

;; Add TODO keywords and Customize their appearance
(setq org-todo-keywords
      '((sequence "TODO" "QUESTION" "BLOCKED" "|" "DONE" "CANCELLED" "DELEGATED")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
	("QUESTION" . "yellow")
	("BLOCKED" . "red")
        ("CANCELLED" . (:foreground "blue" :weight bold))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        GnuGP                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 '(epg-gpg-home-directory "c:/Users/rxw064/AppData/Roaming/gnupg")
 '(epg-gpg-program "C:/Program Files (x86)/gnupg/bin/gpg.exe")
 '(epg-gpgconf-program "c:/Program Files (x86)/gnupg/bin/gpgconf.exe")
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Misc.                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set theme
(load-theme 'humanoid-dark t)


