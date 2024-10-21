;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
(package! autothemer
  :recipe (:host github :repo "jasonm23/autothemer"))

(package! consult-tramp
  :recipe (:host github :repo "Ladicle/consult-tramp"))

(package! yasnippet)

(package! lsp-bridge
  :recipe (:type git :host github :repo "manateelazycat/lsp-bridge"
                 :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
                 :build (:not compile)))

(unless (display-graphic-p)
  (package! popon
    :recipe (:host nil :repo "https://codeberg.org/akib/emacs-popon.git"))
  (package! acm-terminal
    :recipe (:host github :repo "twlz0ne/acm-terminal")))

(package! sublimity
  :recipe (:host github :repo "zk-phi/sublimity"))

(package! general
  :recipe (:host github :repo "noctuid/general.el"))

(package! evil-tmux-navigator
  :recipe (:host github :repo "keith/evil-tmux-navigator"))

(unpin! org-roam)
(package! org-roam
  :recipe (:host github :repo "org-roam/org-roam"))
(package! org-roam-ui
  :recipe (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out")))
(unpin! org-journal)
(package! org-journal
  :recipe (:host github :repo "bastibe/org-journal"))
(package! websocket
  :recipe (:host github :repo "ahyatt/emacs-websocket"))
(unpin! org-appear)
(package! org-appear
  :recipe (:host github :repo "awth13/org-appear"))
(unpin! org-superstar)
(package! org-superstar
  :recipe (:host github :repo "integral-dw/org-superstar-mode"))
(unpin! org-transclusion)
(package! org-transclusion
  :recipe (:host github :repo "nobiot/org-transclusion"))
(package! org-static-blog
  :recipe (:host github :repo "bastibe/org-static-blog"))
(package! ob-d2
  :recipe (:host github :repo "xcapaldi/ob-d2"))
(package! org-drill)
(package! org-fc)
(package! org-download)

(package! emacs-window-layout
  :recipe (:host github :repo "kiwanami/emacs-window-layout"))

(package! evil-god-state
  :recipe (:host github :repo "gridaphobe/evil-god-state"))

(package! centered-window-mode
  :recipe (:host github :repo "anler/centered-window-mode"))

(package! lsp-grammarly
  :recipe (:host github :repo "emacs-grammarly/lsp-grammarly"))

(package! prescient
  :recipe (:host github :repo "radian-software/prescient.el"))

(package! emacs-refactor
  :recipe (:host github :repo "Wilfred/emacs-refactor"))

(package! perfect-margin
  :recipe (:host github :repo "mpwang/perfect-margin"))

(package! d2-mode
  :recipe (:host github :repo "andorsk/d2-mode"))

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;  :recipe (:host github :repo "username/repo"
;;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
