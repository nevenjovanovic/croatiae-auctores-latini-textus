(: recur to make centuries and their thirds :)
let $list := element l {
for $x in 10 to 19
for $y in 1 to 3
return element trl { element s { $x || "xx_" || $y || "_third" },
element la { 
( if ($x=10) then "saeculi XI" 
else if ($x=11) then "saeculi XII"
else if ($x=12) then "saeculi XIII"
else if ($x=13) then "saeculi XIV"
else if ($x=14) then "saeculi XV"
else if ($x=15) then "saeculi XVI"
else if ($x=16) then "saeculi XVII"
else if ($x=17) then "saeculi XVIII"
else if ($x=18) then "saeculi XIX"
else if ($x=19) then "saeculi XX"
else() )
|| " " ||
( if ($y=1) then "prima tertiarum"
else if ($y=2) then "secunda tertiarum"
else if ($y=3) then "tertia tertiarum" ) 
|| " (" ||
( $x || "xx_" || $y || "_third" )
|| ")"
}
}
}
let $saecmap := map:merge( 
for $l in $list//trl return map:entry($l/s, $l/la/string() ) )

return $saecmap