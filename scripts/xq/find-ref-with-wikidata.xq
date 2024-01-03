for $e in db:get("croalatextus")//*:author
where $e/@ref[matches(., "^http://www.wikidata.org/entity/")]
return $e