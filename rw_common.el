(defun add-string-to-end-of-lines-in-region (str b e)
  "prompt for string, add it to end of lines in the region"
  (interactive "sString to append \nr")
  (goto-char e)
  ;;(forward-line -1) causing first line to miss i think
  (while (> (point) b)
    (end-of-line)
    (insert str)
    (forward-line -1)))
