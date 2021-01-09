;;; pkg-prepare.el --- Prepare for package initialization  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'package)

(setq package-archives
      '(("celpa" . "https://celpa.conao3.com/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ;;("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/"))
      package-enable-at-startup nil
      package-check-signature nil)

(package-initialize)

(defun jcs-package-install (pkg)
  "Install PKG package."
  (unless (get 'jcs-package-install 'state)
    (put 'jcs-package-install 'state t))
  ;; Don't run `package-refresh-contents' if you don't need to install
  ;; packages on startup.
  (package-refresh-contents)
  ;; Else we just install the package regularly.
  (package-install pkg))

(defun jcs-ensure-package-installed (packages &optional without-asking)
  "Assure every PACKAGES is installed, ask WITHOUT-ASKING."
  (dolist (package packages)
    (unless (package-installed-p package)
      (if (or without-asking
              (y-or-n-p (format "[ELPA] Package %s is missing. Install it? " package)))
          (jcs-package-install package)
        package)))
  ;; STUDY: Not sure if you need this?
  (when (get 'jcs-package-install 'state)
    (package-initialize)))

(provide 'pkg-prepare)
;;; pkg-prepare.el ends here
