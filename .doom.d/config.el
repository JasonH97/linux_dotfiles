;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-snazzy)
;;(setq doom-theme 'doom-badger)
;;(setq doom-theme 'doom-rouge)
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-monokai-classic)
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



; Open Emacs in fullscreen mode
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Match colors I set for gnome & qutebrowser
;;(set-background-color "#282828")

;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(ansi-color-faces-vector
;;   [default default default italic underline success warning error])
;; '(custom-enabled-themes '(tango-dark))
;; '(ispell-dictionary nil)
;; '(max-mini-window-height 16)
;; '(package-selected-packages
;;   '(paredit slime clojure-mode-extra-font-locking csv-mode evil)))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )

;;(require 'package)
;;;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;;;; and `package-pinned-packages`. Most users will not need or want to do this.
;;;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;
;;;; https://stackoverflow.com/questions/7273589/setting-up-slime-inferior-lisp-for-clojure-in-emacs
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(package-initialize)
;;
;;;; from https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
;;(setq package-selected-packages '(clojure-mode lsp-mode cider lsp-treemacs flycheck company))
;;
;;(when (cl-find-if-not #'package-installed-p package-selected-packages)
;;  (package-refresh-contents)
;;  (mapc #'package-install package-selected-packages))

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)

;;(setq gc-cons-threshold (* 100 1024 1024)
;;      read-process-output-max (* 1024 1024)
;;      treemacs-space-between-root-nodes nil
;;      company-minimum-prefix-length 1
;;      ; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
;;      ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
;;      )


;; generated by throwing my .vimrc at chatGPT and asking for emacs
;; Install use-package if not found
;;(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
;;  (package-install 'use-package))

;;(require 'use-package)

;;;; Smooth scrolling
;;(use-package smooth-scroll
;;  :ensure t)

;;;; Rainbow Delimiters
;;(use-package rainbow-delimiters
;;  :ensure t)
;;(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Gruvbox theme (if you want to use it, uncomment the following lines)
;; (use-package gruvbox-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruvbox t))

;; EditorConfig support (if you want to use it, uncomment the following lines)
;; (use-package editorconfig
;;   :ensure t
;;   :config
;;   (editorconfig-mode 1))

;; Set 'nocompatible'
;;(setq-default evil-ex-search-case 'sensitive)
;;(setq-default evil-search-module 'evil-search)

;; Enable syntax highlighting
(global-font-lock-mode t)

;; Enable line numbers
(global-display-line-numbers-mode t)

;; Enable 'smartcase' for search
(setq-default case-fold-search nil)

;; Allow backspacing over autoindent, line breaks, and start of insert action
(setq-default backward-delete-char-untabify-method nil)

;; Auto-indent when opening a new line
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Display the cursor position in the mode line
(column-number-mode t)

;; Always display the status line
(setq-default evil-modeline-height 20)
;(evil-modeline-mode t)  ; Symbol's function definition is void: evil-modeline-mode

;; Instead of failing a command because of unsaved changes, raise a dialogue to save
(setq-default confirm-nonexistent-file-or-buffer nil)

;; Use visual bell instead of beeping
(setq-default visible-bell t)
(setq-default ring-bell-function 'ignore)

;; Enable mouse support
(setq-default mouse-wheel-follow-mouse t)
(setq-default mouse-wheel-progressive-speed nil)
(setq-default mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Set the command window height to 2 lines
(setq-default resize-mini-windows t)
(setq-default max-mini-window-height 2)

;; Quickly time out on keycodes, but never time out on mappings
(setq-default echo-keystrokes 0.1)
(setq-default use-dialog-box nil)
(setq-default ring-bell-function 'ignore)

;; Set indentation settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Set file format to Unix
(setq-default buffer-file-coding-system 'utf-8-unix)

;; Automatically remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Make search case-insensitive by default
(setq-default case-fold-search t)

;; Enable line numbering
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width 3)
(setq-default display-line-numbers-type 'relative)

;; Highlight search matches while searching
(setq-default lazy-highlight-initial-delay 0)
(setq-default lazy-highlight-max-at-a-time nil)
(setq-default lazy-highlight-cleanup nil)
(add-hook 'isearch-mode-hook (lambda () (setq-default lazy-highlight-cleanup nil)))

;; Enable spellcheck (uncomment the following line if you want spellcheck)
;; (setq-default ispell-program-name "aspell")
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Enable hybrid line numbers (line numbers for the current line, relative line numbers)
(setq-default display-line-numbers-type 'visual)
(global-visual-line-mode t)
(setq-default linum-relative-current-symbol "")

;; Highlight the 80th column
(setq-default whitespace-style '(face lines-tail))
(setq-default whitespace-line-column 80)
(global-whitespace-mode t)

;; Set color scheme (you can replace 'atom-one-dark' with your preferred theme)
;;(use-package atom-one-dark-theme
;;  :ensure t
;;  :config
;;  (load-theme 'atom-one-dark t))

;; Automatically remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Make search case-insensitive by default
(setq-default case-fold-search t)
(setq-default isearch-case-fold-search t)

;; Enable spellcheck
;; (setq-default ispell-program-name "aspell")
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)


;; more from chatGPT

;; Set the default directory to your home directory
(setq default-directory "~/")

;; Disable the welcome screen
;(setq inhibit-startup-screen t)

;; Display a list of files in the current directory (your home directory)
;(require 'dired)
;(defun my/open-home-directory ()
;  (interactive)
;  (dired default-directory))


;; https://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;;; https://www.emacswiki.org/emacs/TransparentEmacs
;(set-frame-parameter (selected-frame) 'alpha 90)
;(defun setTransparency (value)
;  (interactive "nTransparency Value 0 - 100 opaque:")
;  (set-frame-parameter (selected-frame) 'alpha value))

;; https://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 175)

;; resize bottom-prompt to stretch to fit text
(setq resize-mini-windows t)


;; https://emacs.stackexchange.com/questions/74916/changing-comment-delimiter-colour
(set-face-attribute 'font-lock-comment-face nil :foreground "#666699")
;(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "#666699")


;; https://yewtu.be/watch?v=51eSeqcaikM
;; remember recently edited files to quickly access later with `recentf-mode` instead of `find-file`
;; `M-x recentf-open-files` lists recently-edited files. Not bound to key by default but should be!
(recentf-mode 1)
(global-set-key "\C-xf" 'recentf-open-files)


;; Remember and restore the last cursor location of opened files
(save-place-mode 1)


;; Disable GUI dialogue prompts where relevant
(setq use-dialog-box nil)


;; Refresh buffer when file is changed outside of emacs
(global-auto-revert-mode 1)
;; Ditto for non-file buffers
(setq global-auto-revert-non-file-buffers t)
