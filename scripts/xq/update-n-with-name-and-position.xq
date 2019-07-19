(: for an individual TEI XML file :)
(: to each element under TEI/text, add @n with name of element and position number :)
(: if the element is the only sibling with that name, skip position number :)
declare namespace functx = "http://www.functx.com";
declare function functx:index-of-node
  ( $nodes ,
    $nodeToFind ) {

  for $seq in (1 to count($nodes))
  return $seq[$nodes[$seq] is $nodeToFind]
 } ;
declare function functx:node-with-pos
  ( $node ) {
  let $sibsOfSameName := $node/../*[name() = name($node)]
  let $sibscount := count($sibsOfSameName)
  return if ($sibscount > 1) then name($node) ||
  functx:index-of-node($sibsOfSameName,$node)
  else name($node)
 } ;
declare variable $doc := "/home/neven/Repos/croalatxt/txts/feric-d-fab.xml";
copy $cr := doc($doc)
modify (
for $e in $cr//*:TEI/*:text//*
let $n := functx:node-with-pos($e)
return if ($e/@n) then replace value of node $e/@n with $n
else insert node attribute n { $n } into $e
)
return file:write($doc, $cr)
(: return $cr :)