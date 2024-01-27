for $list in distinct-values(
  for $n in //*/name()
return $n
)
order by $list
return $list