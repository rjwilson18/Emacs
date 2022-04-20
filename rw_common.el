;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    Submode Hooks                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Define almost-universal rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'text-mode-hook 'rainbow-delimiters-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 Custom Functions                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Adds a string to the end of each line in a region
(defun add-string-to-end-of-lines-in-region (str b e)
  "prompt for string, add it to end of lines in the region"
  (interactive "sString to append \nr")
  (goto-char e)
  ;;(forward-line -1) causing first line to miss i think
  (while (> (point) b)
    (end-of-line)
    (insert str)
    (forward-line -1)))

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
;;                        Misc.                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; alias yes/no y/n
(defalias 'yes-or-no-p 'y-or-n-p)
;; global line numbers
(global-linum-mode t)
;;enable normally disabled functions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;;turn off electric indent mode 
(electric-indent-mode -1)
