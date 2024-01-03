for $a in db:get("croalatextus")//*:teiHeader/*:fileDesc/*:titleStmt/*:author/*[name()=("orgName","persName")][1]
let $wikidata := $a/../@ref/string()
return if(matches($wikidata, "http://www.wikidata.org/entity/")) then $wikidata else ()