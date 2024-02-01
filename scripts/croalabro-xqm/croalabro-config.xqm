(: XQuery module with configs for CroALaBRO :)
module namespace croalabro-config = 'http://croala.ffzg.unizg.hr/croalabro-config';

declare variable $croalabro-config:csscdb := "/cdb";
(: declare variable $croalabro-config:csscdb := ""; :)
declare variable $croalabro-config:csslocal := $croalabro-config:csscdb || "/static/";
declare variable $croalabro-config:croalaurl := $croalabro-config:csscdb || "/static/croala-html/";
