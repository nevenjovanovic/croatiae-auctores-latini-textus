declare function local:copy-nodes-filter-text($element) {
   element { node-name($element) }
             { $element/@*,
               for $child in $element/node()
                  return if (not($child/self::text()))
                    then local:copy-nodes-filter-text($child)
                    else local:tokenize-words-pc(normalize-space($child))
           }
 };
(: tokenize string ending with punctuation into characters and punctuation :)
declare function local:tokenize-words-pc($token){
  for $part in analyze-string($token, '\w+')/*
   return  if ($part/name()="fn:match") then element w { $part/string()} 
      else if (matches($part/string(), "\s+")) then ()
      else element pc { $part/string()}
};

declare variable $xml_file := <sp>
               <speaker>
            <abbr>Lyc.</abbr>
          </speaker>
               <l>Solus ego, Arcadiae extremis e finibus omnis</l>
               <l>Ad sacrum dum turba nemus volat agmine denso,</l>
               <l n="10">Namque imo ciet inclamans<note ana="authorial" place="foot" n="1">Myrhaeus
                     enim, nimirum doctissimus Abbas Michael Joseph Morejus, nunc est tertius
                     Generalis Arcadiae Custos. </note> Myrhaeus ab antro, </l>
               <l>Tytire, solus, iners patria sub rupe manerem?</l>
               <l>Non ita praerupti genitum sub vertice montis,</l>
               <l>Heu puero, heu nimium raptus cito! durus Amyntas</l>
               <l>Erudiit, dumosa manu per culmina raptans</l>
            </sp>;
local:copy-nodes-filter-text($xml_file)