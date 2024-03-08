
Map<String, dynamic> userSearchTagsHandler({
  required String fName,
  required String lName,
  required String email,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  fName.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });
  lName.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });

  email.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });

  return searchTags;
}


Map<String, dynamic> productSearchTagHandler({
  required String productName,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  productName.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });

  return searchTags;
}

