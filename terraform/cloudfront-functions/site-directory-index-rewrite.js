function handler(event) {
  var request = event.request;
  var uri = request.uri;

  if (uri === "/") {
    return request;
  }

  if (uri.endsWith("/")) {
    request.uri = uri + "index.html";
    return request;
  }

  var lastSlashIndex = uri.lastIndexOf("/");
  var lastSegment = uri.substring(lastSlashIndex + 1);

  if (!lastSegment.includes(".")) {
    request.uri = uri + "/index.html";
  }

  return request;
}
