(: CroALaBro index auctorum, operum, generum, temporum :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini';
declare variable $subtitle := 'Index temporum';
declare variable $content := "Display list of periods in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, period";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("tempora")
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


  function page:croalabrotempora()
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
<h2 class="text-center">{ $subtitle }</h2>
</div>
</div>
<div class="row">
<div  class="col text-center">
  <!-- function here -->

{ croalabro-html:table (("Tempus", "Quot documenta" ), croalabro:tabulatemporum()) }
</div>
</div>

{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return

