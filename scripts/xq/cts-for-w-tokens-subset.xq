for $id in db:open("croalatextussubsettokenized")//*:text//*:w
let $cts := $id/ancestor::*:text/@xml:base
return $cts || db:node-id($id)