//
//  ChildrensVillageApiClientTests.swift
//  ChildrensVillageApiClientTests
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import XCTest
import Mockingbird
@testable import JwtApiClient
@testable import ChildrensVillageApiClient

class ChildrensVillageApiClientTests: XCTestCase {
  
  var client: JsonApiClientMock!
  
  override func setUp() {
    client = mock(JsonApiClient.self).initialize()
  }

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testRequestTokenTask() async throws {
    // Arrange
    let login = "joe.bloggs@mail.com"
    let password = "topS3cret"

    let fakeResponse = TokenResponse(token: "fake-token")

    given(
      await client.post(any(URL.self), any(keys: "email", "password"))
    )
      .willReturn(fakeResponse)

    // Act
    let result: TokenResponse = try await requestTokenTask(apiClient: client, login, password)

    // Assert
    let expectedUrl = URL(string: "https://childrens-village.co.uk/api/users/login")
    let expectedPayload = [
      "email": login,
      "password": password
    ]

    verify(
      await client.post(expectedUrl!, any(where: { $0 == expectedPayload }))
    )
      .returning(TokenResponse.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.token, fakeResponse.token)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
