(: XQuery module for CroALaBRO :)
module namespace croalabro = 'http://croala.ffzg.unizg.hr/croalabro';
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "croalabro-html.xqm";
import module namespace croalabro-config = "http://croala.ffzg.unizg.hr/croalabro-config" at "croalabro-config.xqm";
import module namespace  functx = "http://www.functx.com" at "functx.xq";

(: declare variable $croalabro:croalaurl := "https://croala.ffzg.unizg.hr/cdb/static/croala-html/"; :)

declare variable $croalabro:teiprefix := "Q\{http://www.tei-c.org/ns/1.0\}";

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

(: remove .xml from filename :)

declare function croalabro:basepath($path){
  substring-before($path, ".xml")
};

declare function croalabro:filepath($set){
  for $d in $set
  let $docname := db:path($d)
  let $docurl := $croalabro-config:croalaurl || croalabro:basepath( $docname ) || ".html"
  let $giturl := "https://github.com/nevenjovanovic/croatiae-auctores-latini-textus/blob/master/txts/" || $docname
  return if ($set[2]) then ( 
croalabro-html:link($docurl, croalabro:basepath($docname)),
" ",
croalabro-html:linktag( $giturl, "TEI XML" ) ,
element br {})
else ( croalabro-html:link($docurl, croalabro:basepath($docname)),
" ",
croalabro-html:linktag( $giturl, "TEI XML" )
)
};

(: table of authors :)

declare variable $croalabro:urn := "http://localhost:8080/";
declare variable $croalabro:db := "croalatextus";

declare function croalabro:tabulaauctorum() {
	for $a in db:get($croalabro:db)//*:teiHeader/*:fileDesc/*:titleStmt/*:author/*[name()=("orgName","persName")][1]
	let $wikidata := $a/../@ref/string()
let $s := normalize-space($a)
group by $s
order by $s collation "?lang=hr"
return element tr {
		element td { if (matches($wikidata[1], "http://www.wikidata.org/entity/")) then
			( croalabro-html:link(("auctor-q/" || substring-after($wikidata[1], "http://www.wikidata.org/entity/") ),$s) ,
				element br {} ,
				croalabro-html:link($wikidata[1],
					croalabro-html:wikidata(substring-after($wikidata[1], "http://www.wikidata.org/entity/") )
					) ) else
			croalabro-html:link(("auctor-q/" || $wikidata[1]),$s)
		},
  element td { attribute class { "text-center" } , count($a) },
  element td { croalabro:filepath($a) }
}

};

(: table of works :)

declare function croalabro:tabulaoperum() {

for $a in db:open($croalabro:db)//*:teiHeader/*:fileDesc/*:titleStmt/*:title[1]
let $s := normalize-space($a)
order by $s collation "?lang=hr"
return element tr {
  element td { $s },
  element td { croalabro:wordcount(db:path($a)) },
  element td { croalabro:filepath($a) }
}
};

(: read word counts from the secondary db :)

declare function croalabro:wordcount($docname){
  db:get("croalatextus-wc")//*:doc[@title=$docname]/@wc/string()
};

(: table of types, with doc counts :)

declare function croalabro:tabulatyporum() {
for $a in db:open($croalabro:db)//*:teiHeader//*:keywords[@scheme="typus"]/*:term
let $s := normalize-space($a)
group by $s
order by count($a) descending
return element tr {
  element td { croalabro-html:link( "genus-q/" || $s ,  $s ) },
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
  element td { croalabro-html:link( "genus-q/" || $s ,  $s ) },
  element td { croalabro-html:link("genus/" || $s,count($a)) }
}
};

(: for a genre and a type provide doc count and list of doc names :)

declare function croalabro:dagenus($genus){
let $result :=
for $a in db:open($croalabro:db)//*:teiHeader//*:keywords[@scheme=("genre","typus")]/*:term[.=$genus]
let $path := db:path($a)
let $basepath := croalabro:basepath($path)
return element tr {
  element td { croalabro-html:link(($croalabro-config:croalaurl || $basepath || ".html" ), $basepath) }
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
  element td { croalabro-html:link( "periodus-q/" || $s ,  map:get($croalabro:periodi , $s)) },
  element td { croalabro-html:link("periodus/" || $s,count($a)) }
}
};

(: for a period provide doc count and list of doc names :)

declare function croalabro:daperiodum($period){
let $result :=
for $a in db:open($croalabro:db)//*:teiHeader//*:creation/*:date[@period=$period]
let $path := db:path($a)
let $basepath := croalabro:basepath($path)
return element tr {
  element td { croalabro-html:link(($croalabro-config:croalaurl || $basepath || ".html" ), $basepath) }
}
return element r {
  element span { map:get($croalabro:periodi , $period) },
    element span { count($result) },
    element span { $result }
}
};

(: for search, return three fields: title, first author, creation date :)

