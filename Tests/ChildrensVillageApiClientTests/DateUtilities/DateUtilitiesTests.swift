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
    let validEntries = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let expectedResults = [DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Wednesday, DayOfWeek.Thursday, DayOfWeek.Friday, DayOfWeek.Saturday, DayOfWeek.Sunday]

    for (index, input) in validEntries.enumerated() {
      let result = try! getDayOfWeek(string: input)
      XCTAssertEqual(result, expectedResults[index])
    }
  }
}
