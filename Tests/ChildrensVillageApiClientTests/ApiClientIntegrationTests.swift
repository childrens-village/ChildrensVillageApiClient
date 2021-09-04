import XCTest
@testable import ChildrensVillageApiClient
@testable import JwtApiClient

// You will need to re-generate this token for the test to pass
let jwtToken = "<valid.token.here>"

class ApiClientIntegrationTests: XCTestCase {
  @available(iOS 15.0.0, *)
  func testRequestWithAuthorisation() async throws {
    let branchId = 1
    let dayOfTheWeek = "Monday"

    let endpoint = "https://childrens-village.co.uk/api/branches/\(branchId)?filter=%7B%22include%22%3A%5B%7B%22relation%22%3A%22daysOfWeek%22%2C%22scope%22%3A%7B%22where%22%3A%7B%22day%22%3A%22\(dayOfTheWeek)%22%7D%2C%22include%22%3A%5B%7B%22relation%22%3A%22pupils%22%2C%22scope%22%3A%7B%22order%22%3A%22firstName%22%7D%7D%5D%7D%7D%5D%7D"

    let result: PupilsByDayByBranch = try await requestWithAuthorisation(endpoint, token: jwtToken)

    assert(result.id == branchId)
  }

  @available(iOS 15.0.0, *)
  func testRequestDailyRegister() async throws {
    let branchId = 1
    let dayOfTheWeek = DayOfWeek.Monday

    let _: [Pupil] = try await requestDailyRegister(branchId: branchId, dayOfWeek: dayOfTheWeek, token: jwtToken)
  }
}
