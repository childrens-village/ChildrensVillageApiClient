import XCTest
@testable import ChildrensVillageApiClient
@testable import JwtApiClient

class ApiClientIntegrationTests: XCTestCase {
  var jwtToken = ""
  let login = "<login>"
  let password = "<password>"
  let baseUrl = "https://childrens-village.co.uk/api"
  let pupilId = "<pupil ID>"
  var clockOnIds: [Int] = []

  override func setUp() async throws {
    let url = URL(string: "\(baseUrl)/users/login")
    let credentials = [
      "email": login,
      "password": password
    ]

    do {
      let result: TokenResponse = try await postJsonDictionary(url!, credentials)
      jwtToken = result.token
    } catch _ as ApiError {
      print("Authentication failed. You need to specify correct credentials and try again.")
    } catch {
      print("Unknown authentication error.")
    }
  }

  func testRequestToken() async throws {
    do {
      let result: TokenResponse = try await requestToken(login, password)
      print("Token: \(result.token)")
    } catch let error as ApiError {
      print("Authentication failed: \(error.message)")
    } catch {
      print("Authentication failed. Please enter correct credentials and try again.")
    }
  }

  func testGetJsonWithToken() async throws {
    let branchId = 1
    let dayOfTheWeek = "Monday"

    let endpoint = "\(baseUrl)/branches/\(branchId)?filter=%7B%22include%22%3A%5B%7B%22relation%22%3A%22daysOfWeek%22%2C%22scope%22%3A%7B%22where%22%3A%7B%22day%22%3A%22\(dayOfTheWeek)%22%7D%2C%22include%22%3A%5B%7B%22relation%22%3A%22pupils%22%2C%22scope%22%3A%7B%22order%22%3A%22firstName%22%7D%7D%5D%7D%7D%5D%7D"

    let result: DailyRegisterResponse = try await getJsonWithToken(endpoint, token: jwtToken)

    assert(result.id == branchId)
  }

  func testRequestDailyRegister() async throws {
    let branchId = 1
    let date = Date(isoDate: "2021-09-07")

    do {
      let result: DailyRegisterResponse = try await requestDailyRegister(branchId: branchId, date: date, token: jwtToken)
      print("Branch ID: \(result.id)")
    } catch let error as ApiError {
      print("Request failed: \(error.message)")
    }
  }

//  TODO: Clean up data after running this test!
  func testPostJsonDictionary_clockOn() async throws {
    let url = URL(string: "\(baseUrl)/attendances")

    let branchId = 1
    let date = "2021-07-05"
    let clockOnTime = "09:25"

    let clockOnBody: [String: Any] = [
      "pupilId": pupilId,
      "branchId": branchId,
      "date": date,
      "clockOnTime": clockOnTime
    ]

    do {
      let result: ClockOnResponse = try await postJsonDictionaryWithToken(url, token: jwtToken, dictionary: clockOnBody)
      clockOnIds.append(result.id)
      print("Generated clock-on ID: \(result.id)")
    } catch _ as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
    } catch let error {
      print("ERROR \(error)")
    }
  }

//  TODO: Clean up data after running this test!
  func testClockOnPupil() async throws {
    let branchId = 1

    do {
      let result: ClockOnResponse = try await clockOnPupil(pupilId: pupilId, branchId: branchId, token: jwtToken)
      clockOnIds.append(result.id)
      print("Generated clock-on ID: \(result.id)")
    } catch _ as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
    } catch let error {
      print("ERROR \(error)")
    }
  }

  //  TODO: Clean up data after running this test!
  func testClockOnPupil_customDate() async throws {
    let branchId = 1
    var dc = DateComponents()
    dc.year = 2021
    dc.month = 9
    dc.day = 6
    dc.hour = 9
    dc.minute = 25
    dc.timeZone = TimeZone.current
    let dateTime = Calendar.current.date(from: dc)!

    do {
      let result: ClockOnResponse = try await clockOnPupil(pupilId: pupilId, branchId: branchId, token: jwtToken, date: dateTime)
      clockOnIds.append(result.id)
      print("Generated clock-on ID: \(result.id)")
    } catch _ as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
    } catch let error {
      print("ERROR \(error)")
    }
  }

  func testDeleteWithToken() async throws {
    let clockOnId = 40
    let endpoint = URL(string: "\(baseUrl)/attendances/\(clockOnId)")!

    do {
      try await deleteWithToken(endpoint, token: jwtToken)
    } catch _ as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
    } catch let error {
      print("ERROR \(error)")
    }
  }

  func testRevertPupilClockOn() async throws {
    let clockOnId = 40

    do {
      try await revertPupilClockOn(attendanceId: clockOnId, token: jwtToken)
    } catch _ as ApiError {
      print("Request failed. Invalid log-in reversion.")
    } catch let error {
      print("ERROR \(error)")
    }
  }

  override func tearDown() async throws {
    for clockOnId in clockOnIds {
      try await revertPupilClockOn(attendanceId: clockOnId, token: jwtToken)
    }
  }
}
