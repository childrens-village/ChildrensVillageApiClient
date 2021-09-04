import XCTest
@testable import ChildrensVillageApiClient
@testable import JwtApiClient

@available(iOS 15.0.0, *)
class ApiClientIntegrationTests: XCTestCase {
  var jwtToken = ""
  let baseUrl = "https://childrens-village.co.uk/api"

  override func setUp() async throws {
    let url = URL(string: "\(baseUrl)/users/login")
    let credentials = [
      "email": "<login>",
      "password": "<password>"
    ]

    do {
      let result: Token = try await requestTokenWithJsonCredentials(url!, credentials)
      jwtToken = result.token
    } catch {
      print("Authentication failed. Please enter correct credentials and try again.")
    }
  }

  func testRequestTokenWithJsonCredentials() async throws {
    let url = URL(string: "\(baseUrl)/users/login")
    let credentials = [
      "email": "joe@bloggs.com",
      "password": "wrongPassword"
    ]

    let result: TokenError = try await requestTokenWithJsonCredentials(url!, credentials)

    print("Error details: \(result.error.name)")
  }

  func testRequestWithAuthorisation() async throws {
    let branchId = 1
    let dayOfTheWeek = "Monday"

    let endpoint = "\(baseUrl)/branches/\(branchId)?filter=%7B%22include%22%3A%5B%7B%22relation%22%3A%22daysOfWeek%22%2C%22scope%22%3A%7B%22where%22%3A%7B%22day%22%3A%22\(dayOfTheWeek)%22%7D%2C%22include%22%3A%5B%7B%22relation%22%3A%22pupils%22%2C%22scope%22%3A%7B%22order%22%3A%22firstName%22%7D%7D%5D%7D%7D%5D%7D"

    let result: PupilsByDayByBranch = try await requestWithAuthorisation(endpoint, token: jwtToken)

    assert(result.id == branchId)
  }

  func testRequestDailyRegister() async throws {
    let branchId = 1
    let dayOfTheWeek = DayOfWeek.Monday

    let _: [Pupil] = try await requestDailyRegister(branchId: branchId, dayOfWeek: dayOfTheWeek, token: jwtToken)
  }
}
