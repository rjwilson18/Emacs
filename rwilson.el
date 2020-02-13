
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 Manage Packages                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up repos and ensure desired files are installed
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

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
 'undo-tree
 'ace-jump-mode
 'ess
 'ess-R-data-view
 'helm
 'xkcd
 'magit
 'powershell
 'htmlize
 'iedit
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    Submode Hooks                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Define almost-universal rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'text-mode-hook 'rainbow-delimiters-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Python                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Did not need on this machine, but needed on work vdi
;;(setq python-shell-interpreter "Full path to python.exe")

;;Restart Python function
(defun restart-python-console ()
  "Restart python console before evaluate buffer or region to avoid various uncanny conflicts, like not reloding modules even when they are changed"
  (interactive)
  (kill-process "Python")
  (sleep-for 0.05)
  (kill-buffer "*Python*")
  (run-python)
  (switch-to-buffer "*Python*")
  )
;;Assign Hotkey
(global-set-key (kbd "C-x C-p") 'restart-python-console)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Magit                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x g") 'magit-status)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Abbreviations Handler                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default abbrev-mode t) ;;gloablly set abbreviation mode on
(setq abbrev-file-name "c:/users/dickw/documents/emacs/abbreviations") ;;store abbreviations here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Org Mode                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(org-babel-do-load-languages
 'org-bable-load-languages
 '(
   (python . t)
   (shell . t)
   (sql . t)
   )
 )
