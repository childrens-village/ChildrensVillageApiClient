import Foundation

public struct AttendanceModel: Identifiable, Decodable, Sendable {
  public let id: Int?
  public let pupilId: UUID?
  public let branchId: Int?
  public let date: String?
  public let clockOnTime: String?
  public let clockOffTime: String?
  public let note: String?
}
