#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyleft (ↄ) 2019 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.

"""
given a letter, a direction, and a count, find which letter is the given count away fron the given letter in the given direction
"""

from parsimonious.grammar import Grammar
from parsimonious.nodes import NodeVisitor

inputs="""\
3 before R
2 Before C
2 aFter C
5 befOre Q
5 afteR Q
"""

grammar = """\
problem = space number space direction space letter space
direction = before / after
before = ~r"before"i
after = ~r"after"i
letter  = ~"[A-z]*"
number  = ~"[0-9]*"
space = " "*
"""

class StringParser(NodeVisitor):
    def __init__(self, grammar, text):
        self.entry = {}
        ast = Grammar(grammar).parse(text)
        self.visit(ast)
    def visit_letter(self, n, vc):
        self.entry['letter'] = n.text.lower()
    def visit_number(self, n, vc):
        self.entry['number'] = int(n.text)
    def visit_direction(self, n, vc):
        self.entry['direction'] = n.text.lower();
    def generic_visit(self, n, vc):
        pass

alphabet = "abcdefghijklmnopqrstuvwxyz"
for line in inputs.splitlines():
    entry=StringParser(grammar, line).entry 
    index=alphabet.index(entry['letter'])
    if (entry['direction'] == "before"):
        print alphabet[index - entry['number']]
    else:
        print alphabet[index + entry['number']]
