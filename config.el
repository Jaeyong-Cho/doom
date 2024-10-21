;;; $DOOMDIR/config.el

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after mmail
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
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 14 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "JetbrainsMono Nerd Font" :size 14))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

(load-file "$HOME/.config/doom/theme/office-theme.el")
(load-file "$HOME/.config/doom/theme/kanagawa-theme.el")
(load-file "$HOME/.config/doom/theme/kanagawa-dragon-theme.el")
(load-file "$HOME/.config/doom/theme/kanagawa-lotus-theme.el")
(load-theme 'kanagawa-dragon t)

(set-frame-parameter nil 'alpha-background 70) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 70)) ; For all new frames henceforth

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

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

;; Smooth Scroll
(require 'sublimity)
(require 'sublimity-scroll)
(sublimity-mode 1)
(setq sublimity-scroll-weight 10
      sublimity-scroll-drift-length 5
      sublimity-scroll-vertical-frame-delay 0.01)

(pixel-scroll-mode 1)
(setq pixel-scroll-precision-mode t)

(edt-set-scroll-margins "15%" "15%")

(add-to-list 'default-frame-alist '(undecorated-round . t))

;; Indent Guide
;; (use-package highlight-indent-guides
;;   :hook (prog-mode . highlight-indent-guides-mode)
;;   :config
;;   (setq highlight-indent-guides-method 'character)
;;   (setq highlight-indent-guides-responsive 'stack))

(require 'navigate)

;; lsp
(setq lsp-inlay-hint-enable nil)
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (require 'yasnippet)
;;             (yas-global-mode 1)

;;             (require 'lsp-bridge)
;;             (global-lsp-bridge-mode)

;;             (unless (display-graphic-p)
;;               (with-eval-after-load 'acm
;;                 (require 'acm-terminal)))))

(use-package lsp-mode
  :hook ((prog-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (progn
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "pylp")
                      :major-modes '(python-mode)
                      :remote? t
                      :server-id 'pylp-remote))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "pylsp")
                      :major-modes '(python-mode)
                      :remote? t
                      :server-id 'pylsp-remote))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "pyright")
                      :major-modes '(python-mode)
                      :remote? t
                      :server-id 'pyright-remote))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                      :major-modes '(c-mode c++-mode)
                      :remote? t
                      :server-id 'clangd-remote))))

(setq lsp-idle-delay 0.001)

;; dashboard
(setq fancy-splash-image "~/.doom.d/splash/doom-emacs-color.png")

;; window
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;; org-roam
(setq org-root '"/Users/jaeyong/Org")
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename org-root))
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-goto-date)
         ("C-c n t" . org-roam-dailies-goto-today))
  :config
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-capture-templates '(("d" "default" plain "%?"
                                      :target (file+head "%<notes/%Y/%m/%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n#+filetags:\n\n* ${title}\n\n * Todo\n- [[~/Org/Todo.org][Todo]]")
                                      :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y/%m/%d>.org"
                            "#+title: %<%Y-%m-%d>\n\n"))))
  (setq org-roam-completion-everywhere t)
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol))

(use-package ob-d2
  :ensure t)

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;         :hook (after-init . org-roam-ui-mode)
    :bind (("C-c n o" . org-roam-ui-open)
           ("C-c n z" . org-roam-ui-zoom)
           ("C-c n l" . org-roam-ui-local))
    :init (when (featurep 'xwidget-internal)
            (setq org-roam-ui-browser-function #'xwidget-webkit-browse-url))
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil))

(use-package! org
  :bind (("C-c n n" . org-capture)
         ("C-c n N" . org-capture-goto-target)
         ("C-c n g" . org-tags-view))
  :after ob-d2
  :config
  (custom-set-variables
   '(org-agenda-files (concat org-root "/todo.org")))
  (setq org-return-follows-link t
        org-directory org-root
        org-babel-load-languages '(plantuml t)
        org-hide-emphasis-markers t
        org-hide-block-startup t
        org-agenda-inhibit-startup t)
  (org-babel-do-load-languages 'org-babel-load-languages '((d2 . t))))

(add-hook 'org-mode-hook '(lambda () (setq fill-column 100)))
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package! org-appear
  :config
  (setq org-appear-trigger 'manual)
  (add-hook 'org-mode-hook (lambda ()
                             (add-hook 'evil-insert-state-entry-hook
                                       #'org-appear-manual-start
                                       nil
                                       t)
                             (add-hook 'evil-insert-state-exit-hook
                                       #'org-appear-manual-stop
                                       nil
                                       t))))

(use-package! org-journal
  :bind (("C-c n w" . org-journal-open-current-journal-file)
         ("C-c n a n" . org-journal-new-entry))
  :config
  (setq org-journal-dir (concat org-root "/daily"))
  (setq org-journal-file-format "%Y/%m/W%V.org")
  (setq org-journal-date-format "%A, %Y %m %d")
  (setq org-journal-file-type 'weekly)
  (setq org-journal-file-header "#+title: %Y-%m-W%V \n\n* Weekly Todo\n"))

(add-hook 'org-journal-after-header-create-hook 'org-create-new-id-journal)
(defun org-create-new-id-journal ()
  (goto-char (point-min))
  (org-id-get-create)
  (goto-char (point-max)))

(use-package! org-transclusion
  :after org
  :bind (("C-c n a a" . org-transclusion-add)
         ("C-c n a t" . org-transclusion-mode)))

(use-package! org-drill
  :config
  (setq org-drill-spaced-repetition-algorithm 'sm2)
  (setq org-drill-adjust-intervals-for-early-and-late-repetitions-p t)
  (setq org-drill-learn-fraction 0.2))

(use-package! org-fc
  :after org
  :init
  (evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-flip-mode
    (kbd "RET") 'org-fc-review-flip
    (kbd "n") 'org-fc-review-flip
    (kbd "s") 'org-fc-review-suspend-card
    (kbd "q") 'org-fc-review-quit)
  (evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-rate-mode
    (kbd "a") 'org-fc-review-rate-again
    (kbd "h") 'org-fc-review-rate-hard
    (kbd "g") 'org-fc-review-rate-good
    (kbd "e") 'org-fc-review-rate-easy
    (kbd "s") 'org-fc-review-suspend-card
    (kbd "q") 'org-fc-review-quit)
  :bind (("C-c f a" . org-fc-review)
         ("C-c f 0" . org-fc-review-rate-again)
         ("C-c f 1" . org-fc-review-rate-hard)
         ("C-c f 2" . org-fc-review-rate-good)
         ("C-c f 3" . org-fc-review-rate-easy)
         ("C-c f f" . org-fc-review-flip)
         ("C-c f d" . org-fc-dashboard)
         ("C-c f t" . org-fc-type-normal-init)))

(use-package! org-download
  :config
  (setq org-download-screenshot-method "screencapture -i %s")
  :bind
  (("C-c f y" . org-download-screenshot)))

(use-package! company
  :config
  (setq company-idle-delay 0))

(use-package! lsp-grammarly
  :hook (org-mode . (lambda () (require 'lsp-grammarly) (lsp))))

(use-package! lsp-ui
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-cursor t))

(use-package! perfect-margin
  :bind (("C-c m m" . perfect-margin-mode)
         ("C-c m v" . visual-line-mode))
  :init
  (visual-line-mode 1)
  :config
  (setq perfect-margin-visible-width 150))

(use-package! d2-mode
  :config
  (setq d2-output-format ".svg"))

(defvar d2-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'd2-compile)
    (define-key map (kbd "C-c C-f") 'd2-compile-file)
    (define-key map (kbd "C-c C-b") 'd2-compile-buffer)
    (define-key map (kbd "C-c C-r") 'd2-compile-region)
    (define-key map (kbd "C-c C-h") 'd2-compile-file-and-browse)
    (define-key map (kbd "C-c C-j") 'd2-compile-buffer-and-browse)
    (define-key map (kbd "C-c C-k") 'd2-compile-region-and-browse)
    (define-key map (kbd "C-c C-o") 'd2-open-browser)
    (define-key map (kbd "C-x C-o") 'd2-view-current-svg)
    (define-key map (kbd "C-c C-d") 'd2-open-doc)
    map))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :hook (org-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-f" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))
