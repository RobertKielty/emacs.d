;;; package --- Summary
;;; commentary:
;;; code:
(setq user-mail-address "rkielty@rokitds.com")
(set-language-environment "Latin-1")

(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)

(global-set-key (kbd "C-x g") 'magit-status)
(menu-bar-mode 1)
(tool-bar-mode -1)
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; Adding Melpa repo
(require 'package)
(add-to-list 'package-archives
         '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(show-paren-mode 1)
;; web-mode

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-hook 'web-mode-hook
      (lambda ()
        ;; short circuit js mode and just do everything in jsx-mode
        (if (equal web-mode-content-type "javascript")
            (web-mode-set-content-type "jsx")
          (message "now set to: %s" web-mode-content-type))))

(defvar web-mode-content-type)
(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property))
	("html" . (ac-source-words-in-buffer ac-source-abbrev))))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)
(require 'yasnippet)


(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))
;; tern
(add-to-list 'load-path "~/.emacs.d/packages/")
(autoload 'tern-mode "tern.el" nil t)

;; Customizations that were placed in ~/.emacs
;; I have elected to not use ~/.emacs in favour of init.el
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (auto-complete charmap circe circe-notifications groovy-mode hackernews multiple-cursors yasnippet web-mode paredit orgtbl-show-header orgit org-tree-slide markdown-preview-mode json-mode js2-mode flycheck exec-path-from-shell dockerfile-mode company-web company-tern))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init)
;;; init.el ends here


