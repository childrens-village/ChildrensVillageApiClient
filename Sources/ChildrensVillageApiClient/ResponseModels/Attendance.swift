import Foundation

public struct Attendance: Identifiable, Decodable {
  public let id: Int
  public let pupilId: String?
  public let branchId: Int?
  public let date: String
  public let clockOnTime: String
  public let clockOffTime: String?
  public let note: String?
}
