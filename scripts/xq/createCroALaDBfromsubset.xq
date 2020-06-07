(: create a db of XML texts in the subset of CroALa repository :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/subset/') 
return db:create("croalatextussubset", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })