(: given a url-like address, open a node in the db :)
declare function local:getelem($urlpath, $db){
  if (contains($urlpath, ".xml/TEI")) then
  let $url := substring-after($urlpath, ".xml")
  let $qurl := replace($url, "/", "/Q{http://www.tei-c.org/ns/1.0}")
  let $docname := substring-before($urlpath,"/TEI")
  let $result := xquery:eval($qurl, map { '': db:get($db, $docname) })
  return if (exists($result)) then local:catcherr($result)
  else "URL not found in CroALa!"
  else "Not a valid CroALa URL."
};
(: catch errors :)
declare function local:catcherr($result) {
  try { $result }
  catch err:XPST0003 { "Not a valid URL. " || $err:description }
  catch * {
  'Error [' || $err:code || ']: ' || $err:description
}
};
let $addr0 := "/TEI/Drunken"
let $addr := "/TEI[1]/text[1]/body[1]/div[8]"
let $naddr := replace($addr, "/", "/Q{http://www.tei-c.org/ns/1.0}")
let $qaddr := "/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/Q{http://www.tei-c.org/ns/1.0}body[1]/Q{http://www.tei-c.org/ns/1.0}div[8]/Q{http://www.tei-c.org/ns/1.0}div[1]/Q{http://www.tei-c.org/ns/1.0}l[36]"
let $docname := "marul-mar-dauid.xml"
let $urladdr := $docname || $addr
let $db := "croalatextus"
return element tr {
  element td { $urladdr },
  element td { local:getelem("m", $db) }
}