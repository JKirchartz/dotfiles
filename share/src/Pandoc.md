%title Pandoc

Pandoc can convert just about any document into any other document


== default LaTeX Layout YAML ==

{{{
When pandoc is used with -t markdown to create a Markdown document, a YAML metadata block will be produced only if the -s/--standalone option is used. All of the metadata will appear in a single block at the beginning of the document.
}}}

Here is a YAML frontmatter with ~~all~~ possible settings of the default latex template

{{{YAML
    ---
    title: 'Title of Document'
    subtitle: 'Subtitle for Document'
    author:
    - A. Writer
    - Ann Other Writer
    date: November 27, 2018
    institute:
    - list of organizations
    - that the authors
    - are affiliated with
    abstract: |
      This is a blurb about the work.

      The abstract comes from academia where it describes what the work is about.
    ---
    }}}

== example command ==

{{{
    pandoc book.md \ # input file
           -s \ # standalone
           --toc \ # generate a table of contents
           --smart \ # Interpret typography more cleverly than the default
           --wrap=preserve \ # preserve line breaks
           --latex-engine=xelatex \ # build using XeLaTeX
           --template=layout.tex \ # use a specific latex template for layout
           -o book.pdf # output file
           }}}


== Links ==

https://pandoc.org/MANUAL.html

http://pandoc.org/MANUAL.html#variables-set-by-pandoc

https://github.com/jgm/pandoc-templates

https://latextemplates.com





