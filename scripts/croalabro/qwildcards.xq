(: CroALaBro quaere vocabulum fuzzy :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere vocabula modo wildcards';
declare variable $subtitle := 'Quaere litteris signorum vice notatis; inventa chronologico ordine afferuntur';
declare variable $content := "Wildcard search for words in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search, wildcards";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("qwildcards")
  %rest:query-param("vwc", "{$vwc}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)


  function page:croalabroquaerewc($vwc)
{
  (: HTML template starts here :)

<html>
{ croalabro-html:htmlheadserver($title, $content, $keywords) }

<body>

<div class="container">
<div  class="row">
<div  class="col">
<h1 class="text-center">{ $title }</h1>
</div>
</div>
<div  class="row">
<div  class="col">
<p class="text-center">{ $subtitle }</p>
<h4 class="text-center">{ "Quaeris: " || $vwc || ". Inventum: " || croalabro:wcfound($vwc)/tr[1]/string() } </h4>
<p class="text-center">{ "Formae: " || croalabro:wcfound($vwc)/tr[2] } </p>
</div>
</div>
  <!-- function here -->

{ croalabro-html:trtodiv2(
croalabro:wcfound($vwc)/tr[3]
) }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


