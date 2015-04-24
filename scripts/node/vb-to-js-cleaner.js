/*
 * vb-to-js-cleaner.js
 * Copyleft (ↄ) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
 *
 * Distributed under terms of the NPL (Necessary Public License) license.
 */

// Setup everything
var stream = require('stream');
var cleaner = new stream.Transform({ objectMode: true });

/* the actual function */
cleaner._transform = function(txt, enc, done) {
  txt = String(txt);
  txt = txt.replace(/"/g, '\'');
  txt = txt.replace(/ & /g, ' + ');
  txt = txt.replace(/-\(1\)/g, '-1');
  txt = txt.replace(/\(parseInt\(0\)\s\-\s?1\)/gi, '-1');
  txt = txt.replace(/Array\[/g, '[');
  this.push(txt);
  done();
};

process.stdin.pipe(cleaner).pipe(process.stdout);

/* TEST:
 * "test"
 * franks & beans
 * (parseInt(0) - 1)
 * -(1)
 *  Array['1','2','3']
 */

