(: XQuery module for CroALaBRO :)
module namespace croalabro = 'http://croala.ffzg.unizg.hr/croalabro';
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "croalabro-html.xqm";

(: map to translate period notation into Latin :)

declare variable $croalabro:periodi := map {
  "09xx_3_third": "saeculi X prima tertiarum (09xx_3_third)",
  "17xx_1_third": "saeculi XVIII prima tertiarum (17xx_1_third)",
  "16xx_2_third": "saeculi XVII secunda tertiarum (16xx_2_third)",
  "15xx_3_third": "saeculi XVI tertia tertiarum (15xx_3_third)",
  "16xx_3_third": "saeculi XVII tertia tertiarum (16xx_3_third)",
  "18xx_1_third": "saeculi XIX prima tertiarum (18xx_1_third)",
  "17xx_2_third": "saeculi XVIII secunda tertiarum (17xx_2_third)",
  "19xx_1_third": "saeculi XX prima tertiarum (19xx_1_third)",
  "18xx_2_third": "saeculi XIX secunda tertiarum (18xx_2_third)",
  "17xx_3_third": "saeculi XVIII tertia tertiarum (17xx_3_third)",
  "19xx_2_third": "saeculi XX secunda tertiarum (19xx_2_third)",
  "18xx_3_third": "saeculi XIX tertia tertiarum (18xx_3_third)",
  "19xx_3_third": "saeculi XX tertia tertiarum (19xx_3_third)",
  "10xx_1_third": "saeculi XI prima tertiarum (10xx_1_third)",
  "10xx_2_third": "saeculi XI secunda tertiarum (10xx_2_third)",
  "11xx_1_third": "saeculi XII prima tertiarum (11xx_1_third)",
  "12xx_1_third": "saeculi XIII prima tertiarum (12xx_1_third)",
  "11xx_2_third": "saeculi XII secunda tertiarum (11xx_2_third)",
  "10xx_3_third": "saeculi XI tertia tertiarum (10xx_3_third)",
  "13xx_1_third": "saeculi XIV prima tertiarum (13xx_1_third)",
  "12xx_2_third": "saeculi XIII secunda tertiarum (12xx_2_third)",
  "11xx_3_third": "saeculi XII tertia tertiarum (11xx_3_third)",
  "13xx_2_third": "saeculi XIV secunda tertiarum (13xx_2_third)",
  "12xx_3_third": "saeculi XIII tertia tertiarum (12xx_3_third)",
  "14xx_1_third": "saeculi XV prima tertiarum (14xx_1_third)",
  "15xx_1_third": "saeculi XVI prima tertiarum (15xx_1_third)",
  "14xx_2_third": "saeculi XV secunda tertiarum (14xx_2_third)",
  "13xx_3_third": "saeculi XIV tertia tertiarum (13xx_3_third)",
  "16xx_1_third": "saeculi XVII prima tertiarum (16xx_1_third)",
  "15xx_2_third": "saeculi XVI secunda tertiarum (15xx_2_third)",
  "14xx_3_third": "saeculi XV tertia tertiarum (14xx_3_third)"
};


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
  element td { croalabro-html:link("genus/" || $s,count($a)) }
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
  element td { croalabro-html:link("genus/" || $s,count($a)) }
}
};

(: for a genre and a type provide doc count and list of doc names :)

declare function croalabro:dagenus($genus){
let $result :=
for $a in db:open($croalabro:db)//*:teiHeader//*:keywords[@scheme=("genre","typus")]/*:term[.=$genus]
let $path := db:path($a)
let $basepath := substring-before($path, ".xml")
return element tr {
  element td { croalabro-html:link(("/static/croala-html/" || $basepath || ".html" ), $basepath) }
}
return element r {
  element span { $genus },
    element span { count($result) },
    element span { $result }
}
};

(: table of periods with doc counts :)

declare function croalabro:tabulatemporum(){
for $a in db:open($croalabro:db)//*:teiHeader//*:creation/*:date
let $s := $a/@period/string()
group by $s
order by $s
return element tr {
  element td { map:get($croalabro:periodi , $s) },
  element td { croalabro-html:link("periodus/" || $s,count($a)) }
}
};

(: for a period provide doc count and list of doc names :)

declare function croalabro:daperiodum($period){
let $result :=
for $a in db:open($croalabro:db)//*:teiHeader//*:creation/*:date[@period=$period]
let $path := db:path($a)
let $basepath := substring-before($path, ".xml")
return element tr {
  element td { croalabro-html:link(("/static/croala-html/" || $basepath || ".html" ), $basepath) }
}
return element r {
  element span { map:get($croalabro:periodi , $period) },
    element span { count($result) },
    element span { $result }
}
};