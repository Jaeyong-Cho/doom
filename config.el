;;; $DOOMDIR/config.el

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
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 12 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "JetbrainsMono Nerd Font" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

(load-file "$HOME/.config/doom/theme/kanagawa-dragon-theme.el")
(load-file "$HOME/.config/doom/theme/kanagawa-theme.el")
(load-theme 'kanagawa t)

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
(setq org-root '"/Volumes/T7_Touch/Memo/Org")
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename org-root))
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-goto-date)
         ("C-c n t" . org-roam-dailies-goto-today))
  :config
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-capture-templates '(("d" "default" plain "%?"
                                      :target (file+head "%<notes/%Y/%m/%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n")
                                      :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y/%m/%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
  (setq org-roam-completion-everywhere t)
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol))

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
         ("C-c n N" . org-capture-goto-target))
  :config
  (setq org-agenda-files '(org-root)
        org-return-follows-link t
        org-directory org-root))

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

(use-package! org-transclusion
  :after org
  :bind (("C-c n a a" . org-transclusion-add)
         ("C-c n a t" . org-transclusion-mode)))
