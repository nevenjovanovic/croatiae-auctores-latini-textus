(: CroALaBro quaere vocabulum simplex :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini';
declare variable $subtitle := 'Quaere vocabula modo simplici';
declare variable $content := "Search for words, literal, in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("quaere")
  %rest:query-param("verbum", "{$verbum}")
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


  function page:croalabroquaere($verbum)
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
<h3 class="text-center">{ "Quaeris: " || $verbum || ". Inventum: " || count(croalabro:quaere($verbum)) }</h3>
</div>
</div>
  <!-- function here -->

{ croalabro-html:trtodiv(
croalabro:nihil(
croalabro:quaere($verbum)
)
) }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


