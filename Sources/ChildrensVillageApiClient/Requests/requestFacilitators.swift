//
//  requestFacilitators.swift
//  File
//
//  Created by Chris Kobrzak on 20/10/2021.
//

import Foundation
import JwtApiClient

public func requestFacilitators<T: Decodable>(token: String) async throws -> T {
  let urlFilter = buildFacilitatorsRequestFilter()
  let filterJson = JSONEncoder.encode(from: urlFilter)

  let endpoint = buildFacilitatorsUrlComponent(filter: filterJson).url!

  return try await getJsonWithToken(endpoint, token: token)
}

func buildFacilitatorsUrlComponent(filter: String) -> URLComponents {
  let path = "/parents"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
