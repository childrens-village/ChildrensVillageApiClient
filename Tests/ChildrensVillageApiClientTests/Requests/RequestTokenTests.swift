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
  let client = MockJsonApiClient()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    client.resetSpies()
  }
  
  func testRequestToken() async throws {
    let login = "joe.bloggs@mail.com"
    let password = "top3ecret"

    var result: String?
    do {
      result = try await requestToken(apiClient: client, login, password)
    } catch {
      XCTFail()
    }

    XCTAssertTrue(client.postSpy.called)
    XCTAssertEqual(client.postSpy.arg1!.path, "/api/users/login")
    XCTAssertEqual(client.postSpy.arg2, ["email": login, "password": password])
    XCTAssertEqual(result, "fake-token")
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
