import Foundation

func buildUrlComponent(_ path: String, queryItems: [URLQueryItem]? = nil) -> URLComponents {
  var urlComponent = buildBaseUrlComponent()
  urlComponent.path += path
  urlComponent.queryItems = queryItems

  return urlComponent
}
