(: CroALaBro quaere quodcumque de vocabulis :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere quodcumque de vocabulis';
declare variable $subtitle := 'De vocabulis datis quodcumque inventum ostende; inventa chronologico ordine afferuntur';
declare variable $content := "Search in CroALa for any word from the set of given words.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("qqcumque")
  %rest:query-param("qqc", "{$qqc}")
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


  function page:croalabroquaereqqc($qqc)
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
<h4 class="text-center">{ "Quaeris: " || $qqc || ". Inventum: " || croalabro:qqcfound($qqc)/tr[1]/string() } </h4>
<p class="text-center">{ "Formae: " || croalabro:qqcfound($qqc)/tr[2] } </p>
</div>
</div>
  <!-- function here -->

{ croalabro-html:trtodiv2(
croalabro:qqcfound($qqc)/tr[3]
) }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


