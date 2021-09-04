import Foundation

// This needs to be eventually configurable on a per-environment basis
func buildBaseUrlComponent(_ environment: String = "production") -> URLComponents {
  var urlComponent = URLComponents()
  urlComponent.scheme = "https"
  urlComponent.host = "childrens-village.co.uk"
  urlComponent.path = "/api"

  return urlComponent
}
