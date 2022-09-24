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
  var baseApiUrl = "https://childrens-village.co.uk/api"
  
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
    let expectedUrl = URL(string: "\(baseApiUrl)/users/login")
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

  // FIXME: Mockingbird is complaining about the client.post mock
//  func testRequestTokenTask_withRequestError() async throws {
//    // Arrange
//    let login = "joe.bloggs@mail.com"
//    let password = "wrongPassword"
//
//    let error = ApiError(statusCode: 456, name: "fake error", message: "Fake error message")
//
//    given(
//      await client.post(
//        url: any(URL.self),
//        dictionary: any([String: Any].self)
//      )
//    )
//      .willReturn(ErrorResponse(error: error))
//
//    // Act
//    do {
//      let _: TokenResponse = try await requestTokenTask(apiClient: client, login, password)
//    } catch let error as ApiError {
//      // Assert
//      verify(
//        await client.post(
//          url: any(URL.self),
//          dictionary: any([String: Any].self)
//        )
//      )
//        .returning(ErrorResponse.self)
//        .wasCalled(exactly(1))
//
//      XCTAssertEqual(error.statusCode, 456)
//    }
//  }

  func testRequestPupilsRegisterTask() async throws {
    // Arrange
    let token = "fake-register-token"
    let branchId = 345
    let isoDate = "2022-03-15"
    let date = Date(isoDate: isoDate)

    let branchName = "Branch Name"
    let branchPostcode = "XY1 2ZZ"
    let branchAddress = "Fake Address"
    let geolocation = GeolocationModel(latitude: 51.01, longitude: 0.07)

    let pupilA = PupilModel(
      id: UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!,
      firstName: "Joe",
      lastName: "Bloggs",
      dateOfBirth: "2015-01-01",
      prefix: TitlePrefix.Miss,
      parents: nil,
      attendances: nil,
      branches: nil,
      daysOfWeek: nil
    )
    let pupils = [pupilA]

    let mondayPupils = DayOfWeekModel(id: 135, day: DayOfWeek.Monday, pupils: pupils)
    let apiResponse = DailyRegisterResponse(
      id: branchId,
      name: branchName,
      geolocation: geolocation,
      postcode: branchPostcode,
      address: branchAddress,
      pupils: nil,
      daysOfWeek: [mondayPupils]
    )

    given(
      await client.get(
        url: any(URL.self),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: [PupilModel] = try await requestPupilsRegisterTask(apiClient: client, token, branchId, date)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/branches/345?filter=%7B%22include%22:%5B%7B%22scope%22:%7B%22where%22:%7B%22day%22:%22Tuesday%22%7D,%22include%22:%5B%7B%22scope%22:%7B%22where%22:%7B%22active%22:true%7D,%22order%22:%22firstName,%20lastName%22,%22include%22:%5B%7B%22scope%22:%7B%22where%22:%7B%22date%22:%22\(isoDate)%22%7D%7D,%22relation%22:%22attendances%22%7D%5D%7D,%22relation%22:%22pupils%22%7D%5D%7D,%22relation%22:%22daysOfWeek%22%7D%5D%7D")

    verify(
      await client.get(
        url: expectedUrl!,
        token: token
      )
    )
      .returning(DailyRegisterResponse.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.first?.id, apiResponse.daysOfWeek?.first?.pupils?.first?.id)
  }

  func testRequestPupilTask() async throws {
    // Arrange
    let token = "fake-register-token"
    let pupilId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let dayOfWeek = DayOfWeekModel(id: 135, day: DayOfWeek.Monday, pupils: nil)
    let apiResponse = PupilResponse(
      id: pupilId,
      firstName: "Joe",
      lastName: "Bloggs",
      dateOfBirth: "2015-01-01",
      prefix: TitlePrefix.Miss,
      parents: nil,
      attendances: nil,
      branches: nil,
      daysOfWeek: [dayOfWeek]
    )

    given(
      await client.get(
        url: any(URL.self),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: PupilModel = try await requestPupilTask(apiClient: client, token, pupilId)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/pupils/753dfb2b-e6c7-4d35-9e6c-0665394b3e6a?filter=%7B%22include%22:%5B%7B%22relation%22:%22parents%22%7D,%7B%22relation%22:%22branches%22%7D,%7B%22relation%22:%22daysOfWeek%22%7D%5D,%22fields%22:%7B%22firstName%22:true,%22id%22:true,%22active%22:true,%22lastName%22:true,%22prefix%22:true,%22dateOfBirth%22:true%7D%7D")

    verify(
      await client.get(
        url: expectedUrl!,
        token: token
      )
    )
      .returning(PupilResponse.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.id, apiResponse.id)
  }

  func testRequestPupilsRegisterTask_noResults() async throws {
    // Arrange
    let token = "fake-auth-token"
    let branchId = 3
    let isoDate = "2022-03-16"
    let date = Date(isoDate: isoDate)

    let branchName = "Branch Name"
    let branchPostcode = "XY1 2ZZ"
    let branchAddress = "Fake Address"
    let geolocation = GeolocationModel(latitude: 51.03, longitude: 0.05)

    let apiResponse = DailyRegisterResponse(
      id: branchId,
      name: branchName,
      geolocation: geolocation,
      postcode: branchPostcode,
      address: branchAddress,
      pupils: nil,
      daysOfWeek: nil
    )

    given(
      await client.get(
        url: any(URL.self),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: [PupilModel] = try await requestPupilsRegisterTask(apiClient: client, token, branchId, date)

    // Assert
    XCTAssertEqual(result.count, 0)
  }

  func testRequestFacilitatorsRegisterTask() async throws {
    // Arrange
    let token = "fake-facilitator-token"
    let parentId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let isoDate = "2022-03-15"
    let date = Date(isoDate: isoDate)

    let facilitatorA = Parent(id: parentId, active: true, facilitating: true, primary: true, firstName: "Parent A First Name", lastName: "Parent A Last Name", prefix: TitlePrefix.Mrs, phone: "07590000000", email: "parent.a@mail.com", attendances: nil)
    let apiResponse = [facilitatorA]

    given(
      await client.get(
        url: any(URL.self),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: [Parent] = try await requestFacilitatorsRegisterTask(apiClient: client, token, date)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/parents?filter=%7B%22fields%22:%7B%22firstName%22:true,%22id%22:true,%22lastName%22:true,%22prefix%22:true,%22phone%22:true,%22email%22:true%7D,%22include%22:%5B%7B%22scope%22:%7B%22where%22:%7B%22date%22:%22\(isoDate)%22%7D%7D,%22relation%22:%22attendances%22%7D%5D,%22order%22:%22firstName,%20lastName%22,%22where%22:%7B%22facilitating%22:true,%22active%22:true%7D%7D")

    verify(
      await client.get(
        url: expectedUrl!,
        token: token
      )
    )
      .returning([Parent].self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.first?.id, apiResponse.first?.id)
  }

  func testClockOnPupilTask() async throws {
    // Arrange
    let token = "fake-token"
    let pupilId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
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
    let expectedUrl = URL(string: "\(baseApiUrl)/attendances")
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

  func testClockOnFacilitatorTask() async throws {
    // Arrange
    let token = "fake-token"
    let facilitatorId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let branchId = 21
//    let date = Date(isoDate: "2022-03-10")

    let apiResponse = ClockOnResponse(id: 333, branchId: branchId, date: "2022-03-14", clockOnTime: "16:30")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "parentId", "branchId", "date", "clockOnTime"),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: ClockOnResponse = try await clockOnFacilitatorTask(apiClient: client, token, facilitatorId, branchId)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/parent-attendances")
//    let expectedPayload: [String: Any] = [
//      "parentId": parentId,
//      "branchId": branchId,
//      "date": "2022-03-14",
//      "clockOnTime": "16:30"
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

  func testRevertPupilClockOnTask() async throws {
    // Arrange
    let token = "fake-revert-token"
    let attendanceId = 12345

    // Act
    try await revertPupilClockOnTask(apiClient: client, token, attendanceId)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/attendances/\(attendanceId)")

    verify(
      await client.delete(
        url: expectedUrl!,
        token: token
      )
    )
      .wasCalled(exactly(1))
  }

  func testRevertFacilitatorClockOnTask() async throws {
    // Arrange
    let token = "fake-revert-token"
    let attendanceId = 1234567

    // Act
    try await revertFacilitatorClockOnTask(apiClient: client, token, attendanceId)

    // Assert
    let expectedUrl = URL(string: "\(baseApiUrl)/parent-attendances/\(attendanceId)")

    verify(
      await client.delete(
        url: expectedUrl!,
        token: token
      )
    )
      .wasCalled(exactly(1))
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
