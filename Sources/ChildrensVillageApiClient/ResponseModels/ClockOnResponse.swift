//
//  ClockOnResponse.swift
//  See TokenResponse.swift for details explaining the extension approach.
//
//  Created by Chris Kobrzak on 06/09/2021.
//

import Foundation

public struct ClockOnResponse: Decodable {
  public let id: Int
  public let branchId: Int
  public let date: String
  public let clockOnTime: String
}

extension ClockOnResponse {
  enum CodingKeys: CodingKey {
    case id
    case pupilId
    case branchId
    case date
    case clockOnTime
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
       let id = try? container.decode(Int.self, forKey: .id),
       let branchId = try? container.decode(Int.self, forKey: .branchId),
       let date = try? container.decode(String.self, forKey: .date),
       let clockOnTime = try? container.decode(String.self, forKey: .clockOnTime) else {
      throw try ErrorResponse(from: decoder).error
    }

    self.init(
      id: id,
      branchId: branchId,
      date: date,
      clockOnTime: clockOnTime
    )
  }
}
