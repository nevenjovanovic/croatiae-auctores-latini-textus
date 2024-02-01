document$.subscribe(function() {
  var tables = document.getElementsByClassName("striped")
  tables.forEach(function(table) {
    new Tablesort(table)
  })
})