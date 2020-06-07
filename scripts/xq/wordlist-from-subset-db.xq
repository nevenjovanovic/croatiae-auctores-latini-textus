(: create a wordlist :)
(: use the croalatextussubsetdb :)
(: disregard the @ana=editorial :)
(: disregard numbers :)
(: treat capitals and accented letters as such :)
let $tokens :=
for $w in collection("croalatextussubset")//*:text//text()[not(ancestor::*[@ana="editorial"])]
let $text := normalize-space(string-join($w , " "))
return tokenize($text, '\W+')
let $list := 
for $t in distinct-values($tokens)
where not(matches($t, '[❦+=0-9 ]'))
order by $t
return $t
return $list