(: CroALaBro quaere vocabulum simplex :)

import module namespace croalabro = "http://croala.ffzg.unizg.hr/croalabro" at "../../repo/croalabro.xqm";
import module namespace croalabro-html = "http://croala.ffzg.unizg.hr/croalabro-html" at "../../repo/croalabro-html.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Croatiae auctores Latini: quaestiones';
declare variable $subtitle := 'Quaere vocabula multis modis: fuzzy, wildcards, distantia, in sententia';
declare variable $content := "Search for words in CroALa in several advanced ways: fuzzy, with wildcards, on a distance, in the same sentence.";
declare variable $keywords := "Neo-Latin, Croatia, text corpus, search";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("quaere-multimode")
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


  function page:croalabroquaeremultimode()
{
  (: HTML template starts here :)

<html>
{ croalabro-html:htmlheadserver($title, $content, $keywords) }
<body>
<div class="container">
<div  class="row">
<div  class="col">
<h1 class="text-center">{ $title }</h1>
<p class="text-center">{ $subtitle }</p>
</div>
</div>
<div  class="row">
<div  class="col">
<h3 class="text-center">{ "Quaere in modo fuzzy (erroribus permissis)" }</h3>
  <!-- function here -->

{ croalabro-html:searchform( "qfuzzy" , "vfuzzy", "Quaere etiam erroribus permissis" ) }

<p>Si quaeres vocabulum <b>harena</b> modo fuzzy, invenientur in CroALa <em>habena arena harenas harenę harenam harena hauena Harenam harenae Arena arenâ</em>.</p>
<p><small>Patientia desideratur, quia quaestio longiuscula fieri solet. – De modo fuzzy vide plura in <a href="https://docs.basex.org/wiki/Full-Text#Fuzzy_Querying">BaseX Wiki</a>.</small></p>
</div>
</div>

<div  class="row">
<div  class="col">
<h3 class="text-center">{ "Quaere in modo wildcards (litteris signorum vice notatis)" }</h3>
  <!-- function here -->

{ croalabro-html:searchform( "qwildcards" , "vwc", "Quaere ope wildcards" ) }

</div>
	</div>

	<div class="row">
<div  class="col">
  <!-- function here -->

	{ croalabro-html:searchinfowc() }	

</div>
</div>

<div  class="row">
<div  class="col">
	<h3 class="text-center">{ "Quaere vocabula plura, quodcumque inventum ostende" }</h3>
	<p class="text-center">Quaestio fit ad litteram (neque cum wildcards neque fuzzy).</p>
  <!-- function here -->

{ croalabro-html:searchform( "qqcumque", "qqc", "Da vocabula plura quaerenda" ) }
</div>
</div>
	

<div  class="row">
<div  class="col">
	<h3 class="text-center">{ "Quaere vocabula distantia (separata per aliud unum, duo, tria etc.)" }</h3>
	<p class="text-center">Quaestio fit ad litteram (neque cum wildcards neque fuzzy).</p>
  <!-- function here -->

{ croalabro-html:searchformtxtnr( "qdistantia", "vvdist", "Da vocabula plura quaerenda", "ndist", "Da numerum vocabulorum separantium (1, 2, 3...)" ) }
</div>
</div>

<div  class="row">
<div  class="col">
	<h3 class="text-center">{ "Quaere vocabula in eadem sententia" }</h3>
	<p class="text-center">Quaestio fit ad litteram (neque cum wildcards neque fuzzy).</p>
  <!-- function here -->

{ croalabro-html:searchform( "qsententia" , "vvsent", "Quaere vocabula in eadem sententia" ) }
</div>
</div>

{ croalabro-html:footerserver() }
</div>
</body>
</html>
};

return


