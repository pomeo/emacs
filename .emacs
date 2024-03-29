;; Define the load path
(setq load-path (cons "~/Dropbox/emacs/.emacs.d/" load-path))

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/themes/")
(require 'color-theme-oblivion)
(color-theme-oblivion)

;; Turn off the toolbar
(tool-bar-mode -1)

;; Turn off the menu bar
(menu-bar-mode -1)

;; Turn off the scrollbar
(scroll-bar-mode -1)

;; Show column number in modeline
(setq column-number-mode t)

;; Comment style
(setq comment-style 'multi-line)

;; Always flash for parens and define a more distinctive color
(show-paren-mode 1)

;; Answer y or n instead of yes or no at prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; Encoding
(setq file-name-coding-system 'utf-8)

;; Spell checking
(setq-default ispell-program-name "aspell"
  ispell-extra-args '("--sug-mode=ultra"))
(setq-default ispell-dictionary "en_US")

;; Default Web Browser
(setq browse-url-browser-function 'browse-url-chromium)

;; Save after a certain amount of time.
(setq auto-save-timeout 1800)

;; Change backup behavior to save in a specified directory
(setq backup-directory-alist '(("." . "~/Dropbox/emacs/.emacs.d/saves/"))
 backup-by-copying      t
 version-control        t
 delete-old-versions    t
 kept-new-versions      6
 kept-old-versions      2
)

;; Start scrolling when 2 lines from top/bottom
(setq scroll-margin 5)

;; Fix the scrolling on jumps between windows
(setq scroll-conservatively 5)

;; Cursor in same relative row and column during PgUP/DN
(setq scroll-preserve-screen-position t)

;; Reload or edit .emacs on the fly
;;    - key bindings defined below
;;
(defun aic-reload-dot-emacs ()
  "Reload user configuration from .emacs"
  (interactive)
  ;; Fails on killing the Messages buffer, workaround:
  (get-buffer-create "*Messages*")
  (load-file "~/.emacs")
)
(defun aic-edit-dot-emacs ()
  "Edit user configuration in .emacs"
  (interactive)
  (find-file "~/.emacs")
)

;; Kill all buffers except scratch
(defun aic-nuke-all-buffers ()
  "Kill all buffers, leaving *scratch* only."
  (interactive)
  (mapcar (lambda (x) (kill-buffer x)) (buffer-list))
  (delete-other-windows)
)

(defalias 'nuke 'aic-nuke-all-buffers)

;; Reload or edit .emacs as defined above
(global-set-key "\C-c\C-r" 'aic-reload-dot-emacs)
(global-set-key "\C-c\C-e" 'aic-edit-dot-emacs)

(require 'windows)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
(require 'revive)
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "F" 'resume)
(define-key ctl-x-map "K" 'wipe)

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/Dropbox/emacs/.emacs.d/yasnippet-0.6.1c/snippets")
(global-set-key (kbd "s-z") 'yas/expand)

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/gh.el")
(require 'gist)

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/magit")
(require 'magit)

(require 'tumble)
;;(setq tumble-email "name@gmail.com")
;;(setq tumble-password "password")
;;(setq tumble-url "")
;;(setq tumble-group "")
;;(setq tumble-format "html")

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/Dropbox/emacs/.emacs.d/auto-complete-1.3.1/dict")
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-start t)
(setq ac-delay 0.1)
(setq ac-auto-show-menu nil)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-trigger-key nil)
(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)

;;(require 'textmate)
;;(tm/initialize)

(require 'sws-mode)
(require 'stylus-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(load "~/Dropbox/emacs/.emacs.d/nxhtml/autostart.el")
(fset 'xml-mode 'nxhtml-mode)
(fset 'html-mode 'nxhtml-mode)
(add-hook 'nxml-mode-hook
          (lambda () (rng-validate-mode nil t)))

(require 'org-install)
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;; Settings
(setq org-directory "~/Dropbox/Org/")
;; Misc
(setq org-log-done t)
(setq org-completion-use-ido t)
(setq org-return-follows-link t)

;; Files that are included in org-mode agenda
(setq org-agenda-files
 (list "~/Dropbox/Org/tasks.org")
)

(setq org-combined-agenda-icalendar-file "~/Dropbox/Org/org.ics")
(org-export-icalendar-combine-agenda-files)

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/remember")
(require 'remember)
(org-remember-insinuate)
;; Notes file
(setq org-default-notes-file (concat org-directory "~/Dropbox/Org/notes.org"))
;; Notes templates
(setq org-remember-templates
 '(("Note" ?n   "* NOTE %?\n %i\n %a" "~/Dropbox/Org/notes.org" "Notes")
   ("Download" ?d "* DL %?\n %i\n %a" "~/Dropbox/Org/download.org" "Download")
   ("Music" ?m "* MUSIC %?\n %i\n %a" "~/Dropbox/Org/music.org" "Music")
   ("Idea" ?i "* %^{Title}\n %i\n %a" "~/Dropbox/Org/brainstorm.org" "Brainstorm")))

;; Remember frames
;;   - $ emacsclient -e '(make-remember-frame)'
;;
;; Org-remember splits windows, force it to a single window
(add-hook 'remember-mode-hook  'delete-other-windows)

;; Automatic closing of remember frames
(defadvice remember-finalize (after delete-remember-frame activate)
  "Advise remember-finalize to close the frame if it is the remember frame"
  (if (equal "*Remember*" (frame-parameter nil 'name))
    (delete-frame))
)
(defadvice remember-destroy (after delete-remember-frame activate)
  "Advise remember-destroy to close the frame if it is the remember frame"
  (if (equal "*Remember*" (frame-parameter nil 'name))
    (delete-frame))
)

;; Initialization of remember frames
(defun make-remember-frame ()
  "Create a new frame and run org-remember"
  (interactive)  
  (make-frame '((name . "*Remember*") (width . 80) (height . 10)))
  (select-frame-by-name "*Remember*")
  (org-remember)
)

;; update agenda file after changes to org files
(defun th-org-mode-init ()
  (add-hook 'after-save-hook 'th-org-update-agenda-file t t))

(add-hook 'org-mode-hook 'th-org-mode-init)

;; that's the export function
(defun th-org-update-agenda-file (&optional force)
  (interactive)
  (save-excursion
    (save-window-excursion
      (let ((file "/tmp/org-agenda.txt"))
        (org-agenda-list)
        (org-write-agenda file)))))

;; do it once at startup
(th-org-update-agenda-file t)

;; Calendar settings
;
(setq
  holidays-in-diary-buffer               t
  mark-holidays-in-calendar              t
  all-christian-calendar-holidays        t
  all-islamic-calendar-holidays        nil
  all-hebrew-calendar-holidays         nil
  european-calendar-style                t
  display-time-day-and-date            nil
  calendar-latitude                  55.45
  calendar-longitude                 37.36
  calendar-location-name "Moscow, Russia"
)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(require 'zencoding-mode)
(add-hook 'nxhtml-mode-hook 'zencoding-mode)

(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(autoload 'css-color-mode "css-color" "" t)
(css-color-global-mode t)

(require 'bar-cursor)
(bar-cursor-mode t)

(setq scroll-step 1)
(global-hl-line-mode 1)

(windmove-default-keybindings 'meta)

(set-default-font "Terminus-12")
(add-to-list 'default-frame-alist '(font . "Terminus-12"))

(fringe-mode 0)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)

(define-key global-map (kbd "RET") 'newline-and-indent)

(add-to-list 'load-path "~/Dropbox/emacs/.emacs.d/tramp")
(require 'tramp)
(setq tramp-default-method "scp")

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; (defun auto-reload-firefox-on-after-save-hook ()         
;;           (add-hook 'after-save-hook
;;                        '(lambda ()
;;                           (interactive)
;;                           (comint-send-string (inferior-moz-process)
;;                                               "setTimeout(BrowserReload(), \"1000\");"))
;;                        'append 'local)) ; buffer-local

;; (add-hook 'nxhtml-mode-hook 'auto-reload-firefox-on-after-save-hook)
;; (add-hook 'css-mode-hook 'auto-reload-firefox-on-after-save-hook)

;; (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;; (add-hook 'javascript-mode-hook 'javascript-custom-setup)
;; (defun javascript-custom-setup ()
;;   (moz-minor-mode 1))

(add-hook 'after-init-hook
          '(lambda () (setq debug-on-error nil)))

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 100)
                (file-name-history        . 100)
                (grep-history             . 100)
                (compile-history          . 100)
                (minibuffer-history       . 100)
                (query-replace-history    . 100)
                (read-expression-history  . 100)
                (regexp-history           . 100)
                (regexp-search-ring       . 100)
                (search-ring              . 100)
                (shell-command-history    . 100)
                tags-file-name
                register-alist)))

;; auto save desktop on emacs idle
(add-hook 'auto-save-hook (lambda () (desktop-save-in-desktop-dir)))

;; redefine save to remove Desktop saved in ...
(defun desktop-save-in-desktop-dir ()
  "Save the desktop in directory `desktop-dirname'."
  (interactive)
  (if desktop-dirname
      (desktop-save desktop-dirname)
    (call-interactively 'desktop-save)))

(setq desktop-buffers-not-to-save
      (concat "\\("
              "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;;; desktop-override-stale-locks.el begins here
(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let* ((cmdline-file (concat "/proc/" (int-to-string pid) "/cmdline")))
      (when (file-exists-p cmdline-file)
        (with-temp-buffer
          (insert-file-contents-literally cmdline-file)
          (goto-char (point-min))
          (when (search-forward "emacs" nil t)
            pid))))))

(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))

;;
;; alt-shift-arrows
;;
(defun win-resize-top-or-bot ()
"Figure out if the current window is on top, bottom or in the
middle"
(let* ((win-edges (window-edges))
(this-window-y-min (nth 1 win-edges))
(this-window-y-max (nth 3 win-edges))
(fr-height (frame-height)))
(cond
((eq 0 this-window-y-min) "top")
((eq (- fr-height 1) this-window-y-max) "bot")
(t "mid"))))

(defun win-resize-left-or-right ()
"Figure out if the current window is to the left, right or in the
middle"
(let* ((win-edges (window-edges))
(this-window-x-min (nth 0 win-edges))
(this-window-x-max (nth 2 win-edges))
(fr-width (frame-width)))
(cond
((eq 0 this-window-x-min) "left")
((eq (+ fr-width 4) this-window-x-max) "right")
(t "mid"))))

(defun win-resize-enlarge-horiz ()
(interactive)
(cond
((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
(t (message "nil"))))

(defun win-resize-minimize-horiz ()
(interactive)
(cond
((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
(t (message "nil"))))

(defun win-resize-enlarge-vert ()
(interactive)
(cond
((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
(interactive)
(cond
((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(global-set-key [S-M-down] 'win-resize-mi2nimize-vert)
(global-set-key [S-M-up] 'win-resize-enlarge-vert)
(global-set-key [S-M-left] 'win-resize-minimize-horiz)
(global-set-key [S-M-right] 'win-resize-enlarge-horiz)
(global-set-key [S-M-up] 'win-resize-enlarge-horiz)
(global-set-key [S-M-down] 'win-resize-minimize-horiz)
(global-set-key [S-M-left] 'win-resize-enlarge-vert)
(global-set-key [S-M-right] 'win-resize-minimize-vert)

;; Macros
(global-set-key [f2] 'kmacro-call-macro)
(global-set-key [f3] 'kmacro-start-macro-or-insert-counter)
(global-set-key [f4] 'kmacro-end-or-call-macro)

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a 
   symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
   
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
   
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
   
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

(global-set-key "\C-t" 'ido-goto-symbol)

;; fullscreen
(defun switch-full-screen ()
    (interactive)
    (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

(global-set-key [f11] 'switch-full-screen)

(global-set-key [f5] 'compile)

(add-hook 'markdown-mode-hook
  (lambda ()
    (set (make-local-variable 'compile-command) (concat "mdify " (buffer-name)))))
