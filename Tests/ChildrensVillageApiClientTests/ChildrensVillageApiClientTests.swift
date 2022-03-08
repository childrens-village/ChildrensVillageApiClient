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

  func testRequestToken() async throws {
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

  func testGetDayOfWeek() throws {
    let validEntries = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let expectedResults = [DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Wednesday, DayOfWeek.Thursday, DayOfWeek.Friday, DayOfWeek.Saturday, DayOfWeek.Sunday]

    for (index, input) in validEntries.enumerated() {
      let result = try! getDayOfWeek(string: input)
      XCTAssertEqual(result, expectedResults[index])
    }
  }

  func testBuildDailyRegisterRequestFilter() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//      {
//        "include": [
//          {
//            "relation": "daysOfWeek",
//            "scope": {
//              "where": {
//                "day": "Monday"
//              },
//              "include": [
//                {
//                  "relation": "pupils",
//                  "scope": {
//                    "order": "lastName",
//                    "include": [
//                      {
//                        "relation": "attendances",
//                        "scope": {
//                          "where": {
//                            "date": "2021-07-05"
//                          }
//                        }
//                      }
//                    ]
//                  }
//                }
//              ]
//            }
//          }
//        ]
//      }
//    let expectedResult = """
//      {"include":[{"relation":"daysOfWeek","scope":{"where":{"day":"Monday"},"include":[{"relation":"pupils","scope":{"order":"lastName, firstName"}}]}}]}
//      """
    let sampleMonday = "2021-07-05"
    let date = Date(isoDate: sampleMonday)
    let attendancesWhere = ARRF.AttendancesWhere(date: sampleMonday)
    let attendancesScopeNode = ARRF.AttendancesScope(where: attendancesWhere)
    let attendancesRelationNode = ARRF(relation: "attendances", scope: attendancesScopeNode)
    let pupilsScopeNode = PRRF.PupilsScope(order: "firstName, lastName", include: [attendancesRelationNode])
    let pupilsRelationNode = PRRF.PupilsRelation(relation: "pupils", scope: pupilsScopeNode)
    let whereNode = PRRF.DaysOfWeekWhere(day: .Monday)
    let daysOfWeekScopeNode = PRRF.DaysOfWeekScope(where: whereNode, include: [pupilsRelationNode])
    let daysOfWeekRelationNode = PRRF.DaysOfWeekRelation(relation: "daysOfWeek", scope: daysOfWeekScopeNode)
    let expectedResult = PRRF(include: [daysOfWeekRelationNode])

    let result = buildPupilsRegisterRequestFilter(date)
    XCTAssertEqual(result, expectedResult)
//    assert(result == expectedResult.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  func testBuildFacilitatorsRequestFilter() throws {
// Endpoint: /parents
// Filter object:
//  {
//    "order": "firstName, lastName",
//    "where": {
//      "active": true,
//      "facilitating": true
//    },
//    "fields": {
//      "id": true,
//      "primary": true,
//      "firstName": true,
//      "lastName": true,
//      "prefix": true,
//      "phone": true,
//      "email": true
//    },
//    "include": [
//      {
//        "relation": "attendances",
//        "scope": {
//          "where": {
//            "date": "<date>"
//          }
//        }
//      }
//    ]
//  }
//      {"order":"firstName, lastName","where":{"active":true,"facilitating":true},"fields":{"id":true,"primary":true,"firstName":true,"lastName":true,"prefix":true,"phone":true,"email":true},"include":[{"relation":"attendances","scope":{"where":{"date":"<date>"}}}]}

    let fieldNode = FRRF.Field(
      id: true,
      firstName: true,
      lastName: true,
      prefix: true,
      phone: true,
      email: true
    )
    let whereNode = FRRF.Where(active: true, facilitating: true)

    let sampleTuesday = "2021-10-18"
    let date = Date(isoDate: sampleTuesday)
    let attendancesWhere = ARRF.AttendancesWhere(date: sampleTuesday)
    let attendancesScopeNode = ARRF.AttendancesScope(where: attendancesWhere)
    let attendancesRelationNode = ARRF(relation: "attendances", scope: attendancesScopeNode)

    let expectedResult = FRRF(fields: fieldNode, include: [attendancesRelationNode], where: whereNode, order: "firstName, lastName")

    let result = buildFacilitatorsRegisterRequestFilter(date)
    XCTAssertEqual(result, expectedResult)
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

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
