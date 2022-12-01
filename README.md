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

  func updatePassword(_ verificationToken: String, _ password: String) async throws -> Int

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

  func clockOffPupil(
    _ token: String,
    _ attendanceId: Int,
    _ date: Date?
  ) async throws
}
```

## Re-generating test mocks

1. Run `swift package update Mockingbird`
2. Uncomment the JwtApiClient target in `Package.json`
3. Delete the existing `Tests/ChildrensVillageApiClientTests/Mocks/JwtApiClientMocks.generated.swift` file
4. Run `./generate-mocks.sh`
