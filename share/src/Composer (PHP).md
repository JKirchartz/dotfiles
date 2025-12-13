%title Composer


to add a git repo to composer, add

{{{json

 {
   "type": "vcs",
   "url": "git@bitbucket.org:accountname/reponame.git"
 }
 }}}

to composer.json's repositories

and in require add "accountname/reponame": "version tag"
