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
    let attendancesWhere = DRFRN.AttendancesWhere(date: sampleMonday)
    let attendancesScopeNode = DRFRN.AttendancesScope(where: attendancesWhere)
    let attendancesRelationNode = DRFRN.AttendancesRelation(relation: "attendances", scope: attendancesScopeNode)
    let pupilsScopeNode = DRFRN.PupilsScope(order: "firstName, lastName", include: [attendancesRelationNode])
    let pupilsRelationNode = DRFRN.PupilsRelation(relation: "pupils", scope: pupilsScopeNode)
    let whereNode = DRFRN.DaysOfWeekWhere(day: .Monday)
    let daysOfWeekScopeNode = DRFRN.DaysOfWeekScope(where: whereNode, include: [pupilsRelationNode])
    let daysOfWeekRelationNode = DRFRN.DaysOfWeekRelation(relation: "daysOfWeek", scope: daysOfWeekScopeNode)
    let expectedResult = DRFRN(include: [daysOfWeekRelationNode])

    let result = buildDailyRegisterRequestFilter(date)
    XCTAssertEqual(result, expectedResult)
//    assert(result == expectedResult.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  func testBuildClockOnRequestUrlFilter() throws {
    let expectedResult = ClockOnRequestUrlFilter(
      pupilId: "uuid-123",
      branchId: 321,
      date: "2021-07-25",
      clockOnTime: "09:25"
   )

    let result = buildClockOnRequestUrlFilter("uuid-123", branchId: 321, date: "2021-07-25", time: "09:25")
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
