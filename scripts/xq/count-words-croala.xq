(: return word count for each file :)
(: provide wordcount element with @title and @wc :)
(: save as files in wordcount directory :)
let $wcs := element wordcounts {
let $collection := "croalatextus"
for $w in collection($collection)//*:TEI/*:text
let $toks := for $t in ft:tokenize($w) return count($t)
order by db:path($w)
return element doc { attribute title {
  db:path($w)} ,
  attribute wc { sum($toks) } }
}
return file:write("/home/neven/Nextcloud/Repos/croatiae-auctores-latini-textus/croala-wordcounts.xml", $wcs)