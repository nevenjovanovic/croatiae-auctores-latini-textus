for $n in //*:text//*
let $name := $n/name()
group by $name
order by count($n) , $name
return element tr {
  element td {
    $name
  },
  element td {
    count($n)
  }
}