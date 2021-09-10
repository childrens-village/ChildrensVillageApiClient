import XCTest
@testable import ChildrensVillageApiClient
@testable import JwtApiClient

class ApiClientIntegrationTests: XCTestCase {
  var jwtToken = ""
  let login = "<login>"
  let password = "<password>"
  let baseUrl = "https://childrens-village.co.uk/api"

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
}
