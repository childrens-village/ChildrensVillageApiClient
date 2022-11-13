# ChildrensVillageApiClient

A collection of requests intended to be used by the Children's Village Facilitator Area iOS app.

## API

```swift
protocol ChildrensVillageApiCompatible {
  func requestToken(
    _ username: String,
    _ password: String
  ) async throws -> TokenResponse

  func requestPasswordReset( _ username: String) async throws -> Int

  func requestPupil(
    _ token: String,
    _ pupilId: UUID
  ) async throws -> PupilModel

  func requestPupilsRegister(
    _ token: String,
    _ branchId: Int,
    _ date: Date
  ) async throws -> [Pupil]

  func requestFacilitatorsRegister(
    _ token: String,
    _ date: Date
  ) async throws -> [Parent]

  func clockOnPupil(
    _ token: String,
    _ pupilId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse

  func clockOnFacilitator(
    _ token: String,
    _ facilitatorId: String,
    _ branchId: Int,
    _ date: Date?
  ) async throws -> ClockOnResponse

  func revertPupilClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws

  func revertFacilitatorClockOn(
    _ token: String,
    _ attendanceId: Int
  ) async throws
}
```
