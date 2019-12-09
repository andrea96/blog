#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division

from docutils import nodes
from docutils.parsers.rst import directives, Directive


class gistlines(nodes.General, nodes.Element):
    pass


def visit_gistlines_node(self, node):
    id = 'data-gist-id="{}"'.format(node['id'])
    footer = 'data-gist-hide-footer="{}"'.format("false" if node['footer'] == 'true' else "true") if node['footer'] else ''
    numbers = 'data-gist-hide-line-numbers="{}"'.format("false" if node['numbers'] == 'true' else "true") if node['numbers'] else ''
    lines = 'data-gist-line="{}"'.format(node['lines']) if node['lines'] else ''
    file = 'data-gist-file="{}"'.format(node['file']) if node['file'] else ''
    caption = 'data-gist-caption="{}"'.format(node['caption']) if node['caption'] else ''
    self.body.append(f'<code {id} {numbers} {footer} {lines} {file} {caption}></code>')


def depart_gistlines_node(self, node):
    pass


class GistLines(Directive):
    has_content = True
    required_arguments = 1
    optional_arguments = 0
    final_argument_whitespace = False
    option_spec = {
        "lines": directives.unchanged,
        "numbers": directives.unchanged,
        "footer": directives.unchanged,
        "caption": directives.unchanged,
        "file": directives.unchanged,
    }

    def run(self):
        return [gistlines(id=self.arguments[0],
                          lines=self.options.get('lines'),
                          numbers=self.options.get('numbers'),
                          caption=self.options.get('caption'),
                          file=self.options.get('file'),
                          footer=self.options.get('footer'))]


def unsupported_visit(self, node):
    self.builder.warn('gistlines: unsupported output format (node skipped)')
    raise nodes.SkipNode


_NODE_VISITORS = {
    'html': (visit_gistlines_node, depart_gistlines_node),
    'latex': (unsupported_visit, None),
    'man': (unsupported_visit, None),
    'texinfo': (unsupported_visit, None),
    'text': (unsupported_visit, None)
}


def setup(app):
    app.add_node(gistlines, **_NODE_VISITORS)
    app.add_directive("gistlines", GistLines)
    app.add_js_file('https://cdnjs.cloudflare.com/ajax/libs/gist-embed/2.7.1/gist-embed.min.js')
