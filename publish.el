;; These requirements are satisfied by Nix, see default.nix
(require 'org)
(require 'ox-publish)
(require 'htmlize)
(require 'ox-html)
(require 'ox-rss)


;; Useful functions and macros
(defmacro setq-default (var val default)
  `(setq ,var (if ,val ,val ,default)))

(defun string-expand-template (template values)
  (let ((pos 0) (result template) prev-result)
    (while (string-match
	    "\\(?:^\\|[^\\]\\)\\({{{\\([a-z0-9-]+\\)}}}\\)"
	    result pos)
      (setq prev-result result)
      (setq result (replace-match
		    (or (cdr (assoc (match-string 2 result) values)) "")
		    t t result 1))
      (setq pos (+ (match-beginning 2)
		   (- (length result) (length prev-result)))))
    result))

(defun perform-template-expansion-here (values)
  (while (re-search-forward "\\(?:^\\|[^\\]\\)\\({{{\\([a-z0-9-]+\\)\\(?:,\\(.*?\\)\\)?}}}\\)" nil t)
    (replace-match (or (cdr (assoc (match-string 2)
				   values))
		       (match-string 3)
		       "")
		   t t nil 1)))

(defun expand-template (template values)
  (with-temp-buffer
    (insert template)
    (goto-char 0)
    (perform-template-expansion-here values)
    (buffer-string)))

(defun insert-and-expand-template (template values)
  (save-restriction
    (narrow-to-region (point) (point))
    (insert template)
    (goto-char (point-min))
    (perform-template-expansion-here values)
    (goto-char (point-max))))

(defun tags-from-post (post-filename)
  "Extract the `#+filetags:` from POST-FILENAME as list of strings."
  (format "%s"
  (let ((case-fold-search t))
    (with-temp-buffer
      (insert-file-contents post-filename)
      (goto-char (point-min))
      (if (search-forward-regexp "^\\#\\+filetags:[ ]*:\\(.*\\):$" nil t)
          (split-string (match-string 1) ":")
	(if (search-forward-regexp "^\\#\\+filetags:[ ]*\\(.+\\)$" nil t)
            (split-string (match-string 1))
	  ))))))

(defun entries-to-html (entries)
  (seq-reduce (lambda (a b)
		(format "%s<li><a href='%s'>%s</a></li>" a (cdr b) (car b)))
	      entries
	      ""))

(defmacro badge-to-html (link img)
  (format "<a href='%s'><img src='%s' /></a>" link img))


;; Blog settings
(setq-default blog-commit (getenv "TRAVIS_COMMIT") "uncommitted")

(setq blog-url "https://cc0.tech/"
      blog-author "Andrea Ciceri"
      blog-email "andrea.ciceri@autistici.org"
      blog-github "https://github.com/andrea96/"
      blog-fingerprint "
7A66 EEA1 E6C5 98D0 7D36
1287 A1FC 8953 2D1C 5654"
      blog-menu '(("about/" . "/")
		  ("posts/" . "/posts/")
		  ("github/" . blog-github)
		  ("rss/" . "/index.xml"))
      blog-date-format "%b %d, %Y"
      blog-attachments (regexp-opt
			'("jpg" "jpeg" "gif" "png" "svg" "mp4" "mp3" "ogg"
			  "ico" "cur" "css" "js" "woff" "html" "pdf" "wasm")))

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
<script src='/js/custom.js'></script>
<script src='/js/hyphenator.js'></script>
")
      
(defun blog-html-preamble (plist)
  (format "<nav class='horizontal-menu'><ul>%s</ul></nav>"
	  (entries-to-html blog-menu)))

(setq blog-html-postamble
      (expand-template "
<div class='hyphenate' id='footer-pre'>
  <nav id='vertical-menu'><ul>{{{menu-html}}}</ul></nav>
  <button type='button' id='toggle-darkmode'></button>
  <nav>
  Feel free to contact me at
  <pre><a href='mailto:{{{email}}}'>{{{email}}}</a></pre>
  My GPG <a href='{{{pubkey}}}'>public key</a> and its fingerprint:
  <pre>{{{fingerprint}}}</pre>
  The commit hash of this build is
  <pre><a href='https://github.com/andrea96/blog/commit/{{{hash}}}'>{{{hash}}}</a></pre>
  <hr>
  Except where otherwise noted, the contents of this website are licensed under
  <a rel='license' href='https://creativecommons.org/licenses/by-sa/4.0/'>
    Creative Commons Attribution-ShareAlike 4.0</a>,
  the complete source code to build this website is licensed under
  <a rel='license' href='https://www.gnu.org/licenses/gpl-3.0.en.html'>
    GNU General Public License 3.0
  </a> and it's hosted on
  <a href='https://github.com'>GitHub</a>.
  </nav>
</div>
<div id='footer-post'>
  <div id='left'>Powered by %c</div>
  <div id='right'>
    <a href='{{{built}}}'>Built</a> with <a href='https://travis-ci.org'>Travis</a> and <a href='https://nixos.org/nix/'>Nix</a> on %C<br>
  </div>
</div>"
		       `(("menu-html" . ,(entries-to-html blog-menu))
			 ("email" . ,blog-email)
			 ("pubkey" . "/andreaciceri-key.txt")
			 ("hash" . ,blog-commit)
			 ("built" . "https://travis-ci.org/github/andrea96/blog")
			 ("fingerprint" . ,blog-fingerprint))))

(defun blog-sitemap-function (title content)
  (expand-template "
#+begin_export html
<h1>{{{title}}}</h1>
<table style='width: 100%; text-align: left'>
  <thead>
    <th>Title</th>
    <th>Date</th>
  </thead>
  <tbody>
    {{{tbody}}}
  </tbody>
</table>
#+end_export
"
		   `(("title" . ,title)
		     ("tbody" . ,(seq-reduce (lambda (a b) (concat (car b) a)) (cdr content) "")))))

(defun blog-sitemap-format-entry (entry style project)
  (cond ((not (directory-name-p entry))
         (expand-template "
<tr>
<td>
<a href='{{{link}}}'>{{{title}}}</a>
</td>
<td>
{{{date}}}
</td>
</tr>"
			  `(("link" . ,(car (split-string entry "\\.")))
			    ("title" . ,(org-publish-find-title entry project))
			    ("date" . ,(format-time-string blog-date-format
							   (org-publish-find-date entry project))))))
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
      org-export-with-tags nil
      org-html-divs '((preamble "header" "top")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format blog-date-format
      org-html-checkbox-type 'html
      org-export-with-emphasize t
      org-html-html5-fancy t
      org-html-validation-link t
      org-html-doctype "html5"
      org-html-htmlize-output-type 'css
      org-src-fontify-natively t
      org-html-home/up-format ""
      org-html-table-caption-above nil
      org-export-global-macros blog-macros
      org-html-mathjax-template "
  <script>
  MathJax = {
    tex: {
      inlineMath: [['$', '$'], ['\\\\(', '\\\\)']],
    },
  };
  </script>
  <script id='MathJax-script' async src='https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js'></script>



")
      
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
         :sitemap-title "Posts archive"
         :sitemap-format-entry blog-sitemap-format-entry
	 :sitemap-function blog-sitemap-function
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
         :base-directory "./posts"
         :base-extension "org"
         :html-link-home "https://cc0.tech/"
         :rss-link-home "https://cc0.tech/"
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
