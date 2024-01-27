(: return a sum of words in CroALa texts / not docs :)
sum ( for $doc in db:get("croalatextus-wc")//doc
let $n := $doc/@wc
return $n )