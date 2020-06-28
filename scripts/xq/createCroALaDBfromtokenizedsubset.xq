(: create a db of XML texts in the subset of CroALa repository :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/subset-tokenized/')
let $files := for $f in file:list($path, false(), '*.xml') return $path || $f
return db:create("croalatextussubsettokenized", $files, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false(), 'updindex': true() })