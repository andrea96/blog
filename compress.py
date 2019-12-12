import htmlmin
import csscompressor
import rjsmin
from glob import iglob
import re


processors = {}


def add_to_processors(regex):
    def decorator(processor):
        processors[regex] = ((processor, re.compile(regex)))
    return decorator


@add_to_processors('.+[.]html$')
def process_html(filename):
    with open(filename, 'r') as f:
        src = f.read()
    with open(filename, 'w') as f:
        f.write(htmlmin.minify(src))


@add_to_processors('.+[.]js$')
def process_js(filename):
    with open(filename, 'r') as f:
        src = f.read()
    with open(filename, 'w') as f:
        f.write(rjsmin.jsmin(src))


@add_to_processors('.+[.]css$')
def process_css(filename):
    with open(filename, 'r') as f:
        src = f.read()
    with open(filename, 'w') as f:
        f.write(csscompressor.compress(src))


def process(filename, processors):
    for regex in processors:
        if processors[regex][1].match(filename):
            processors[regex][0](filename)


for filename in iglob('blog/_website/**', recursive=True):
    process(filename, processors)
