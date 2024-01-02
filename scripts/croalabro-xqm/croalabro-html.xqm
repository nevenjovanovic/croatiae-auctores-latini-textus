(: XQuery module for HTML of CroALaBRO :)
module namespace croalabro-html = 'http://croala.ffzg.unizg.hr/croalabro-html';

declare variable $croalabro-html:cssserver := "/basex/static/dist/chota.min.css";
declare variable $croalabro-html:csslocal := "/static/dist/laurdal.css";


(: helper function for header, with meta :)
declare function croalabro-html:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa" />
<link rel="icon" href="/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href=" { $croalabro-html:csslocal } "  />

</head>

};

(: header with loader :)
declare function croalabro-html:htmlheadloader($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa" />
<link rel="icon" href="/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href=" { $croalabro-html:csslocal } "  />
</head>

};


(: make html link :)

declare function croalabro-html:link($url,$lname){
  element a {
    attribute href { $url },
    $lname
  }
};

(: make html link as tag :)

declare function croalabro-html:linktag($url,$lname){
  element a {
    attribute class { "tag pull-right text-grey" },
    attribute href { $url },
    $lname
  }
};

(: turn tr/td structure into div-class-row, div-class-col :)

declare function croalabro-html:trtodiv($tr){
for $t in $tr
return element div {
 attribute class { "search-hit" },
   for $c in $t/*
   return element div {
   attribute class { "row"},
   element div {
     attribute class { "col"},
     $c
   }
 }
}
};

(: turn td structure into div-class-row, div-class-col :)

declare function croalabro-html:trtodiv2($tr){
for $t in $tr/tr
return element div {
 attribute class { "search-hit" },
   for $c in $t/td
   return element div {
   attribute class { "row"},
   element div {
     attribute class { "col"},
     $c
   }
 }
}
};


(: format header for a hit in search results :)

declare function croalabro-html:formathithead( $filelink ){
element span { 
attribute class { "tag is-rounded" } ,
element img { attribute src {"https://icongr.am/jam/document.svg?size=20&amp;color=6CB4EE" } } }
,
element span { " " } ,
element small { $filelink }
};

(: report if 0 results found :)

declare function croalabro-html:zero() {
element tr { 
element td { 
element p {
attribute class { "text-error text-center" },
"Nihil inventum." } }
}
};

declare function croalabro-html:zero2() {
element div { 
element tr { 
element b { "nihil." } },
		element tr { 
element b { "nullae." } }
}
};

(: make search form; needs: 1. action, 2. name, 3. placeholder :)

declare function croalabro-html:searchform( $action , $name, $placeholder ) {
element form {
  attribute action { $action },
  element p {
    attribute class { "grouped" },
    element input {
      attribute type { "search"},
      attribute name { $name },
      attribute placeholder { $placeholder }
    },
    element button {
      attribute class { "button icon-only" },
      element img {
        attribute src { "https://icongr.am/feather/search.svg?size=16" }
      }
    }
  }
}
};

(: make search form with two fields, text and number, grouped :)

declare function croalabro-html:searchformtxtnr( $action , $name, $placeholder, $distance, $placeholder2 ) {
element form {
  attribute action { $action },
  element p {
    attribute class { "grouped" },
    element input {
      attribute type { "search"},
      attribute name { $name },
      attribute placeholder { $placeholder }
			},
			 element input {
      attribute type { "number"},
      attribute name { $distance },
      attribute placeholder { $placeholder2 }
    },
    element button {
      attribute class { "button icon-only" },
      element img {
        attribute src { "https://icongr.am/feather/search.svg?size=16" }
      }
    }
  }
}
};


(: helper function for table :)
declare function croalabro-html:table ($headings, $body){
  element table {
    attribute class {"sortable striped"},
    if ($headings="") then ()
    else
    element thead {
      element tr {
        for $h in $headings return element th { $h }
      }
    },
    element tbody {
      $body
    }
  }
};

(: helper - table row :)
declare function croalabro-html:tablerow($cells){
  element tr { $cells }
};

(: helper - leaf :)
declare function croalabro-html:folium($element){
element { $element } {
element img {
attribute class { "text-center" },
attribute src { "https://icongr.am/entypo/leaf.svg?size=40&amp;color=6CB4EE" }
} }
};

(: helper function - footer :)
declare function croalabro-html:footerserver () {
let $f := <footer class="footer">
<div class="row">
<div  class="col">
<h3 class="text-center"><img src="https://icongr.am/entypo/leaf.svg?size=40&amp;color=6CB4EE" aria-hidden="true"></img><br/><a href="https://croala.ffzg.unizg.hr">CroALa</a>: Croatiae auctores Latini</h3>
<h4 class="text-center"><a href="https://www.ffzg.unizg.hr"><img src="/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h4> 
<p class="text-center">
<span class="text-grey">Github</span>: <a href="https://github.com/nevenjovanovic/croatiae-auctores-latini-textus">croatiae-auctores-latini-textus</a></p>
</div>
</div>

</footer>
return $f
};

(: helper function - footer with table :)
declare function croalabro-html:footertable () {
let $f := <footer class="footer">
<div class="row">
<div  class="col">
<h3 class="text-center"><img src="https://icongr.am/entypo/leaf.svg?size=40&amp;color=6CB4EE" aria-hidden="true"></img><br/><a href="https://croala.ffzg.unizg.hr">CroALa</a>: Croatiae auctores Latini</h3>
<h4 class="text-center"><a href="https://www.ffzg.unizg.hr"><img src="/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h4> 
<p class="text-center">
<span class="text-grey">Github</span>: <a href="https://github.com/nevenjovanovic/croatiae-auctores-latini-textus">croatiae-auctores-latini-textus</a></p>
</div>
</div>
<link href="/static/dist/sortable-base.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/gh/tofsjonas/sortable@latest/sortable.min.js"></script>

</footer>
return $f
};

