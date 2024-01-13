(: XQuery module for HTML of CroALaBRO :)
module namespace croalabro-html = 'http://croala.ffzg.unizg.hr/croalabro-html';
import module namespace croalabro-config = "http://croala.ffzg.unizg.hr/croalabro-config" at "croalabro-config.xqm";

(: declare variable $croalabro-html:csscdb := "/cdb/static/"; :)
(: declare variable $croalabro-html:csslocal := "static/"; :)

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
<link rel="icon" href=" { $croalabro-config:csslocal || "gfx/favicon.ico" } " type="image/x-icon" />
<link rel="stylesheet" href=" { $croalabro-config:csslocal || "dist/laurdal.css" } "  />

</head>

};

(: make html link :)

declare function croalabro-html:link($url,$lname){
  element a {
    attribute href { $url },
    $lname
  }
};

declare function croalabro-html:linkfrag($url,$fragment){
	element a {
		attribute rel { "noopener" },
    attribute href { $url },
    $fragment
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

(: create Wikidata tag :)

declare function croalabro-html:wikidata($qname){
	element span {
		attribute class { "tag" },
		element img {
			attribute class { "pull-left" },
	attribute src { $croalabro-config:csslocal || "gfx/Wikidata.svg" },
	attribute alt { "Wikidata logo" },
	attribute width { "32" },
	attribute height { "18" }
		},
		element small {
			attribute class { "pull-right" },
	" " || $qname
			}
		}
};

(: format input form for search :)

declare function croalabro-html:searchform0( $action, $actname , $actplaceholder, $limit ) {
	( element h4  {
		attribute class { "text-center" },
		"Formula quaestionis"
		},
	element form {
		attribute action { $limit || "/" || $action },
		attribute method { "GET" },
		attribute enctype { "application/x-www-form-urlencoded" },
		element p {
			attribute class { "grouped" },
			element input {
				attribute type { "search" },
				attribute name { $actname },
				attribute placeholder { $actplaceholder }
			},
			element button {
				attribute class { "button icon-only" },
					element img {
						attribute src {
							$croalabro-config:csslocal || "gfx/magnifying-glass.svg?size=16"
						}
				}
				}
			}
		} )
	};

(: format header for a hit in search results :)

declare function croalabro-html:formathithead( $filelink ){
element span { 
attribute class { "tag is-rounded" } ,
		element img {
			attribute src { $croalabro-config:csslocal || "gfx/document.svg?size=20&amp;color=6CB4EE" } } }
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

declare function croalabro-html:zerosec($message) {
element tr { 
element td { 
element p {
attribute class { "text-error text-center" },
$message } }
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
        attribute src { $croalabro-config:csslocal || "gfx/magnifying-glass.svg?size=16" }
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
        attribute src { $croalabro-config:csslocal || "gfx/magnifying-glass.svg?size=16" }
      }
    }
  }
}
};


(: helper function for table :)
declare function croalabro-html:table($headings, $body){
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
		attribute class { "text-center filter-blue" },
		attribute width { "40"},
		attribute height { "40" },
			attribute src {  $croalabro-config:csslocal || "gfx/leaf.svg?size=40&amp;color=6CB4EE" }
		}
	}
};

(: helper function - footer :)

declare function croalabro-html:footerserver() {
	element footer {
		attribute class { "footer" },
		element div {
			attribute class { "row" },
			element div {
				attribute class { "col" },
				element h3 {
					attribute class { "text-center" },
					element img {
						attribute width { "40"},
						attribute height { "40" },
						attribute src { $croalabro-config:csslocal || "gfx/leaf.svg?size=40&amp;color=6CB4EE" },
						attribute aria-hidden { "true" }
					},
					element br {},
					croalabro-html:link("https://croala.ffzg.unizg.hr", "CroALa"),
					": Croatiae auctores Latini"
				},
				element p {
					attribute class { "text-center" },
					element small {
						"The publishing framework is part of a project ",
						croalabro-html:link("https://pric.unive.it/projects/adriarchcult/home", "AdriArchCult"),
						" that has received funding from the European Union's Horizon 2020 Research and Innovation Programme (GA n. 865863 ERC-AdriArchCult)"
					}
				},
				element h4 {
					attribute class { "text-center"	},
					element img {
						attribute src { $croalabro-config:csslocal || "gfx/ffzghrlogo.png" },
						attribute aria-hidden { "true" },
					croalabro-html:link("https://www.ffzg.unizg.hr", "Filozofski fakultet"),
					" Sveučilišta u Zagrebu"
				},
				element p {
					attribute class { "text-center"	},
					element span {
						attribute class { "text-grey"	},
						"Github"
					},
					": ",
					croalabro-html:link("https://github.com/nevenjovanovic/croatiae-auctores-latini-textus", "croatiae-auctores-latini-textus" )
				}
			}
		}
		}
	}
};

declare function croalabro-html:forsort() {
	( element link {
		attribute href { $croalabro-config:csslocal || "dist/sortable-base.css"  },
		attribute rel { "stylesheet" }
	},
	element script {
		attribute src { "https://cdn.jsdelivr.net/gh/tofsjonas/sortable@latest/sortable.min.js" }
	} )
	};



(: helper function - footer with table :)
declare function croalabro-html:footertable() {
	( croalabro-html:footerserver(),
	croalabro-html:forsort() )
};

