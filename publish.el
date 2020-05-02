(require 'package)
(package-initialize)

(require 'org)
(require 'ox-publish)
(require 'htmlize)
(require 'ox-html)
(require 'ox-rss)
(require 'ox-reveal)

(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t
      org-export-with-toc nil)

(defvar psachin-date-format "%b %d, %Y")

(setq org-html-divs '((preamble "header" "top")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format psachin-date-format
      org-html-checkbox-type 'html
      org-html-html5-fancy t
      org-html-validation-link t
      org-html-doctype "html5"
      org-html-htmlize-output-type 'css
      org-src-fontify-natively t
      org-html-home/up-format ""
      org-html-table-caption-above nil
      org-export-global-macros '(
				 ("audio" . "@@html:<audio controls><source src='/audios/$1.ogg' type='audio/ogg'><source src='/audios/$1.mp3' type='audio/mpeg'>Your browser does not support the audio tag.</video>@@")
				 ("video" . "@@html:<video controls><source src='/videos/$1.mp4' type='video/mp4'><source src='/videos/$1.ogg' type='video/ogg'>Your browser does not support the video tag.</video>@@")
				 ("youtube" . "@@html:<div class='youtube-wrapper'><iframe allowfullscreen='true' src='https://www.youtube.com/embed/$1'></iframe></div>@@")
				 ("asciinema" . "@@html:<asciinema-player preload='true' src='/casts/$1.cast'></asciinema-player>@@")
				 )
)

(defvar psachin-website-html-head "
<link rel='icon' type='image/x-icon' href='/images/favicon.ico'/>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' href='/css/normalize.css' type='text/css'/>
<link rel='stylesheet' href='/css/syntax-coloring.css' type='text/css'/>
<link rel='stylesheet' href='/css/asciinema-player.css' type='text/css'/>
<link rel='stylesheet' href='/css/custom.css' type='text/css'/>
<script src='/js/asciinema-player.js'></script>
<script src='/js/darkmode-js.min.js'></script>
")

(setq entries '(
		("About" "/")
		("Posts" "/posts/")
		("Github" "https://github.com/andrea96/")
		("Rss" "/index.xml")
		)
      menu-entries (seq-reduce (lambda (a b)
				 (format "%s<li><a href='%s'>%s</a></li>" a (cadr b) (car b)))
			       entries
			       ""))

(defun psachin-website-html-preamble (plist)
  (format "<ul class='horizontal-menu'>%s</ul>" menu-entries))

(defvar psachin-website-html-postamble (concat
(format "<ul class='vertical-menu'>%s</ul>" menu-entries)
"
<a href='javascript:darkmode.toggle();'>Toggle</a> the dark mode<br>
Copyright © 2020 <a href='mailto:andrea.ciceri@autistici.org'>Andrea Ciceri</a><br>
Last updated on %C using %c

<script>
const darkmode =  new Darkmode();
</script>
"))

(defvar site-attachments
  (regexp-opt '("jpg" "jpeg" "gif" "png" "svg" "mp4" "mp3" "ogg"
                "ico" "cur" "css" "js" "woff" "html" "pdf"))
  "File types that are published as static files.")


(defun psachin/org-sitemap-format-entry (entry style project)
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
                 (format-time-string psachin-date-format
                                     (org-publish-find-date entry project))))
        ((eq style 'tree) (file-name-nondirectory (directory-file-name entry)))
        (t entry)))


(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
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

(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)


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
         :sitemap-format-entry psachin/org-sitemap-format-entry
         :sitemap-style list
         :sitemap-sort-files anti-chronologically
         :html-link-home "/"
         :html-link-up "/"
         :html-head-include-scripts t
         :html-head-include-default-style nil
         :html-head ,psachin-website-html-head
         :html-preamble psachin-website-html-preamble
         :html-postamble ,psachin-website-html-postamble)
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
         :html-head ,psachin-website-html-head
         :html-preamble psachin-website-html-preamble
         :html-postamble ,psachin-website-html-postamble)
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
         :base-extension ,site-attachments
         :publishing-directory "./public/images"
         :publishing-function org-publish-attachment
         :recursive t)
        ("videos"
         :base-directory "./videos"
         :base-extension ,site-attachments
         :publishing-directory "./public/videos"
         :publishing-function org-publish-attachment
         :recursive t)
        ("audios"
         :base-directory "./audios"
         :base-extension ,site-attachments
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
;;; publish.el ends here
