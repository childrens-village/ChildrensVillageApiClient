//
//  RequestToken.swift
//  
//
//  Created by Chris Kobrzak on 05/03/2022.
//

import XCTest
import JwtApiClient
import ChildrensVillageApiClient

class RequestToken: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testRequestToken() async throws {
    class MockJsonApiClient: JsonApiCompatible {
      init() {}

      struct PostMethodSpy {
        var called = false
        var arg1: URL? = nil
        var arg2: [String: String]? = nil
      }

      var postSpy = PostMethodSpy(called: false, arg1: nil, arg2: nil)

      func post<T>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T where T : Decodable {
        postSpy = PostMethodSpy(called: true, arg1: url, arg2: dictionary as? [String: String])

        try await Task.sleep(nanoseconds: 10)

        return "fake-token" as! T
      }
    }

    let login = "joe.bloggs@mail.com"
    let password = "top3ecret"
    let client = MockJsonApiClient()

    do {
      let _: String = try await requestToken(login, password, apiClient: client)
    } catch {
      throw error
    }

    XCTAssertTrue(client.postSpy.called)
    XCTAssertEqual(client.postSpy.arg1!.path, "/api/users/login")
    XCTAssertEqual(client.postSpy.arg2, ["email": login, "password": password])
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
