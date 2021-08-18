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

  func testGetDayOfWeekByIndex() throws {
    let dataSets = [
      [1, "Monday"],
      [5, "Friday"],
      [7, "Sunday"]
    ]

    for dataSet in dataSets {
      let result = getDayOfWeekByIndex(dataSet[0] as! Int)
      assert(result == dataSet[1] as! String)
    }
  }

  func testGetDayOfWeekByIndexDefaultsToMonday() throws {
    let unexpectedDayOfWeekIndexes = [-1, 0, 8, 10, 123]

    for unexpectedIndex in unexpectedDayOfWeekIndexes {
      let result = getDayOfWeekByIndex(unexpectedIndex)
      assert(result == "Monday")
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
//                    "order": "lastName"
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
    let pupilsScopeNode = DailyRegisterFilterRequestNode.PupilsScope(order: "lastName, firstName")
    let pupilsRelationNode = DailyRegisterFilterRequestNode.PupilsRelation(relation: "pupils", scope: pupilsScopeNode)
    let whereNode = DailyRegisterFilterRequestNode.DaysOfWeekWhere(day: "Monday")
    let daysOfWeekScopeNode = DailyRegisterFilterRequestNode.DaysOfWeekScope(where: whereNode, include: [pupilsRelationNode])
    let daysOfWeekRelationNode = DailyRegisterFilterRequestNode.DaysOfWeekRelation(relation: "daysOfWeek", scope: daysOfWeekScopeNode)
    let expectedResult = DailyRegisterFilterRequestNode(include: [daysOfWeekRelationNode])

    let result = buildDailyRegisterRequestFilter(1)
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

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
