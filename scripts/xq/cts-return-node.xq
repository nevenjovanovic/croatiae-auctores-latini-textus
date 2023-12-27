(: return w nodes from their ids :)
import module namespace functx = 'http://www.functx.com';
declare function local:nodefromurl($url){
let $id := functx:substring-after-last($url, ":")
let $result := db:open-id("croalatextussubsettokenized", xs:integer($id))
return $result
};
declare function local:context10url($url){
let $id := functx:substring-after-last($url, ":")
for $r in (xs:integer($id) - 10) to (xs:integer($id) + 10)
let $result := db:open-id("croalatextussubsettokenized", $r)
where $result/name()=("w","pc")
return $result
};
declare function local:rangefromurl($url){
let $id := tokenize($url, "-")
for $r in xs:integer($id[1]) to xs:integer($id[2]) 
let $node := db:open-id("croalatextussubsettokenized", $r)
where $node[name()="w"]
return $node
};
let $urns := ("urn:cts:croala:milasinovic316482471.viator974968.croala-lat2:214524",
"urn:cts:croala:milasinovic316482471.viator974968.croala-lat2:214533",
"urn:cts:croala:milasinovic316482471.viator974968.croala-lat2:214536",
"urn:cts:croala:milasinovic316482471.viator974968.croala-lat2:214539",
"urn:cts:croala:milasinovic316482471.viator974968.croala-lat2:214533-214600")
for $u in $urns[1] 
let $result := local:context10url($u)
return $result