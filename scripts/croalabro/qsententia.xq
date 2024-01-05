(: CroALaBro quaere vocabulum fuzzy :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere plura vocabula in eadem sententia';
declare variable $subtitle := 'Omnia vocabula debent in eadem sententia esse; inventa chronologico ordine afferuntur';
declare variable $content := "Search for all words (literal) in the same sentence in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search, sentence, all words";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("qsententia")
  %rest:query-param("vvsent", "{$vvsent}")
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


  function page:croalabroquaeresententia($vvsent)
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
<h4 class="text-center">{ "Quaeris: " || $vvsent || ". Inventum: " || croalabro:sentfound($vvsent)/tr[1] } </h4>
<p class="text-center">{ "Formae: " || croalabro:sentfound($vvsent)/tr[2] } </p>
</div>
</div>
  <!-- function here -->

{ croalabro-html:trtodiv2(
croalabro:sentfound($vvsent)/tr[3]
) }


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


