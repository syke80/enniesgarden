String.prototype.URLize = function() {
  var retValue = this.toLowerCase();
  var translationTable = {
    'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o',
    'ö': 'o', 'o': 'o', 'ü': 'u', 'u': 'u', 'ú': 'u', 'u': 'u', 'o': 'o', 'ő': 'o', 'ű': 'u',
    ' ': '-', '&': '-', '[^a-z0-9-]': ''
  }
  for (var what in translationTable) {
    retValue = retValue.replace(new RegExp(what, 'ig'), translationTable[what]).replace(/-+/g,"-");
  }
  return retValue;
}
