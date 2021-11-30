(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" default))
 '(doom-modeline-enable-word-count t)
 '(warning-suppress-log-types
   '((lsp-on-idle-hook)
     (dap-breakpoints-changed-hook)
     (lsp-after-open-hook)))
 '(warning-suppress-types '((dap-breakpoints-changed-hook) (lsp-after-open-hook))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun nxml-where ()
        "Display the hierarchy of XML elements the point is on as a path."
        (interactive)
        (let ((path nil))
        (save-excursion
                (save-restriction
                (widen)
                (while (and (< (point-min) (point)) ;; Doesn't error if point is at beginning of buffer
                        (condition-case nil
                                (progn
                                (nxml-backward-up-element) ; always returns nil
                                t)
                                (error nil)))
                (setq path (cons (xmltok-start-tag-local-name) path)))
                (if (called-interactively-p t)
                (message "/%s" (mapconcat 'identity path "/"))
                (format "/%s" (mapconcat 'identity path "/")))))))


(defun xml-find-file-hook ()
  (when (derived-mode-p 'nxml-mode)
    (which-function-mode t)
    (setq which-func-mode t)
    (add-hook 'which-func-functions 'nxml-where t t)))

(add-hook 'find-file-hook 'xml-find-file-hook t)
