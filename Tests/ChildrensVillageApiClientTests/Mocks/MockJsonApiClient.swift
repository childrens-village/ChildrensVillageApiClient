//
//  MockJsonApiClient.swift
//  
//
//  Created by Chris Kobrzak on 06/03/2022.
//

import Foundation
import JwtApiClient

class MockJsonApiClient {
  struct PostMethodSpy {
    var called = false
    var arg1: URL? = nil
    var arg2: [String: String]? = nil
  }

  // TODO: This could be an array of calls instead of a single one
  var postSpy: PostMethodSpy!

  init() {
    resetSpies()
  }

  func resetSpies() {
    postSpy = PostMethodSpy(called: false, arg1: nil, arg2: nil)
  }
}

extension String: Error {}

extension MockJsonApiClient: JsonApiCompatible {
  func post<T>(_ url: URL!, token: String, dictionary: [String : Any]) async throws -> T where T : Decodable {
    throw "Implement me"
  }
  
  func get<T>(_ url: URL, token: String) async throws -> T where T : Decodable {
    throw "Implement me"
  }
  
  func get<T>(_ endpoint: String, token: String) async throws -> T where T : Decodable {
    throw "Implement me"
  }
  
  func delete(_ url: URL, token: String) async throws {
    throw "Implement me"
  }
  
  func patch(_ url: URL!, token: String, dictionary: [String : Any]) async throws {
    throw "Implement me"
  }
  
  func post<T>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T where T : Decodable {
    postSpy = PostMethodSpy(called: true, arg1: url, arg2: dictionary as? [String: String])

    try await Task.sleep(nanoseconds: 10)

    return "fake-token" as! T
  }
}
