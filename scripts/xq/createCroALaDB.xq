(: create a db of XML texts in the CroALa repository :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/txts/') 
return db:create("croalatextus", $path, (), map { 'ftindex': true(), 'ftinclude' : 'tei:text', 'intparse' : true(), 'stripws' : false(), 'updindex' : true() })