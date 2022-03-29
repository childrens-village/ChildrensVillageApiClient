//
//  BuildUrlComponentTests.swift
//  BuildUrlComponentTests
//
//  Created by Chris Kobrzak on 09/03/2022.
//

import XCTest
@testable import ChildrensVillageApiClient

class BuildUrlComponentTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testBuildUrlComponent() {
    let path = "/users/123"

    let result = buildUrlComponent(path)

    XCTAssertEqual(result.path, "/api/users/123")
  }

  func testBuildUrlComponent_withQuery() {
    let path = "/books/321"
    let firstQueryItem = URLQueryItem(name: "lorem", value: "ipsum")
    let secondQueryItem = URLQueryItem(name: "dolor", value: "sit")

    let result = buildUrlComponent(path, queryItems: [firstQueryItem, secondQueryItem])

    XCTAssertEqual(result.path, "/api/books/321")
    XCTAssertEqual(result.query, "lorem=ipsum&dolor=sit")
  }
}
