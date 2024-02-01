(: for the element containing word, return full path :)
let $db := "croalatextus"
let $word := "andron"
for $occ in db:get($db)//*:text//*[text() contains text { $word } ]
let $prefix := "Q\{http://www.tei-c.org/ns/1.0\}"
let $p := path($occ)
let $docname := db:path($occ)
let $cp := $docname || replace($p, $prefix, "")
return element tr {
  element td { $cp },
  element td { $occ }
}