(: XQuery module for HTML of CroALaBRO :)
module namespace croalabro-html = 'http://croala.ffzg.unizg.hr/croalabro-html';

declare variable $croalabro-html:cssserver := "/basex/static/dist/chota.min.css";
declare variable $croalabro-html:csslocal := "/static/dist/chota.min.css";


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
<link rel="stylesheet" type="text/css" href="/static/dist/css/modr.css"/>
<link rel="stylesheet" type="text/css" href="/static/dist/font-awesome-4.7.0/css/font-awesome.min.css"/>
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

(: helper function for table :)
declare function croalabro-html:table ($headings, $body){
  element table {
    attribute class {"striped"},
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

(: helper function - footer :)
declare function croalabro-html:footerserver () {
let $f := <footer class="footer">
<div class="row">
<div  class="col">
<h1 class="text-center"><span class="fa fa-leaf fa-fw" aria-hidden="true"></span> <a href="http://croala.ffzg.unizg.hr">CroALa</a>: Croatiae auctores Latini</h1>
</div>
</div>

<div class="row"> 
<div  class="col">
<h3 class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h3> 
<p class="text-center"><i class="fa fa-github fa-lg"></i>
            <span class="network-name">Github</span>: <a href="https://github.com/nevenjovanovic/croatiae-auctores-latini-textus">croatiae-auctores-latini-textus</a></p>
</div>
</div>
</footer>
return $f
};

