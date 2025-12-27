/*
 * mapjoiner.js
 * Join 2 arrays that are being used as a map
 * if arrays aren't the same length return false
 * if they are the same length return an object containing the mapping
 *
 * Copyleft (ↄ) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
 *
 * Distributed under terms of the NPL (Necessary Public License) license.
 *
 */

function sizer(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
}
module.exports = function mapjoiner(key_arr, cat_arr) {
  var key_cat = {};
  if (key_arr.length !== cat_arr.length) {
     return false;
  }
  for (var i = 0; i < key_arr.length; i++) {
    if (key_cat[key_arr[i]]) {
      if (typeof key_cat[key_arr[i]] === 'string') {
        key_cat[key_arr[i]] = [key_cat[key_arr[i]], cat_arr[i]];
      } else {
        key_cat[key_arr[i]].push(cat_arr[i]);
      }
    } else {
      key_cat[key_arr[i]] = cat_arr[i];
    }
  }
  if (sizer(key_cat)) {
    return key_cat;
  } else {
    return false;
  }
};

/* test:
 * inputs:
var keyword_arr = ['ammo', 'ammo', 'ammo', 'barrels', 'magazine', 'air gun',
  'airsoft rifle', 'ammunition', 'blanks', 'loads', 'round', 'ammo',
  'shotshell', 'loads', 'pellets', ' bbs', 'revolver', 'buckshot',
  'turkey loads', 'shotshell', 'buckshot', 'clip', 'clip', 'stock', 'stock',
  'stock', 'dies', 'die set', 'revolver with', 'pistol', 'pistol',
  'magazines', 'ammunition', 'ammunition', 'ammunition', 'ammunition',
  'ammunition', 'ammunition', 'ammunition', 'ammunition', 'ammunition',
  'ammunition', 'ammunition', 'ammunition', 'ammunition', 'ammunition',
  'ammunition', 'ammunition', 'bullets', 'ammo', 'power point', 'bullets',
  'shot shells', 'shotshells', 'ammunition', 'shotshells', 'game load',
  'shotshells', 'game load', 'target load', 'bullets', 'spit fire mz',
  'rifle round', 'pistol round', '.50 caliber', 'sabots', 'center maxi',
  'pistol brass', 'rifle brass', 'shotshell', 'ammo', 'ammunition',
  'ammunition', 'cowboy loads', 'slugs', 'lead shot', 'buck shot',
  'shotshell', 'wads'];
var category_arr = [
    'home/gifts > gifts & personal access > toys/games > shooting toys',
    'shooting > ammunition > centerfire pistol ammo > target/range',
    'shooting > storage & shooting access > air guns / soft air >' +
      ' soft air access/ammo',
    'shooting > storage & shooting access > barrels > slug barrels',
    'shooting > storage & shooting access > tactical > magazines',
    'shooting > storage & shooting access > air guns / soft air >' +
      ' rifle -scoped',
    'shooting > storage & shooting access > air guns / soft air > soft air',
    'shooting > ammunition > centerfire pistol ammo > personal defense',
    'shooting > ammunition > shot gun shells > misc shotgun shells',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > ammunition > centerfire rifle ammo > miscellaneous',
    'shooting > ammunition > centerfire pistol ammo > hunting',
    'shooting > storage & shooting access > tactical > magazines',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > storage & shooting access > air guns / soft air > pellets/bbs',
    'shooting > storage & shooting access > air guns / soft air > pellets/bbs',
    'shooting > black powder > black powder guns > black powder pistols',
    'shooting > ammunition > shot gun shells > buckshot',
    'shooting > ammunition > shot gun shells > turkey loads',
    'shooting > ammunition > shot gun shells > non steel/non tox loads',
    'shooting > ammunition > shot gun shells > buckshot',
    'shooting > storage & shooting access > tactical > magazines',
    'shooting > storage & shooting access > shooting access > rifle clips',
    'shooting > storage & shooting access > tactical > stocks/handguards',
    'shooting > storage & shooting access > stocks/grips > shotgun/rifle' +
      ' (2 piece)',
    'shooting > storage & shooting access > stocks/grips > rifle stocks',
    'shooting > reloading > metallic reloading > dies/shellholders',
    'shooting > reloading > metallic reloading > dies/shellholders',
    'shooting > black powder > black powder guns > black powder pistols',
    'firearms > hand guns - new > holsters,clips,access > concealed carry',
    'firearms > hand guns - new > hand guns centerfire > semi-auto cf handguns',
    'firearms > hand guns - new > holsters,clips,access > pistol clips',
    'shooting > ammunition > centerfire pistol ammo > hunting',
    'shooting > ammunition > centerfire pistol ammo > misc ammo',
    'shooting > ammunition > centerfire pistol ammo > personal defense',
    'shooting > ammunition > centerfire pistol ammo > target/range',
    'shooting > ammunition > centerfire rifle ammo > big game',
    'shooting > ammunition > centerfire rifle ammo > dangerous game',
    'shooting > ammunition > centerfire rifle ammo > miscellaneous',
    'shooting > ammunition > centerfire rifle ammo > personal defense/varmint',
    'shooting > ammunition > centerfire rifle ammo > target/range',
    'shooting > ammunition > rimfire ammo > .17 hmr',
    'shooting > ammunition > rimfire ammo > .22 mag',
    'shooting > ammunition > shot gun shells > buckshot',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > ammunition > shot gun shells > non steel/non tox loads',
    'shooting > ammunition > shot gun shells > steel shotgun shells',
    'shooting > ammunition > shot gun shells > turkey loads',
    'shooting > reloading > reloading components > rifle bullets',
    'shooting > ammunition > centerfire rifle ammo > big game',
    'shooting > ammunition > centerfire rifle ammo > big game',
    'shooting > reloading > reloading components > pistol bullets',
    'shooting > ammunition > shot gun shells > steel shotgun shells',
    'shooting > ammunition > shot gun shells > steel shotgun shells',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > ammunition > shot gun shells > lead shotgun shells',
    'shooting > ammunition > shot gun shells > lead trgt/lght fld loads',
    'shooting > ammunition > shot gun shells > lead trgt/lght fld loads',
    'shooting > ammunition > shot gun shells > lead trgt/lght fld loads',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > black powder > black powder access > black powder balls/bullet',
    'shooting > reloading > reloading components > brass',
    'shooting > reloading > reloading components > brass',
    'shooting > reloading > reloading components > brass',
    'shooting > ammunition > centerfire pistol ammo > personal defense',
    'shooting > ammunition > centerfire pistol ammo > personal defense',
    'shooting > ammunition > centerfire pistol ammo > target/range',
    'shooting > ammunition > centerfire pistol ammo > target/range',
    'shooting > ammunition > shot gun shells > shotgun slugs',
    'shooting > reloading > shotshell reloading > shotshell components',
    'shooting > reloading > shotshell reloading > shotshell components',
    'shooting > reloading > shotshell reloading > shotshell components',
    'shooting > reloading > shotshell reloading > shotshell components'];

 * 
 * logging:
console.log("var category_by_keyword = %s", joiner(keyword_arr, category_arr));
console.log("var keyword_by_category = %s", joiner(category_arr, keyword_arr));

 *
 * outputs:
var category_by_keyword = { ammo: 
   [ 'home/gifts > gifts & personal access > toys/games > shooting toys',
     'shooting > ammunition > centerfire pistol ammo > target/range',
     'shooting > storage & shooting access > air guns / soft air > soft air access/ammo',
     'shooting > ammunition > centerfire pistol ammo > hunting',
     'shooting > ammunition > centerfire rifle ammo > big game',
     'shooting > ammunition > centerfire pistol ammo > personal defense' ],
  barrels: 'shooting > storage & shooting access > barrels > slug barrels',
  magazine: 'shooting > storage & shooting access > tactical > magazines',
  'air gun': 'shooting > storage & shooting access > air guns / soft air > rifle -scoped',
  'airsoft rifle': 'shooting > storage & shooting access > air guns / soft air > soft air',
  ammunition: 
   [ 'shooting > ammunition > centerfire pistol ammo > personal defense',
     'shooting > ammunition > centerfire pistol ammo > hunting',
     'shooting > ammunition > centerfire pistol ammo > misc ammo',
     'shooting > ammunition > centerfire pistol ammo > personal defense',
     'shooting > ammunition > centerfire pistol ammo > target/range',
     'shooting > ammunition > centerfire rifle ammo > big game',
     'shooting > ammunition > centerfire rifle ammo > dangerous game',
     'shooting > ammunition > centerfire rifle ammo > miscellaneous',
     'shooting > ammunition > centerfire rifle ammo > personal defense/varmint',
     'shooting > ammunition > centerfire rifle ammo > target/range',
     'shooting > ammunition > rimfire ammo > .17 hmr',
     'shooting > ammunition > rimfire ammo > .22 mag',
     'shooting > ammunition > shot gun shells > buckshot',
     'shooting > ammunition > shot gun shells > lead shotgun shells',
     'shooting > ammunition > shot gun shells > non steel/non tox loads',
     'shooting > ammunition > shot gun shells > steel shotgun shells',
     'shooting > ammunition > shot gun shells > turkey loads',
     'shooting > ammunition > shot gun shells > lead shotgun shells',
     'shooting > ammunition > centerfire pistol ammo > personal defense',
     'shooting > ammunition > centerfire pistol ammo > target/range' ],
  blanks: 'shooting > ammunition > shot gun shells > misc shotgun shells',
  loads: 
   [ 'shooting > ammunition > shot gun shells > lead shotgun shells',
     'shooting > ammunition > shot gun shells > lead shotgun shells' ],
  round: 'shooting > ammunition > centerfire rifle ammo > miscellaneous',
  shotshell: 
   [ 'shooting > storage & shooting access > tactical > magazines',
     'shooting > ammunition > shot gun shells > non steel/non tox loads',
     'shooting > reloading > reloading components > brass',
     'shooting > reloading > shotshell reloading > shotshell components' ],
  pellets: 'shooting > storage & shooting access > air guns / soft air > pellets/bbs',
  ' bbs': 'shooting > storage & shooting access > air guns / soft air > pellets/bbs',
  revolver: 'shooting > black powder > black powder guns > black powder pistols',
  buckshot: 
   [ 'shooting > ammunition > shot gun shells > buckshot',
     'shooting > ammunition > shot gun shells > buckshot' ],
  'turkey loads': 'shooting > ammunition > shot gun shells > turkey loads',
  clip: 
   [ 'shooting > storage & shooting access > tactical > magazines',
     'shooting > storage & shooting access > shooting access > rifle clips' ],
  stock: 
   [ 'shooting > storage & shooting access > tactical > stocks/handguards',
     'shooting > storage & shooting access > stocks/grips > shotgun/rifle (2 piece)',
     'shooting > storage & shooting access > stocks/grips > rifle stocks' ],
  dies: 'shooting > reloading > metallic reloading > dies/shellholders',
  'die set': 'shooting > reloading > metallic reloading > dies/shellholders',
  'revolver with': 'shooting > black powder > black powder guns > black powder pistols',
  pistol: 
   [ 'firearms > hand guns - new > holsters,clips,access > concealed carry',
     'firearms > hand guns - new > hand guns centerfire > semi-auto cf handguns' ],
  magazines: 'firearms > hand guns - new > holsters,clips,access > pistol clips',
  bullets: 
   [ 'shooting > reloading > reloading components > rifle bullets',
     'shooting > reloading > reloading components > pistol bullets',
     'shooting > black powder > black powder access > black powder balls/bullet' ],
  'power point': 'shooting > ammunition > centerfire rifle ammo > big game',
  'shot shells': 'shooting > ammunition > shot gun shells > steel shotgun shells',
  shotshells: 
   [ 'shooting > ammunition > shot gun shells > steel shotgun shells',
     'shooting > ammunition > shot gun shells > lead shotgun shells',
     'shooting > ammunition > shot gun shells > lead trgt/lght fld loads' ],
  'game load': 
   [ 'shooting > ammunition > shot gun shells > lead shotgun shells',
     'shooting > ammunition > shot gun shells > lead trgt/lght fld loads' ],
  'target load': 'shooting > ammunition > shot gun shells > lead trgt/lght fld loads',
  'spit fire mz': 'shooting > black powder > black powder access > black powder balls/bullet',
  'rifle round': 'shooting > black powder > black powder access > black powder balls/bullet',
  'pistol round': 'shooting > black powder > black powder access > black powder balls/bullet',
  '.50 caliber': 'shooting > black powder > black powder access > black powder balls/bullet',
  sabots: 'shooting > black powder > black powder access > black powder balls/bullet',
  'center maxi': 'shooting > black powder > black powder access > black powder balls/bullet',
  'pistol brass': 'shooting > reloading > reloading components > brass',
  'rifle brass': 'shooting > reloading > reloading components > brass',
  'cowboy loads': 'shooting > ammunition > centerfire pistol ammo > target/range',
  slugs: 'shooting > ammunition > shot gun shells > shotgun slugs',
  'lead shot': 'shooting > reloading > shotshell reloading > shotshell components',
  'buck shot': 'shooting > reloading > shotshell reloading > shotshell components',
  wads: 'shooting > reloading > shotshell reloading > shotshell components' }
var keyword_by_category = { 'home/gifts > gifts & personal access > toys/games > shooting toys': 'ammo',
  'shooting > ammunition > centerfire pistol ammo > target/range': [ 'ammo', 'ammunition', 'ammunition', 'cowboy loads' ],
  'shooting > storage & shooting access > air guns / soft air > soft air access/ammo': 'ammo',
  'shooting > storage & shooting access > barrels > slug barrels': 'barrels',
  'shooting > storage & shooting access > tactical > magazines': [ 'magazine', 'shotshell', 'clip' ],
  'shooting > storage & shooting access > air guns / soft air > rifle -scoped': 'air gun',
  'shooting > storage & shooting access > air guns / soft air > soft air': 'airsoft rifle',
  'shooting > ammunition > centerfire pistol ammo > personal defense': [ 'ammunition', 'ammunition', 'ammo', 'ammunition' ],
  'shooting > ammunition > shot gun shells > misc shotgun shells': 'blanks',
  'shooting > ammunition > shot gun shells > lead shotgun shells': 
   [ 'loads',
     'loads',
     'ammunition',
     'ammunition',
     'shotshells',
     'game load' ],
  'shooting > ammunition > centerfire rifle ammo > miscellaneous': [ 'round', 'ammunition' ],
  'shooting > ammunition > centerfire pistol ammo > hunting': [ 'ammo', 'ammunition' ],
  'shooting > storage & shooting access > air guns / soft air > pellets/bbs': [ 'pellets', ' bbs' ],
  'shooting > black powder > black powder guns > black powder pistols': [ 'revolver', 'revolver with' ],
  'shooting > ammunition > shot gun shells > buckshot': [ 'buckshot', 'buckshot', 'ammunition' ],
  'shooting > ammunition > shot gun shells > turkey loads': [ 'turkey loads', 'ammunition' ],
  'shooting > ammunition > shot gun shells > non steel/non tox loads': [ 'shotshell', 'ammunition' ],
  'shooting > storage & shooting access > shooting access > rifle clips': 'clip',
  'shooting > storage & shooting access > tactical > stocks/handguards': 'stock',
  'shooting > storage & shooting access > stocks/grips > shotgun/rifle (2 piece)': 'stock',
  'shooting > storage & shooting access > stocks/grips > rifle stocks': 'stock',
  'shooting > reloading > metallic reloading > dies/shellholders': [ 'dies', 'die set' ],
  'firearms > hand guns - new > holsters,clips,access > concealed carry': 'pistol',
  'firearms > hand guns - new > hand guns centerfire > semi-auto cf handguns': 'pistol',
  'firearms > hand guns - new > holsters,clips,access > pistol clips': 'magazines',
  'shooting > ammunition > centerfire pistol ammo > misc ammo': 'ammunition',
  'shooting > ammunition > centerfire rifle ammo > big game': [ 'ammunition', 'ammo', 'power point' ],
  'shooting > ammunition > centerfire rifle ammo > dangerous game': 'ammunition',
  'shooting > ammunition > centerfire rifle ammo > personal defense/varmint': 'ammunition',
  'shooting > ammunition > centerfire rifle ammo > target/range': 'ammunition',
  'shooting > ammunition > rimfire ammo > .17 hmr': 'ammunition',
  'shooting > ammunition > rimfire ammo > .22 mag': 'ammunition',
  'shooting > ammunition > shot gun shells > steel shotgun shells': [ 'ammunition', 'shot shells', 'shotshells' ],
  'shooting > reloading > reloading components > rifle bullets': 'bullets',
  'shooting > reloading > reloading components > pistol bullets': 'bullets',
  'shooting > ammunition > shot gun shells > lead trgt/lght fld loads': [ 'shotshells', 'game load', 'target load' ],
  'shooting > black powder > black powder access > black powder balls/bullet': 
   [ 'bullets',
     'spit fire mz',
     'rifle round',
     'pistol round',
     '.50 caliber',
     'sabots',
     'center maxi' ],
  'shooting > reloading > reloading components > brass': [ 'pistol brass', 'rifle brass', 'shotshell' ],
  'shooting > ammunition > shot gun shells > shotgun slugs': 'slugs',
  'shooting > reloading > shotshell reloading > shotshell components': [ 'lead shot', 'buck shot', 'shotshell', 'wads' ] }
*/
