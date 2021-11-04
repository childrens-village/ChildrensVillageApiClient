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
    } catch let error as ApiError {
      print("Authentication failed. You need to specify correct credentials and try again.")
      throw error
    } catch {
      print("Unknown authentication error.")
      throw error
    }
  }

  func testRequestToken() async throws {
    do {
      let result: TokenResponse = try await requestToken(login, password)
      print("Token: \(result.token)")
    } catch let error as ApiError {
      print("Authentication failed: \(error.message)")
      throw error
    } catch {
      print("Authentication failed. Please enter correct credentials and try again.")
      throw error
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
      let result: DailyRegisterResponse = try await requestPupilsRegister(branchId: branchId, date: date, token: jwtToken)
      print("Branch ID: \(result.id)")
    } catch let error as ApiError {
      print("Request failed: \(error.message)")
      throw error
    }
  }

  func testRequestFacilitators() async throws {
    let date = Date(isoDate: "2021-10-18")

    do {
      let results: [FacilitatorResponse] = try await requestFacilitatorsRegister(token: jwtToken, date: date)
      print("Total: \(results.count)")
    } catch let error as ApiError {
      print("Request failed: \(error.message)")
      throw error
    }
  }

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
    } catch let error as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
      throw error
    } catch let error {
      print("ERROR \(error)")
      throw error
    }
  }

  func testClockOnPupil() async throws {
    let branchId = 1

    do {
      let result: ClockOnResponse = try await clockOnPupil(token: jwtToken, pupilId: pupilId, branchId: branchId)
      clockOnIds.append(result.id)
      print("Generated clock-on ID: \(result.id)")
    } catch let error as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
      throw error
    } catch let error {
      print("ERROR \(error)")
      throw error
    }
  }

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
      let result: ClockOnResponse = try await clockOnPupil(token: jwtToken, pupilId: pupilId, branchId: branchId, date: dateTime)
      clockOnIds.append(result.id)
      print("Generated clock-on ID: \(result.id)")
    } catch let error as ApiError {
      print("Request failed. You need to specify correct credentials and try again.")
      throw error
    } catch let error {
      print("ERROR \(error)")
      throw error
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
      throw error
    }
  }

  func testRevertPupilClockOn() async throws {
    let clockOnId = 40

    do {
      try await revertPupilClockOn(token: jwtToken, attendanceId: clockOnId)
    } catch let error as ApiError {
      print("Request failed. Invalid log-in reversion.")
      throw error
    } catch let error {
      print("ERROR \(error)")
      throw error
    }
  }

  override func tearDown() async throws {
    for clockOnId in clockOnIds {
      try await revertPupilClockOn(token: jwtToken, attendanceId: clockOnId)
    }
  }
}
