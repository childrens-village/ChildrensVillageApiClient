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

    let apiResponse = TokenModel(token: "fake-token")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "email", "password")
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: TokenModel = try await requestTokenTask(apiClient: client, login, password)

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
      .returning(TokenModel.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.token, apiResponse.token)
  }

  func testRequestPasswordResetTask() async throws {
    // Arrange
    let email = "joe.bloggs@mail.com"
    let encryptedEmail = "am9lLmJsb2dnc0BtYWlsLmNvbQ=="
    let expectedUrl = URL(string: "\(baseApiUrl)/users/\(encryptedEmail)/password-resets")
    let acceptedStatusCode = 204
    let urlResponse: URLResponse = HTTPURLResponse(url: expectedUrl!, statusCode: acceptedStatusCode, httpVersion: "1.1", headerFields: nil)!

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any()
      )
    )
    .willReturn(urlResponse)

    // Act
    let statusCode: Int = try await requestPasswordResetTask(apiClient: client, email)

    // Assert
    let expectedPayload: [String:String] = [:]

    verify(
      await client.post(
        url: expectedUrl!,
        dictionary: any(where: { $0 == expectedPayload })
      )
    )
      .wasCalled(exactly(1))

    XCTAssertEqual(statusCode, acceptedStatusCode)
  }

  func testUpdatePasswordTask() async throws {
    // Arrange
    let verificationToken = "fake-user-token"
    let newPassword = "top3ecret"
    let expectedUrl = URL(string: "\(baseApiUrl)/users/\(verificationToken)")
    let acceptedStatusCode = 204
    let urlResponse: URLResponse = HTTPURLResponse(url: expectedUrl!, statusCode: acceptedStatusCode, httpVersion: "1.1", headerFields: nil)!

    given(
      await client.patch(
        url: any(URL.self),
        dictionary: any(keys: "password")
      )
    )
    .willReturn(urlResponse)

    // Act
    let statusCode: Int = try await updatePasswordTask(apiClient: client, verificationToken, newPassword)

    // Assert
    let expectedPayload = [
      "password": newPassword,
    ]

    verify(
      await client.patch(
        url: expectedUrl!,
        dictionary: any(where: { $0 == expectedPayload })
      )
    )
      .wasCalled(exactly(1))

    XCTAssertEqual(statusCode, acceptedStatusCode)
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

  func testRequestAllPupilsRegisterTask() async throws {
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
      activeUntil: "2023-12-15",
      photographyConsent: true,
      allergies: "gluten free",
      parents: nil,
      attendances: nil,
      branches: nil,
      daysOfWeek: nil
    )
    let pupils = [pupilA]

    let mondayPupils = DayOfWeekModel(id: 135, day: DayOfWeek.Monday, pupils: pupils)
    let apiResponse = BranchModel(
      id: branchId,
      name: branchName,
      geolocation: geolocation,
      postcode: branchPostcode,
      address: branchAddress,
      pupils: nil,
      daysOfWeek: [mondayPupils]
    )

    let deactivatedPupilId = "053dfb2b-e6c7-4d35-9e6c-0665394b3e60"
    let clockedOnPupilIds = [UUID(uuidString: deactivatedPupilId)!]

    given(
      await client.get(
        url: any(URL.self, where: { $0.description.contains("branches/") }),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: [PupilModel] = try await requestAllPupilsRegisterTask(apiClient: client, token, branchId, date, clockedOnPupilIds)

    // Assert
    verify(
      await client.get(
        url: any(URL.self, where: {
          $0.description.contains("branches/\(branchId)") &&
          $0.description.contains(isoDate)
        }),
        token: token
      )
    )
      .returning(BranchModel.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.first?.id, apiResponse.daysOfWeek?.first?.pupils?.first?.id)
  }

  func testRequestPupilTask() async throws {
    // Arrange
    let token = "fake-register-token"
    let pupilIdString = "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a"
    let pupilId = UUID(uuidString: pupilIdString)!
    let dayOfWeek = DayOfWeekModel(id: 135, day: DayOfWeek.Monday, pupils: nil)
    let apiResponse = PupilModel(
      id: pupilId,
      firstName: "Joe",
      lastName: "Bloggs",
      dateOfBirth: "2015-01-01",
      prefix: TitlePrefix.Miss,
      activeUntil: "2023-12-15",
      photographyConsent: true,
      allergies: "",
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
    verify(
      await client.get(
        url: any(URL.self, where: {
          $0.description.contains("pupils/\(pupilIdString)")
        }),
        token: token
      )
    )
    .returning(PupilModel.self)
    .wasCalled(exactly(1))

    XCTAssertEqual(result.id, apiResponse.id)
  }

  func testRequestAllPupilsRegisterTask_noResults() async throws {
    // Arrange
    let token = "fake-auth-token"
    let branchId = 3
    let isoDate = "2022-03-16"
    let date = Date(isoDate: isoDate)

    let branchName = "Branch Name"
    let branchPostcode = "XY1 2ZZ"
    let branchAddress = "Fake Address"
    let geolocation = GeolocationModel(latitude: 51.03, longitude: 0.05)

    let apiResponse = BranchModel(
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
    let result: [PupilModel] = try await requestAllPupilsRegisterTask(apiClient: client, token, branchId, date, [])

    // Assert
    XCTAssertEqual(result.count, 0)
  }

  func testRequestFacilitatorsRegisterTask() async throws {
    // Arrange
    let token = "fake-facilitator-token"
    let parentId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let isoDate = "2022-03-15"
    let date = Date(isoDate: isoDate)

    let facilitatorA = ParentModel(id: parentId, active: true, facilitating: true, primary: true, firstName: "Parent A First Name", lastName: "Parent A Last Name", prefix: TitlePrefix.Mrs, phone: "07590000000", email: "parent.a@mail.com", attendances: nil)
    let apiResponse = [facilitatorA]

    given(
      await client.get(
        url: any(URL.self),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: [ParentModel] = try await requestFacilitatorsRegisterTask(apiClient: client, token, date)

    // Assert
    verify(
      await client.get(
        url: any(URL.self, where: {
          $0.description.contains("/api/parents") &&
          $0.description.contains(isoDate)
        }),
        token: token
      )
    )
    .returning([ParentModel].self)
    .wasCalled(exactly(1))

    XCTAssertEqual(result.first?.id, apiResponse.first?.id)
  }

  func testRequestAllParentsRegisterTask() async throws {
    // Arrange
    let token = "fake-register-token"
    let branchId = 135
    let isoDate = "2022-12-08"
    let date = Date(isoDate: isoDate)

    let branchName = "Branch Name"
    let branchPostcode = "XY1 2ZZ"
    let branchAddress = "Fake Address"
    let geolocation = GeolocationModel(latitude: 51.01, longitude: 0.09)

    let commonParentA = ParentModel(
      id: UUID(uuidString: "77CCE5EA-9FFD-498B-8D7B-1045B62B82BC")!,
      active: true,
      facilitating: false,
      primary: nil,
      firstName: "PupilB",
      lastName: "ParentA",
      prefix: TitlePrefix.Mrs,
      phone: "07123 000000",
      email: nil,
      attendances: nil
    )
    let pupilBParentB = ParentModel(
      id: UUID(uuidString: "3F42715B-FD85-4D01-90F1-A1D6FF5CA79E")!,
      active: false,
      facilitating: false,
      primary: nil,
      firstName: "PupilB",
      lastName: "ParentB",
      prefix: TitlePrefix.Mr,
      phone: "07123 456789",
      email: nil,
      attendances: nil
    )

    let pupilA = PupilModel(
      id: UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!,
      firstName: "Joe",
      lastName: "Bloggs",
      dateOfBirth: "2015-01-01",
      prefix: TitlePrefix.Master,
      activeUntil: "2023-12-13",
      photographyConsent: true,
      allergies: "gluten free",
      parents: [commonParentA],
      attendances: nil,
      branches: nil,
      daysOfWeek: nil
    )
    let pupilB = PupilModel(
      id: UUID(uuidString: "0FB40D04-AC2F-4BAD-8E74-07BF2A4DD55D")!,
      firstName: "Amy",
      lastName: "Smith",
      dateOfBirth: "2017-10-10",
      prefix: TitlePrefix.Miss,
      activeUntil: "",
      photographyConsent: false,
      allergies: "vegan",
      parents: [commonParentA, pupilBParentB],
      attendances: nil,
      branches: nil,
      daysOfWeek: nil
    )
    let pupilC = PupilModel(
      id: UUID(uuidString: "E42636A9-AD52-4334-9953-AF0C46769CC8")!,
      firstName: "John",
      lastName: "Green",
      dateOfBirth: "2013-12-12",
      prefix: TitlePrefix.Master,
      activeUntil: "2024-05-20",
      photographyConsent: false,
      allergies: nil,
      parents: nil,
      attendances: nil,
      branches: nil,
      daysOfWeek: nil
    )
    let pupils = [pupilA, pupilB, pupilC]

    let mondayPupils = DayOfWeekModel(id: 135, day: DayOfWeek.Monday, pupils: pupils)
    let apiResponse = BranchModel(
      id: branchId,
      name: branchName,
      geolocation: geolocation,
      postcode: branchPostcode,
      address: branchAddress,
      pupils: nil,
      daysOfWeek: [mondayPupils]
    )

    let deactivatedPupilId = "053dfb2b-e6c7-4d35-9e6c-0665394b3e60"
    let clockedOnPupilIds = [UUID(uuidString: deactivatedPupilId)!]

    given(
      await client.get(
        url: any(URL.self, where: { $0.description.contains("branches/") }),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let results: [ParentModel] = try await requestAllParentsRegisterTask(apiClient: client, token, branchId, date, clockedOnPupilIds)

    // Assert
    verify(
      await client.get(
        url: any(URL.self, where: {
          $0.description.contains("/api/branches/\(branchId)") &&
          $0.description.contains(isoDate) &&
          $0.description.contains(deactivatedPupilId.uppercased())
        }),
        token: token
      )
    )
    .returning(BranchModel.self)
    .wasCalled(exactly(1))

    XCTAssertEqual(results.count, 2)
    XCTAssertEqual(results.first?.lastName, "ParentA")
    XCTAssertEqual(results.last?.lastName, "ParentB")
  }

  func testClockOnPupilTask() async throws {
    // Arrange
    let token = "fake-token"
    let pupilId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let branchId = 123
//    let date = Date(isoDate: "2022-03-10")

    let apiResponse = ClockOnModel(id: 321, branchId: branchId, date: "2022-03-10", clockOnTime: "12:25")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "pupilId", "branchId", "date", "clockOnTime"),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: ClockOnModel = try await clockOnPupilTask(apiClient: client, token, pupilId, branchId)

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
      .returning(ClockOnModel.self)
      .wasCalled(exactly(1))

    XCTAssertEqual(result.id, apiResponse.id)
  }

  func testClockOnFacilitatorTask() async throws {
    // Arrange
    let token = "fake-token"
    let facilitatorId = UUID(uuidString: "753dfb2b-e6c7-4d35-9e6c-0665394b3e6a")!
    let branchId = 21
//    let date = Date(isoDate: "2022-03-10")

    let apiResponse = ClockOnModel(id: 333, branchId: branchId, date: "2022-03-14", clockOnTime: "16:30")

    given(
      await client.post(
        url: any(URL.self),
        dictionary: any(keys: "parentId", "branchId", "date", "clockOnTime"),
        token: any(String.self)
      )
    )
      .willReturn(apiResponse)

    // Act
    let result: ClockOnModel = try await clockOnFacilitatorTask(apiClient: client, token, facilitatorId, branchId)

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
      .returning(ClockOnModel.self)
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

  func testPupilClockOffTask() async throws {
    // Arrange
    let token = "fake-clock-off-token"
    let attendanceId = 54321
    let expectedUrl = URL(string: "\(baseApiUrl)/attendances/\(attendanceId)")

    // Act
    try await clockOffPupilTask(apiClient: client, token, attendanceId)

    // Assert
    verify(
      await client.patch(
        url: expectedUrl!,
        dictionary: any(keys: "clockOffTime"),
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
