#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyleft (ↄ) 2019 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.

"""

"""

from parsimonious.grammar import Grammar
from parsimonious.nodes import NodeVisitor

inputs="""3 before R
        2 Before C
        2 aFter C
        5 befOre Q
        5 afteR Q
        """

grammar = Grammar(
        """
        problem = space number space direction space letter
        direction = before / after
        before = ~r"before"i
        after = ~r"after"i
        letter  = ~"[a-zA-Z]*"
        number  = ~"[0-9]*"
        space = &~r"\s"*
        """)


for line in inputs.splitlines():
    print grammar.parse(line)

class StringParser(NodeVisitor):
    def __init__(self, grammar, text):
        self.entry = {}
        ast = Grammar(grammar).parse(text)
        self.visit(ast)
    def visit_letter(self, n, vc):
        self.entry['letter'] = n.letter
    def visit_number(self, n, vc):
        self.entry['number'] = n.number
    def visit_direction(self, n, vc):
        self.entry['direction'] = n.direction
    def visit_space(self, n, vc):
        pass
    def generic_visit(self, n, vc):
        pass

for line in inputs.splitlines():
    print StringParser(grammar, line).entry
