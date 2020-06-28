declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare function local:copy-nodes-filter-text($element) {
  if ($element[@ana="editorial" or name()="g"]) then $element
  else element { node-name($element) }
             { $element/@*,
               for $child in $element/node()
               return if (not($child/self::text()))
                    then local:copy-nodes-filter-text($child)
                    else for $c in tokenize($child, "\s+") return local:tokenize-words-pc($c)
           }
 };
declare function local:copy-nodes-filter-supplied($element) {
  if ($element[name()="supplied"]) then $element/text()
  else element { node-name($element) }
             { $element/@*,
               for $child in $element/node()
               return if (not($child/self::text()))
                    then local:copy-nodes-filter-supplied($child)
                    else for $c in tokenize($child, "\s+") return $c
           }
 };
(: tokenize string ending with punctuation into characters and punctuation :)
declare function local:tokenize-words-pc($token){
  for $part in analyze-string($token, '\w+')/*
   return  if ($part/name()="fn:match") then element w { $part/string()}
      else element pc { $part/string()}
};

for $xml_nodeset in db:open("croalatextussubset")//*:text
return replace node $xml_nodeset with local:copy-nodes-filter-text(local:copy-nodes-filter-supplied($xml_nodeset))
(: return local:copy-nodes-filter-text($xml_nodeset) :)