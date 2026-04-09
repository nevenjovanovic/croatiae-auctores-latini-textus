(: CroALaBro quaere in metro dato :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaere in carminibus metro dato scriptis';
declare variable $subtitle := '';
declare variable $content := "Search in poems in a given metre in CroALa.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, meter, search";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("metrum-q/{$metrum}")
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


  function page:croalabrometrumq($metrum)
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
<h3 class="text-center">{ "Metrum: " || $metrum }</h3>
</div>
</div>
<div class="row">
<div  class="col text-center">
  <!-- function here -->

{ croalabro-html:searchform0( "qmet1" , "qmetverbum" , "Quaere in versibus hoc metro scriptis: ", $metrum ) }
</div>
	</div>

	<div class="row">
<div  class="col">
  <!-- function here -->

	{ croalabro-html:searchinfowc() }	

</div>
</div>


{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


