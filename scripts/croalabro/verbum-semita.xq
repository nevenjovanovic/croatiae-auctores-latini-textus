(: CroALaBro search for word, return URL path :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: verbi URL';
declare variable $subtitle := '';
declare variable $content := "Search for a word, return the URL of its element, making it citable.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, citation, URL, search";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("verbi-semita/{$verbum}")
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


  function page:croalabroverbisemita($verbum)
{
  (: HTML template starts here :)

<html>
{ croalabro-html:htmlheadhighlight($title, $content, $keywords) }
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
<h3 class="text-center">{ "Verbum: " || $verbum || "; quoties inventum: " ||  count(croalabro:wordpath($verbum)/tr) || "." }</h3>
</div>
</div>
  <!-- function here -->

{ croalabro-html:urlpathtable(croalabro:wordpath($verbum)) }


{ croalabro-html:footerserver() }
	</div>
</body>
</html>
};

return


