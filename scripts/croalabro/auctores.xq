(: CroALaBro index auctorum, operum, generum, temporum :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini';
declare variable $subtitle := 'Index auctorum';
declare variable $content := "Display list of authors and their works.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, authors";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("auctores")
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


  function page:croalabroauctores()
{
  (: HTML template starts here :)

<html>
{ croalabro-html:htmlheadserver($title, $content, $keywords) }
<body>
<div class="container">
<div  class="row">
<div  class="col">
<h1 class=" text-center">{ $title }</h1>
</div>
</div>
<div  class="row">
<div  class="col">
<h2 class=" text-center">{ $subtitle }</h2>
</div>
</div>
<div  class="row">
<div  class="col">
<h3 class=" text-center">{ "Auctores: " || count(croalabro:tabulaauctorum()) }</h3>
</div>
</div>
<div class="row">
<div  class="col text-center">
  <!-- function here -->
{ croalabro-html:table (("Auctor", "Quot documenta", "Nomina documentorum"), croalabro:tabulaauctorum()) }
</div>
</div>

{ croalabro-html:footertable() }
</div>
</body>
</html>
};

return


