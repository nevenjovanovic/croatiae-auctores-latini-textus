(: find docs with only l :)
for $d in  db:open("croalatextus")//*:text
let $docn := db:path($d)
let $names := distinct-values($d//*/name())
where count($names) < 7 and count($names) > 3
return element n { $names , $docn }