declare function croalabro:titleauthor($path){
  let $tstmt := db:get($croalabro:db, $path)//*:teiHeader
  return (
     element h4 { normalize-space($tstmt/*:fileDesc/*:titleStmt/*:title[1]) } ,
     $tstmt/*:fileDesc/*:titleStmt/*:author[1] ,
     $tstmt/*:profileDesc[1]/*:creation/*:date[1]
)
};

(: select and format beginning and end for the URL text fragment :)

declare function croalabro:textfrag($string) {
if (string-length($string) > 100)
	then web:encode-url(
		functx:substring-before-last(
			replace(substring($string, 1, 45), "^ +", ""), " "
		)
	)
	|| ","
	|| web:encode-url(
		substring-after(
			normalize-space(
				substring($string, string-length($string) - 45, 45)
				), " "
		)
	)
		else web:encode-url(normalize-space($string))
};

(: if there are special characters from the string, inform that wildcards are not permitted  :)

declare function croalabro:qsec($string){
	if (matches($string, "[.+?*]")) then let $message := "WILDCARDS non permittuntur in hac quaestione." return croalabro-html:zerosec($message)
	else croalabro:nihil(croalabro:quaere($string))
};


(: search fulltext, simple - literal word, return rows with six cells  :) 
(: td cells: 1 file name, 2 title, 3 first author, 4 creation date, 5 div heads, 6 search result :)

declare function croalabro:quaere($word){
for $n in ft:search($croalabro:db, $word )
	let $path := db:path($n)
	let $fragment := croalabro:textfrag($n)
	let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
	let $title := string-join($n/ancestor::*:div/*:head, " > ")
	let $url :=  $croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html" || "#:~:text=" || replace($fragment, "\++", " ")
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:linkfrag($url, croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { ft:mark($n[. contains text { $word }]) }
}

};

(: fuzzy: if there are special characters from the string, inform that wildcards are not permitted  :)

declare function croalabro:qfuzzysec($string){
	if (matches($string, "[.+?*]")) then let $message := "WILDCARDS non permittuntur in hac quaestione." return croalabro-html:zerosec($message)
	else croalabro:fuzzyfound($string)
};

(: perform fuzzy search, return distinct values found with fuzzy, report if 0 hits :)

declare function croalabro:fuzzyfound($word) {
let $q := croalabro:quaerefuzzy($word)
let $found := string-join(distinct-values($q/td[6]/mark/string()), ", ")
let $qcount := count($q)
return if ($qcount=0) then croalabro-html:zero2()
else ( element div {
	attribute class { "row"},
	element div {
		attribute class { "col"},
	element h4 {
		attribute class { "text-center"},
		( "Quaeris: " || $word || ". Inventum: " || $qcount )
		},
		element p {
			attribute class { "text-center"},
			( "Formae: " || $found )
		}
	}
	},
croalabro-html:trtodiv2(
			element tr { $q }
			)
 )
};

(: fuzzy search :)

declare function croalabro:quaerefuzzy($word){
for $n in ft:search($croalabro:db, $word , map {
  "fuzzy": true()
  })
let $path := db:path($n)
let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
let $title := string-join($n/ancestor::*:div/*:head, " > ")
let $marked := ft:mark($n[. contains text { $word } using fuzzy ])
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}
};

(: wildcards search :)

declare function croalabro:quaerewc($word){
for $n in ft:search($croalabro:db, $word , map {
  "wildcards": true()
  })
let $path := db:path($n)
let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
let $title := string-join($n/ancestor::*:div/*:head, " > ")
let $marked := ft:mark($n[. contains text { $word } using wildcards ])
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}
};

(: search for all words in the same sentence, in any order :)

declare function croalabro:quaeresent($word){
	for $n in ft:search($croalabro:db, $word , map {
   "mode": "all words",
   "scope": map { "same": true(),
		  "unit": "sentence"}			
  })
let $path := db:path($n)
let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
let $title := string-join($n/ancestor::*:div/*:head, " > ")
let $marked := ft:mark($n[. contains text { $word } all words same sentence ])
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}
};

(: search for words at specified distance :)

declare function croalabro:quaeredist($word, $dist){
	for $n in ft:search($croalabro:db, $word , map {
			  "mode": "all words",
  "distance": map { "max": $dist }
  })
let $path := db:path($n)
let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
let $title := string-join($n/ancestor::*:div/*:head, " > ")
let $marked := ft:mark($n[. contains text { $word } all words distance at most $dist words ])
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}
};





(: perform wildcards search, return distinct values found with wildcards, report if 0 hits :)

declare function croalabro:wcfound($word) {
let $q := croalabro:quaerewc($word)
let $found := distinct-values($q/td[6]/mark/string())
let $qcount := count($q)
return if ($qcount=0) then croalabro-html:zero2()
else element div {
  element tr { $qcount },
  element tr { $found },
  element tr { $q }
}
};

(: search for any word :)

declare function croalabro:quaereqqc($words){
for $n in ft:search($croalabro:db, $words , map {
  "mode": "any word"
  })
let $path := db:path($n)
let $date := db:get($croalabro:db, $path)//*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period
let $title := string-join($n/ancestor::*:div/*:head, " > ")
let $marked := ft:mark($n[. contains text { $words } any word ])
order by $date , $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}
};


(: perform search for any word, return distinct values found, report if 0 hits :)

declare function croalabro:qqcfound($word) {
let $q := croalabro:quaereqqc($word)
let $found := distinct-values($q/td[6]/mark/string())
let $qcount := count($q)
return if ($qcount=0) then croalabro-html:zero2()
else element div {
  element tr { $qcount },
  element tr { $found },
  element tr { $q }
}
};

(: perform search for all words in same sentence, format result, report if zero :)

declare function croalabro:sentfound($word) {
let $q := croalabro:quaeresent($word)
let $found := distinct-values($q/td[6]/mark/string())
let $qcount := count($q)
return if ($qcount=0) then croalabro-html:zero2()
else element div {
  element tr { $qcount },
  element tr { $found },
  element tr { $q }
}
};

declare function croalabro:distfound($word, $dist) {
	if (number($dist)) then
let $q := croalabro:quaeredist($word, $dist)
let $qcount := count($q)
return if ($qcount=0) then croalabro-html:zero2()
	else ( element div {
	attribute class { "row"},
	element div {
		attribute class { "col"},
	element h4 {
		attribute class { "text-center"},
		( "Quaeris: " || $word || ", per plurimum " || $dist || " distantia. Inventum: " || $qcount )
		}
	}
	},
croalabro-html:trtodiv(
			element tr { $q }
			)
 )
	else let $message := "Numerum quaeso adde verborum interpositorum." return croalabro-html:zerosec($message)
};

(: search in a given period, use wildcards :)

declare function croalabro:quaereperiod1($qpverbum, $period) {
	for $n in db:get($croalabro:db)/*:TEI[*:teiHeader/*:profileDesc[1]/*:creation/*:date[1]/@period/string()=$period]/*:text//*[not(*)]
	where ft:contains($n, $qpverbum, map { 'wildcards': true() })
	let $path := db:path($n)
	let $title := string-join($n/ancestor::*:div/*:head, " > ")
	let $marked := ft:mark($n[text() contains text { $qpverbum } using wildcards ])
	order by $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}

	};

declare function croalabro:period1found($qpverbum, $period) {
	let $q := croalabro:quaereperiod1($qpverbum, $period)
	let $found := distinct-values($q//*:mark/string())
	let $qcount := count($q)
	return if ($qcount=0) then croalabro-html:zero2()
	else (
		element div {
			attribute class { "row"},
			element div {
				attribute class { "col"},
				element h4 {
					attribute class { "text-center"},
					( "Quaeris: " || $qpverbum || " in periodo " || $period ||
						". Inventum: " || $qcount ||
					". Formae: " || string-join($found, ", ") || ".")
		}
	}
	},
croalabro-html:trtodiv2(
			element tr { $q }
			)
 )
};

(: search in a given genre, use wildcards :)

declare function croalabro:quaeregenus1($qgverbum, $genus) {
	for $n in db:get($croalabro:db)/*:TEI[*:teiHeader/*:profileDesc[1]/*:textClass/*:keywords[@scheme=("genre","typus")]/*:term[.=$genus]]/*:text//*[not(*)]
	where ft:contains($n, $qgverbum, map { 'wildcards': true() })
	let $path := db:path($n)
	let $title := string-join($n/ancestor::*:div/*:head, " > ")
	let $marked := ft:mark($n[text() contains text { $qgverbum } using wildcards ])
	order by $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
}

};

declare function croalabro:genus1found($qgverbum, $genus) {
	let $q := croalabro:quaeregenus1($qgverbum, $genus)
	let $found := distinct-values($q//*:mark/string())
	let $qcount := count($q)
	return if ($qcount=0) then croalabro-html:zero2()
	else (
		element div {
			attribute class { "row"},
			element div {
				attribute class { "col"},
				element h4 {
					attribute class { "text-center"},
					( "Quaeris: " || $qgverbum || " in genere " || $genus ||
						". Inventum: " || $qcount ||
					". Formae: " || string-join($found, ", ") || ".")
		}
	}
	},
croalabro-html:trtodiv2(
			element tr { $q }
			)
 )
};

(: author refs -- test if Wikidata or not :)

declare function croalabro:testwd($author){
	if (starts-with($author, "Q")) then ("http://www.wikidata.org/entity/" || $author)
	else if ($author) then ($author)
	else()
	};

(: search in works of a given author :)
(: first test if there is an author with that ref :)

declare function croalabro:quaereauthor1($qaverbum, $author) {
	let $sauthor := croalabro:testwd($author)
	return if (db:get($croalabro:db)/*:TEI/*:teiHeader/*:fileDesc/*:titleStmt/*:author/@ref=$sauthor) then
	for $n in db:get($croalabro:db)/*:TEI[*:teiHeader/*:fileDesc/*:titleStmt/*:author/@ref=$sauthor]/*:text//*[not(*)]
	where ft:contains($n, $qaverbum, map { 'wildcards': true() })
	let $path := db:path($n)
	let $title := string-join($n/ancestor::*:div/*:head, " > ")
	let $marked := ft:mark($n[text() contains text { $qaverbum } using wildcards ])
	order by $path
return element tr { 
element td {  
croalabro-html:formathithead(
croalabro-html:link(($croalabro-config:croalaurl || croalabro:basepath( $path ) || ".html"), croalabro:basepath($path))
)
},
for $e in croalabro:titleauthor($path) return element td { $e } ,
element td { $title },
element td { $marked }
	}
	else ( "N/A" )

};

declare function croalabro:author1found($qaverbum, $author) {
	let $q := croalabro:quaereauthor1($qaverbum, $author)
	return if ($q = "N/A") then croalabro-html:zerosec("Auctoris nota: " || $author || " – non inventum in CroALa!")
	else
	let $found := distinct-values($q//*:mark/string())
	let $qcount := count($q)
	return if ($qcount=0) then croalabro-html:zerosec("Quaeris: " || $qaverbum || ", sed non occurrit apud auctorem " || $author || "!")
	else (
		element div {
			attribute class { "row"},
			element div {
				attribute class { "col"},
				element h4 {
					attribute class { "text-center"},
					( "Quaeris: " || $qaverbum || " in auctore " || $author ||
						". Inventum: " || $qcount ||
					". Formae: " || string-join($found, ", ") || ".")
		}
	}
	},
croalabro-html:trtodiv2(
			element tr { $q }
			)
 )
};

(: list all editors, sort alphabetically, give Wikidata or viaf link if present :)

declare function croalabro:editores(){
	for $ed in distinct-values(
	for $e in db:get($croalabro:db)/*:TEI/*:teiHeader/*:fileDesc/*:titleStmt/*:editor
	let $ref := $e/@ref/string()
	let $name := $e//string()
		return ($ref , $name)
	)
	order by $ed
	return $ed
	};

(: for a given author ref, return name :)

declare function croalabro:author-name($auctorref){
	let $a := $auctorref
	let $qname := if (starts-with($a, "Q")) then ("http://www.wikidata.org/entity/" || $a) else $a
	let $name := db:get($croalabro:db)/*:TEI/*:teiHeader/*:fileDesc/*:titleStmt/*:author[@ref=$qname]/*:persName[1]/string()
	return element span { $name[1] || " (" || $a || ")" }
	};


(: check if search returned 0 hits :)
declare function croalabro:nihil($result){
let $qcount := count($result)
return if ($qcount=0) then croalabro-html:zero()
else $result
};

(: catch errors :)
declare function croalabro:catcherr($result) {
  try { $result }
  catch err:XPST0003 { "Not a valid URL. " || $err:description }
  catch * {
  'Error [' || $err:code || ']: ' || $err:description
}
};

(: for a word, return URL-like path. If not in CroALa, report. :)

declare function croalabro:wordpath($word){
	let $found := db:get($croalabro:db)//*:text//*[text() contains text { $word } ]
	return if ($found) then
	element pre {
for $occ in $found
let $p := path($occ)
		let $docname := db:path($occ)
		let $period := db:get($croalabro:db, $docname)//*:teiHeader//*:profileDesc[1]/*:creation[1]/*:date[1]/@period
		let $cp := $docname || replace($p, $croalabro:teiprefix, "")
		order by $period
	return element tr {
		element td { $cp },
		element td { ft:mark($occ[text() contains text { $word } ]) }
	} }
		else element span { "In CroALa non est inventum!" }
		
	};

(: for a given URL, return db node. If not in CroALa, report. :)

declare function croalabro:getelem($urlpath){
	if (contains($urlpath, ".xml/TEI")) then
	let $url := substring-after($urlpath, ".xml")
	let $qurl := replace($url, "/", "/Q{http://www.tei-c.org/ns/1.0}")
	let $docname := substring-before($urlpath,"/TEI")
  let $result := xquery:eval($qurl, map { '': db:get($croalabro:db, $docname) })
  return if (exists($result)) then croalabro:catcherr($result)
	else "URL in CroALa non inventum (URL not found in CroALa)!"
	else "URL in CroALa non valere videtur (URL seems to be not valid in CroALa)."
};