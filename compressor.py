import htmlmin
import csscompressor
import rjsmin
from glob import iglob
import re
from sys import argv


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

def main(folder):
    for filename in iglob(f'{folder}/**', recursive=True):
        process(filename, processors)


if __name__ == '__main__' and len(argv) == 2:
    main(argv[1])
else:
    print('No path provided')
    exit(-1)
