(: XQuery module for CroALaBRO :)
module namespace croalabro = 'http://croala.ffzg.unizg.hr/croalabro';
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "croalabro-html.xqm";

(: helper function -- db info :)
declare function croalabro:infodb($dbname) {
  (: return info on main CroALa db, with Latin field names :)
let $week := map {
  "name": "nomen",
  "documents": "documenta",
  "timestamp": "de dato"
}
return element table { 
attribute class { "pull-right"},
let $i := db:info($dbname)/databaseproperties
  for $n in ('name','documents','timestamp')
  return 
   element tr {
    element td { map:get($week, $n) } ,
    element td { $i/*[name()=$n] }
  }
}
};

declare function croalabro:filepath($set){
  for $d in $set
  let $docname := db:path($d)
  let $docurl := "static/croala-html/" || replace( $docname, ".xml", ".html")
  let $giturl := "https://github.com/nevenjovanovic/croatiae-auctores-latini-textus/blob/master/txts/" || $docname
  return if ($set[2]) then ( 
croalabro-html:link($docurl, substring-before($docname, ".xml")),
" ",
croalabro-html:linktag( $giturl, "TEI XML" ) ,
element br {})
else ( croalabro-html:link($docurl, substring-before($docname, ".xml")),
" ",
croalabro-html:linktag( $giturl, "TEI XML" )
)
};

(: table of authors :)

declare variable $croalabro:urn := "http://localhost:8080/";
declare variable $croalabro:db := "croalatextus";

declare function croalabro:tabulaauctorum() {
for $a in db:open($croalabro:db)//*:teiHeader/*:fileDesc/*:titleStmt/*:author/*[name()=("orgName","persName")]
let $s := normalize-space($a)
group by $s
order by $s collation "?lang=hr"
return element tr {
  element td { croalabro-html:link(("auctor/" || $s),$s) },
  element td { attribute class { "text-center" } , count($a) },
  element td { croalabro:filepath($a) }
}

};

(: table of works :)

declare function croalabro:tabulaoperum() {

for $a in db:open($croalabro:db)//*:teiHeader/*:fileDesc/*:titleStmt/*:title
let $s := normalize-space($a)
order by $s collation "?lang=hr"
return element tr {
  element td { $s },
  element td { croalabro:filepath($a) }
}
};

(: table of types, with doc counts :)

declare function croalabro:tabulatyporum() {
for $a in db:open($croalabro:db)//*:teiHeader//*:keywords[@scheme="typus"]/*:term
let $s := normalize-space($a)
group by $s
order by count($a) descending
return element tr {
  element td { $s },
  element td { count($a) }
}
};

(: table of genres, with doc counts :)

declare function croalabro:tabulagenerum() {
for $a in db:open($croalabro:db)//*:teiHeader//*:keywords[@scheme="genre"]/*:term
let $s := normalize-space($a)
group by $s
order by $s
return element tr {
  element td { $s },
  element td { count($a) }
}
};

(: table of periods with doc counts :)

declare function croalabro:tabulatemporum(){
for $a in db:open($croalabro:db)//*:teiHeader//*:creation/*:date
let $s := $a/@period/string()
group by $s
order by $s
return element tr {
  element td { $s },
  element td { count($a) }
}
};