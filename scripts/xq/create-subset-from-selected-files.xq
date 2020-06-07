(: select a subset of files, copy the subset to another directory :)
declare variable $docs := ("aa-vv-supetarski.xml", "sisgor-g-prosopopeya.xml", "modr-n-navic.xml", "marulus-m-carmina008.xml", "sisgor-g-odae.xml", "bunic-j-de-r.xml", "tubero-comm-rhac.xml", "andreis-f-epist-nadasd.xml", "benesa-d_epigr03_croala5095251.croala-lat1.xml", "gradic-s-oratio.xml", "boskovic-r-ecl.xml", "kunic-r-hymnus-cererem.xml", "milasin-f-viator.xml");
for $d in $docs
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/subset/')
return file:write( $path || $d, db:open("croalatextus", $d))