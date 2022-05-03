//
//  DateUtilitiesTests.swift
//  DateUtilitiesTests
//
//  Created by Chris Kobrzak on 09/03/2022.
//

import XCTest
@testable import ChildrensVillageApiClient

class DateUtilitiesTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testGetDayOfWeek() throws {
    let validEntries = [
      Date(isoDate: "2019-02-25"), // Mon
      Date(isoDate: "2020-07-07"), // Tue
      Date(isoDate: "2020-10-21"), // ...
      Date(isoDate: "2021-09-16"),
      Date(isoDate: "2022-01-14"),
      Date(isoDate: "2022-03-19"),
      Date(isoDate: "2022-05-29")
    ]
    let expectedResults = [DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Wednesday, DayOfWeek.Thursday, DayOfWeek.Friday, DayOfWeek.Saturday, DayOfWeek.Sunday]

    for (index, input) in validEntries.enumerated() {
      let result = try! getDayOfWeek(date: input)
      XCTAssertEqual(result, expectedResults[index])
    }
  }
}
