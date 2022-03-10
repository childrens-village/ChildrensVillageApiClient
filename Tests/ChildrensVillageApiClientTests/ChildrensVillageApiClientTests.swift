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

    let apiResponse = TokenResponse(token: "fake-token")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "email", "password")
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: TokenResponse = try await requestTokenTask(apiClient: client, login, password)

    // Assert
    let expectedUrl = URL(string: "https://childrens-village.co.uk/api/users/login")
    let expectedPayload = [
      "email": login,
      "password": password
    ]

    verify(
      await client.post(
        url: expectedUrl!,
        dictionary: any(where: { $0 == expectedPayload })
      )
    )
      .returning(TokenResponse.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.token, apiResponse.token)
  }

  func testClockOnPupilTask() async throws {
    // Arrange
    let token = "fake-token"
    let pupilId = "fake-pupil-uuid"
    let branchId = 123
//    let date = Date(isoDate: "2022-03-10")

    let apiResponse = ClockOnResponse(id: 321, branchId: branchId, date: "2022-03-10", clockOnTime: "12:25")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "pupilId", "branchId", "date", "clockOnTime"),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: ClockOnResponse = try await clockOnPupilTask(apiClient: client, token, pupilId, branchId)

    // Assert
    let expectedUrl = URL(string: "https://childrens-village.co.uk/api/attendances")
//    let expectedPayload: [String: Any] = [
//      "pupilId": pupilId,
//      "branchId": branchId,
//      "date": "2022-03-10",
//      "clockOnTime": "12:25"
//    ]

    verify(
      await client.post(
        url: expectedUrl!,
        dictionary: any([String: Any].self),
        token: token
      )
    )
      .returning(ClockOnResponse.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.id, apiResponse.id)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
