(: CroALaBro quaere vocabula in dato metro :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere vocabula in dato metro';
declare variable $subtitle := 'Inventa chronologico ordine afferuntur';
declare variable $content := "Search in CroALa poems in a given metre.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search, metre, all words";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("metrum-q/{$metrum}/qmet1")
  %rest:query-param("qmetverbum", "{$qmetverbum}")
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


  function page:croalabroquaeredatometro($qmetverbum, $metrum)
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

</div>
</div>
  <!-- function here -->

	{
			croalabro:metrum1found($qmetverbum, $metrum)

 }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


