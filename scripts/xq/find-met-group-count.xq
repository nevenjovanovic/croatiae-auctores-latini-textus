let $db := "croalatextus"
for $met in db:get($db)//*:text//*:div/@met
let $m := $met/string()
group by $m
order by $m
return element tr {
  element td { $m },
  element td { count($met) }
}