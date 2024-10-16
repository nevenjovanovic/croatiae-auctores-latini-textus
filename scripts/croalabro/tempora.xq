(: CroALaBro index auctorum, operum, generum, temporum :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: index temporum';
declare variable $subtitle := 'Tempus elige ut in eo periodo quaeras. Numerum elige ut indiculum documentorum videas.';
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
<p class="text-center">{ $subtitle }</p>
</div>
</div>
<div class="row">
<div  class="col text-center">
  <!-- function here -->

{ croalabro-html:table (("Tempus", "Quot documenta" ), croalabro:tabulatemporum()) }
</div>
</div>

{ croalabro-html:footertable() }
</div>
</body>
</html>
};

return


