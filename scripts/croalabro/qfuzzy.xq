(: CroALaBro quaere vocabulum fuzzy :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere vocabula modo fuzzy';
declare variable $subtitle := 'Quaere etiam erroribus permissis; inventa chronologico ordine afferuntur';
declare variable $content := "Fuzzy search for words in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search, fuzzy";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("qfuzzy")
  %rest:query-param("vfuzzy", "{$vfuzzy}")
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


  function page:croalabroquaerefuzzy($vfuzzy)
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
croalabro:qfuzzysec($vfuzzy)
 }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


