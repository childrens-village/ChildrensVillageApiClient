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
//                       "or": [
//                        {"active": true},
//                        {
//                          "id": {
//                            "inq": ["deactivated-pupil-uuid"]
//                          }
//                        }
//                      ]
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
  func testBuildDailyRegisterRequestFilter() throws {
    let sampleMonday = "2021-07-05"
    let date = Date(isoDate: sampleMonday)
    let attendancesWhere = ARRF.Where(date: sampleMonday)
    let attendancesScopeNode = ARRF.Scope(where: attendancesWhere)
    let attendancesRelationNode = ARRF(relation: "attendances", scope: attendancesScopeNode)

    let pupilWhereActive = PR.Where(active: true)
    // The list below should be retrieved first - it might contain pupils that have now been deactivated in the system
    let allClockedOnPupilIds: [UUID] = [
      UUID(uuidString: "efe1fffe-e9ad-477c-967f-9c964d71c120")!,
      UUID(uuidString: "f000651d-5a4e-49eb-92f2-30370f2b06b0")!
    ]
    let predicateIn = PredicateInUuid(inq: allClockedOnPupilIds)
    let pupilWhereIdsIn = PR.Where(id: predicateIn)
    let pupilOrPredicate = PR.Predicate(or: [pupilWhereActive, pupilWhereIdsIn])
    let pupilsScopeNode = PR.Scope(where: pupilOrPredicate, order: "firstName, lastName", include: Relation.attendance([attendancesRelationNode]))
    let pupilsRelationNode = PR(relation: "pupils", scope: pupilsScopeNode)

    let whereNode = DOWR.Where(day: .Monday)
    let daysOfWeekScopeNode = DOWR.Scope(where: whereNode, include: [pupilsRelationNode])
    let daysOfWeekRelationNode = DOWR(relation: "daysOfWeek", scope: daysOfWeekScopeNode)
    let expectedResult = PRRF(include: [daysOfWeekRelationNode])

    let result = buildPupilsRegisterRequestFilter(date, allClockedOnPupilIds)
    XCTAssertEqual(result, expectedResult)
//    assert(result == expectedResult.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  //  {
  //    "where": {
  //      "branchId": 1,
  //      "date": "2022-09-13"
  //    },
  //    "fields": {
  //      "pupilId": true
  //    }
  //  }
  func testBuildAttendancesRequestFilter() throws {
    let sampleMonday = "2022-09-13"
    let date = Date(isoDate: sampleMonday)
    let branchId = 1

    let attendanceFields = ARRF.Field(pupilId: true)

    let attendancesWhere = ARRF.Where(date: sampleMonday, branchId: branchId)

    let expectedResult = ARRF(fields: attendanceFields, where: attendancesWhere)

    let result = buildAttendancesRequestFilter(branchId, date)
    XCTAssertEqual(result, expectedResult)
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
    let attendancesWhere = ARRF.Where(date: sampleTuesday)
    let attendancesScopeNode = ARRF.Scope(where: attendancesWhere)
    let attendancesRelationNode = ARRF(relation: "attendances", scope: attendancesScopeNode)

    let expectedResult = FRRF(fields: fieldNode, include: [attendancesRelationNode], where: whereNode, order: "firstName, lastName")

    let result = buildFacilitatorsRegisterRequestFilter(date)
    XCTAssertEqual(result, expectedResult)
  }

/*
 {
   "include":[
     {
       "relation":"daysOfWeek",
       "scope":{
         "where":{
           "day":"Friday"
         },
         "include":[
           {
             "relation":"pupils",
             "scope":{
               "where":{
                 "or":[
                   {
                     "active":true
                   },
                   {
                     "id":{
                       "inq":[
                         "7c3e6698-2af9-45a6-825e-cdd0d5856d46"
                       ]
                     }
                   }
                 ]
               },
               "include":[
               "include":[
                 {
                   "relation":"parents",
                   "scope":{
                     "include":[
                       {
                         "relation":"attendances",
                         "scope":{
                           "where":{
                             "date":"2022-12-02"
                           }
                         }
                       }
                     ]
                   }
                 }
               ]
             }
           }
         ]
       }
     }
   ]
 }
 */
  func testBuildParentRegisterRequestFilter() throws {
    let sampleFriday = "2022-12-02"
    let date = Date(isoDate: sampleFriday)
    let dayOfWeek = "Friday"
    let sampleDeactivatedPupilId = "7c3e6698-2af9-45a6-825e-cdd0d5856d46"
    let sampleDeactivatedPupilUuid = UUID(uuidString: sampleDeactivatedPupilId)!
    let expectedResultStringified = """
{"include":[{"scope":{"where":{"day":"\(dayOfWeek)"},"include":[{"scope":{"where":{"or":[{"active":true},{"id":{"inq":["\(sampleDeactivatedPupilId.uppercased())"]}}]},"include":[{"scope":{"include":[{"scope":{"where":{"date":"\(sampleFriday)"}},"relation":"attendances"}]},"relation":"parents"}]},"relation":"pupils"}]},"relation":"daysOfWeek"}]}
"""

    let result = buildParentRegisterRequestFilter(date, [sampleDeactivatedPupilUuid])
    let resultStringified = JSONEncoder.encode(from: result)

    XCTAssertEqual(resultStringified, expectedResultStringified)
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
