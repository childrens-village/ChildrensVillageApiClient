//
//  RequestFilterBuilderTests.swift
//  
//
//  Created by Chris Kobrzak on 09/03/2022.
//

import XCTest
@testable import ChildrensVillageApiClient

class RequestFilterBuilderTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

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
//                    "where": {
//                      "active": true
//                    },
//                    "order": "firstName, lastName",
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
  func testBuildDailyRegisterRequestFilter() throws {
    let sampleMonday = "2021-07-05"
    let date = Date(isoDate: sampleMonday)
    let attendancesWhere = ARRF.AttendancesWhere(date: sampleMonday)
    let attendancesScopeNode = ARRF.AttendancesScope(where: attendancesWhere)
    let attendancesRelationNode = ARRF(relation: "attendances", scope: attendancesScopeNode)
    let pupilWhere = PRRF.PupilWhere(active: true)
    let pupilsScopeNode = PRRF.PupilsScope(where: pupilWhere, order: "firstName, lastName", include: [attendancesRelationNode])
    let pupilsRelationNode = PRRF.PupilsRelation(relation: "pupils", scope: pupilsScopeNode)
    let whereNode = PRRF.DaysOfWeekWhere(day: .Monday)
    let daysOfWeekScopeNode = PRRF.DaysOfWeekScope(where: whereNode, include: [pupilsRelationNode])
    let daysOfWeekRelationNode = PRRF.DaysOfWeekRelation(relation: "daysOfWeek", scope: daysOfWeekScopeNode)
    let expectedResult = PRRF(include: [daysOfWeekRelationNode])

    let result = buildPupilsRegisterRequestFilter(date)
    XCTAssertEqual(result, expectedResult)
//    assert(result == expectedResult.trimmingCharacters(in: .whitespacesAndNewlines))
  }

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

  func testBuildFacilitatorsRequestFilter() throws {
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

  // Endpoint: /pupils/{pupilId}
  // Filter object:
  //{
  //  "fields": {
  //    "id": true,
  //    "active": true,
  //    "firstName": true,
  //    "lastName": true,
  //    "dateOfBirth": true,
  //    "prefix": true,
  //    "photographyConsent": true,
  //    "allergies": true,
  //  },
  //  "include": [
  //    {
  //      "relation": "parents"
  //    },
  //    {
  //      "relation": "branches"
  //    },
  //    {
  //      "relation": "daysOfWeek"
  //    }
  //  ]
  //}
  func testBuildPupilRequestFilter() throws {
    let includesNode = [Include(relation: "parents"), Include(relation: "branches"), Include(relation: "daysOfWeek")]
    let fieldNode = PRF.Field(
      id: true,
      active: true,
      firstName: true,
      lastName: true,
      prefix: true,
      dateOfBirth: true,
      photographyConsent: true,
      allergies: true
    )
    let expectedResult = PRF(fields: fieldNode, include: includesNode)

    let result = buildPupilRequestFilter()
    XCTAssertEqual(result, expectedResult)
  }
}
