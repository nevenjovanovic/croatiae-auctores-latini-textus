(: create a db of word counts in text sections of XML documents in the CroALa repository :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/croala-wordcounts.xml') 
return db:create("croalatextus-wc", $path, (), map { 'ftindex': true(), 'intparse' : true() })