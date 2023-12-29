(: CroALaBro index auctorum, operum, generum, temporum :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini';
declare variable $subtitle := 'Index typorum et generum';
declare variable $content := "Display list of types (prose, poetry) and genres in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, genre";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("genera")
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


  function page:croalabrogenera()
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
<h3 class=" text-center">Index typorum</h3>
<div class="row">

<div  class="col text-center">
  <!-- function here -->

{ croalabro-html:table (("Typus", "Quot documenta" ), croalabro:tabulatyporum()) }
</div>
</div>
<h3 class=" text-center">Index generum</h3>
<div class="row">

<div  class="col text-center">
  <!-- function here -->

{ croalabro-html:table (("Genus", "Quot documenta" ), croalabro:tabulagenerum()) }
</div>
</div>

{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


