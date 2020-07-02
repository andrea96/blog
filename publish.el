(require 'org-static-blog)
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

(setq-default blog-commit (getenv "TRAVIS_COMMIT") "uncommitted")

;; org-static-blog settings
(setq org-static-blog-publish-title "Andrea Ciceri's blog")
(setq org-static-blog-publish-url (if (string= blog-commit "uncommitted") "/" "https://blog.ccr.ydns.eu"))
(setq org-static-blog-publish-directory "./public/")
(setq org-static-blog-posts-directory "./posts/")
(setq org-static-blog-drafts-directory "./drafts/")
(setq org-static-blog-enable-tags t)
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

(setq org-static-blog-page-header "
<meta name='author' content='Andrea Ciceri'>
<meta name='referrer content'no-referrer'>
<link rel='icon' type='image/x-icon' href='/images/favicon.png'/>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' href='static/css/normalize.css' type='text/css'/>
<link rel='stylesheet' href='static/css/syntax-coloring.css' type='text/css'/>
<link rel='stylesheet' href='static/css/asciinema-player.css' type='text/css'/>
<link rel='stylesheet' href='static/css/custom.css' type='text/css'/>
<link rel='stylesheet' href='static/css/katex.min.css'/>
<script defer src='static/js/katex.min.js'></script>
<script defer src='static/js/auto-render.min.js'></script>
<script src='static/js/asciinema-player.js'></script>
<script src='static/js/custom.js'></script>
<script src='static/js/hyphenator.js'></script>")

(defun entries-to-html (entries)
  (seq-reduce (lambda (a b)
		(format "%s<li><a href='%s'>%s</a></li>" a (cdr b) (car b)))
	      entries
	      ""))


(setq blog-github "aciceri"
      blog-email "andrea.ciceri@autistici.org"
      blog-fingerprint "
7A66 EEA1 E6C5 98D0 7D36
1287 A1FC 8953 2D1C 5654"
      blog-menu `(("about/" . "/")
		  ("posts/" . "/archive.html")
		  ("github/" . ,(format "https://github.com/%s/" blog-github))
		  ("rss/" . "rss.xml")))

(setq org-static-blog-page-preamble
  (format "<nav class='horizontal-menu'><ul>%s</ul></nav>"
	  (entries-to-html blog-menu)))
      
(setq org-static-blog-page-postamble
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
			 ("built" . "https://travis-ci.org/github/aciceri/blog")
			 ("fingerprint" . ,blog-fingerprint))))

;; org settings
(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t
      org-export-with-toc nil
      org-export-with-tags nil
      org-html-divs '((preamble "header" "top")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format "%b %d, %Y"
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
