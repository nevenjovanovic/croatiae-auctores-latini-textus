(: CroALaBro index metrorum lyricorum Horatianorum :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: index metrorum lyricorum Horatianorum';
declare variable $subtitle := 'Metrum elige ut in eiusmodi versibus quaeras. Numerum elige ut indiculum carminum hoc metro scriptorum videas.';
declare variable $content := "Display list of Horatian lyric meters in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, meter, versification, Horace, Horatius, lyric";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("metra-horatiana")
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


  function page:croalabrometrahoratiana()
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

{ croalabro-html:table (("Metrum", "Quot carmina", "Tituli" ), croalabro:tabulahoratiana()) }
</div>
</div>

{ croalabro-html:footertable() }
</div>
</body>
</html>
};

return


