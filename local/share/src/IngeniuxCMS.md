%title Ingeniux

* IIS-based MVC, a lot of XML
* lots of click & drag -- ASP.NET/ XSLT
* interesting software, poor customer service
* Pages & Components
	- Page - as expected
	- Component - fields that publish to pages (if tried to view as page you get XML)
* Refresh: refresh display when co-working
* preview page w. preview tab or button (button better than tab)
* "transform without stylesheet" shows underlying XML
* "Publish site" to publish to "target"
* "incremental" changed since last publish
* "full" redo publish, cleaning existing content first (more files === longer time)
	- nobody else can publish while publish in progress
* Xpath
* RavenDB (new in Ingenuix 9)
* DSS: Dynamic Site Server (serves from publish destination of CMS)

[Raxor Syntax](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor)


* Asset Manager -- requires Flash

== From Scratch: ==

* setup VM for IIS (Ian has instructions on intranet)
* install ingenuix
* create base components

* schema designer (schema = blueprint for page in CMS -- page OR component)
	- "allow synched pages to be chcked in without review
	- "sync pages without checking out"
	- "overwrite value attribute flats

save group of fields to "favorites"

"Insert" good for feeds
TinyMCE
"List" infinitely repeatable field, i.e. list of links, list of components

"share" component breaks itself iyt

section control/Navigation "Subtree" gives you everything, but burns through memory

taxonomy navigation: anything can be tagged

== System Options ==

* Navigation Exports

when it's all XML, the cms can export a schema into the page tag


* global exports (batched/cached -- faster & preferred to local)
* local exports (inefficient, on-demand)

Component Publish Setting -- publish all referred components [x]
publish components referenced from pages

Auto-save config (save when you click away from a page)

Asset Browser (enable "weird" extensions)

WorldView -- Ingeniux

"Presenation Formatter" setup for Foundation

unclear on insite search config, use Google instead

---- "Publishing System" -- manage publishing target(s) , where to publish, etc

-- set homepage
-- turn off replication

---- maintenence
-- export site to migrate
-- log viewer



database has all schema
content & asset folders are genrally huge (gigs)
EXPORT DATABASE is all you **need**

bigger the file, the longer it takes -- results in a zip file containing what you ask for




----------

only ever need to modify views & app_code


icmselement
icmspage

=== folder structure ===

View > Editable > *.cshtml
	only stuff editable through the CMS view (i.e. Pagebuilder or front-end editor)




