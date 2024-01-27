(: find divs which have l but no @met :)
distinct-values(
let $db := "croalatextus"
for $met in db:get($db)//*:text//*:div[not(@met) and *:l]
let $p := db:path($met)
order by $p
return $p)