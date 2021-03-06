(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backup"))))
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(global-ede-mode t)
 '(ido-mode (quote buffer) nil (ido))
 '(indent-tabs-mode nil)
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(savehist-mode t)
 '(semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-mode t)
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Ensure installed

(defvar packages
  '(ido
    malabar-mode
    flycheck
    clojure-mode
    midje-mode
    cider
    paredit
    rhtml-mode
    rinari))

(defun packages-installed-p ()
  (if (remove-if 'package-installed-p packages)
      nil
    t))

(defun packages-install ()
  (dolist (package packages)
    (when (not (package-installed-p package))
      (package-install package))))

;; Env
(when (not (getenv "TERM_PROGRAM"))
    (setenv "PATH" (shell-command-to-string "source $HOME/.bashrc && printf $PATH"))
    (setq exec-path (split-string (getenv "PATH") ":")))

;; Malabar
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(add-hook 'malabar-mode-hook 'flycheck-mode)
(add-hook 'malabar-mode-hook
     (lambda () 
       (add-hook 'after-save-hook 'malabar-compile-file-silently
                  nil t)))

;; Cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; Midje
(add-hook 'clojure-mode-hook 'midje-mode)

;; Paredit
(autoload 'paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook                  'paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'paredit-mode)
(add-hook 'ielm-mode-hook                        'paredit-mode)
(add-hook 'lisp-mode-hook                        'paredit-mode)
(add-hook 'lisp-interaction-mode-hook            'paredit-mode)
(add-hook 'scheme-mode-hook                      'paredit-mode)
(add-hook 'clojure-mode-hook                     'paredit-mode)
(add-hook 'cider-repl-mode-hook                  'paredit-mode)

;; Ruby
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))
(add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

;;; After init
(defun after-init ()
  ; Ensure installed
  (package-initialize)
  (require 'cl)
  (when (not (packages-installed-p))
    (package-refresh-contents)
    (packages-install))
  ; Malabar
  (require 'malabar-mode)
  (malabar-abbrevs-setup))
(add-hook 'after-init-hook 'after-init)
