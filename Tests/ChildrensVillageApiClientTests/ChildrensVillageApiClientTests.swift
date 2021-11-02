//
//  ChildrensVillageApiClientTests.swift
//  ChildrensVillageApiClientTests
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import XCTest
@testable import ChildrensVillageApiClient

class ChildrensVillageApiClientTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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

  func testBuildClockOnRequestUrlFilter() throws {
    let expectedResult = ClockOnRequestBody(
      pupilId: "uuid-123",
      branchId: 321,
      date: "2021-07-25",
      clockOnTime: "09:25"
   )

    let result = buildClockOnRequestBody("uuid-123", branchId: 321, date: "2021-07-25", time: "09:25")
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
