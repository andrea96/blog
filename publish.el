;; These requirements are satisfied by Nix, see default.nix
(require 'org)
(require 'ox-publish)
(require 'htmlize)
(require 'ox-html)
(require 'ox-rss)


;; Useful functions and macros
(defmacro setq-default (var val default)
  `(setq ,var (if ,val ,val ,default)))

(defun entries-to-html (entries)
  (seq-reduce (lambda (a b)
		(format "%s<li><a href='%s'>%s</a></li>" a (cdr b) (car b)))
	      entries
	      ""))


;; Blog settings
(setq-default blog-commit (getenv "TRAVIS_COMMIT") "No commit")

(setq blog-url "https://cc0.tech/"
      blog-author "Andrea Ciceri"
      blog-email "andrea.ciceri@autistici.org"
      blog-github "https://github.com/andrea96/"
      blog-fingerprint "7A66 EEA1 E6C5 98D0 7D36<br>1287 A1FC 8953 2D1C 5654"
      blog-menu '(("About" . "/")
		  ("Posts" . "/posts/")
		  ("Github" . blog-github)
		  ("Rss" . "/index.xml"))
      blog-date-format "%b %d, %Y"
      blog-attachments (regexp-opt
			'("jpg" "jpeg" "gif" "png" "svg" "mp4" "mp3" "ogg"
			  "ico" "cur" "css" "js" "woff" "html" "pdf"))
      )

(setq blog-macros '(("audio" . "
@@html:<audio controls>
<source src='/audios/$1.ogg' type='audio/ogg'>
<source src='/audios/$1.mp3' type='audio/mpeg'>
Your browser does not support the audio tag.
</video>@@
")
		    ("video" . "
@@html:<video controls>
<source src='/videos/$1.mp4' type='video/mp4'>
<source src='/videos/$1.ogg' type='video/ogg'>
Your browser does not support the video tag.
</video>@@
")
		    ("youtube" . "
@@html:<div class='youtube-wrapper'>
<iframe allowfullscreen='true' src='https://www.youtube.com/embed/$1'></iframe>
</div>@@
")
		    ("asciinema" . "
@@html:<asciinema-player preload='true' src='/casts/$1.cast'></asciinema-player>@@
")
		    ))
      
(setq blog-html-head "
<link rel='icon' type='image/x-icon' href='/images/favicon.png'/>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' href='/css/normalize.css' type='text/css'/>
<link rel='stylesheet' href='/css/syntax-coloring.css' type='text/css'/>
<link rel='stylesheet' href='/css/asciinema-player.css' type='text/css'/>
<link rel='stylesheet' href='/css/custom.css' type='text/css'/>
<script src='/js/asciinema-player.js'></script>
<script src='/js/darkmode-js.min.js'></script>
")
      
(defun blog-html-preamble (plist)
  (format "<ul class='horizontal-menu'>%s</ul>"
	  (entries-to-html blog-menu)))
      
(setq blog-html-postamble
      (concat
       (format "<ul class='vertical-menu'>%s</ul>"
	       (entries-to-html blog-menu))
       (format "Commit: %s<br>" blog-commit) "
<a href='javascript:darkmode.toggle();'>Toggle</a> the dark mode<br>
Copyright © 2020 <a href='mailto:andrea.ciceri@autistici.org'>Andrea Ciceri</a><br>
Last updated on %C using %c<br>
<script>
const darkmode =  new Darkmode();
</script>
"))

(defun blog-sitemap-format-entry (entry style project)
  "Format posts with author and published data in the index page.

ENTRY: file-name
STYLE:
PROJECT: `posts in this case."
  (cond ((not (directory-name-p entry))
         (format "*[[file:%s][%s]]*
                 #+HTML: <p class='pubdate'>by %s on %s.</p>"
                 (car (split-string entry "\\."))
                 (org-publish-find-title entry project)
                 (car (org-publish-find-property entry :author project))
                 (format-time-string blog-date-format
                                     (org-publish-find-date entry project))))
        ((eq style 'tree) (file-name-nondirectory (directory-file-name entry)))
        (t entry)))

(defun my-org-export-output-file-name (orig-fun extension &optional subtreep pub-dir)
  (if (string-match "posts/\\'" pub-dir)
      (let ((path (buffer-file-name (buffer-base-buffer))))
	(save-match-data (and (string-match "posts/\\([^@]+\\)\\.org\\'" path)
			      (setq filename (match-string 1 path))))
	(if (equal filename "index")
	    (concat pub-dir "/index.html")
	  (progn
	    (make-directory (concat pub-dir filename))
	    (concat pub-dir filename "/index.html")
	    )))
    (apply orig-fun extension subtreep pub-dir nil)))

(advice-add 'org-export-output-file-name :around #'my-org-export-output-file-name)


;; Org settings
(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t
      org-export-with-toc nil
      org-html-divs '((preamble "header" "top")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format blog-date-format
      org-html-checkbox-type 'html
      org-html-html5-fancy t
      org-html-validation-link t
      org-html-doctype "html5"
      org-html-htmlize-output-type 'css
      org-src-fontify-natively t
      org-html-home/up-format ""
      org-html-table-caption-above nil
      org-export-global-macros blog-macros)

(setq org-publish-project-alist
      `(("posts"
         :base-directory "posts"
         :base-extension "org"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :publishing-directory "./public/posts"
         :exclude ,(regexp-opt '("README.org" "draft"))
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Blog Index"
         :sitemap-format-entry blog-sitemap-format-entry
         :sitemap-style list
         :sitemap-sort-files anti-chronologically
         :html-link-home "/"
         :html-link-up "/"
         :html-head-include-scripts t
         :html-head-include-default-style nil
         :html-head ,blog-html-head
         :html-preamble blog-html-preamble
         :html-postamble ,blog-html-postamble)
        ("about"
         :base-directory "about"
         :base-extension "org"
         :exclude ,(regexp-opt '("README.org" "draft"))
         :index-filename "index.org"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :publishing-directory "./public/"
         :html-link-home "/"
         :html-link-up "/"
         :html-head-include-scripts t
         :html-head-include-default-style nil
         :html-head ,blog-html-head
         :html-preamble blog-html-preamble
         :html-postamble ,blog-html-postamble)
        ("css"
         :base-directory "./css"
         :base-extension "css"
         :publishing-directory "./public/css"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("js"
         :base-directory "./js"
         :base-extension "js"
         :publishing-directory "./public/js"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("fonts"
         :base-directory "./fonts"
         :base-extension "woff"
         :publishing-directory "./public/fonts"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("casts"
         :base-directory "./casts"
         :base-extension "cast"
         :publishing-directory "./public/casts"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("images"
         :base-directory "./images"
         :base-extension ,blog-attachments
         :publishing-directory "./public/images"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("videos"
         :base-directory "./videos"
         :base-extension ,blog-attachments
         :publishing-directory "./public/videos"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("audios"
         :base-directory "./audios"
         :base-extension ,blog-attachments
         :publishing-directory "./public/audios"
	 :publishing-function org-publish-attachment
         :recursive t)
        ("rss"
         :base-directory "posts"
         :base-extension "org"
         :html-link-home "http://example.com/"
         :rss-link-home "http://example.com/"
         :html-link-use-abs-url t
         :rss-extension "xml"
         :publishing-directory "./public"
         :publishing-function (org-rss-publish-to-rss)
         :section-number nil
         :exclude ".*"
         :include ("index.org")
         :table-of-contents nil)
        ("all" :components ("posts" "css" "fonts" "images" "rss"))))


(provide 'publish)
