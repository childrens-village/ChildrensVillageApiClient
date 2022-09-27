//
//  ClockOnModel.swift
//
//  Created by Chris Kobrzak on 27/09/2022.
//

import Foundation

public struct ClockOnModel: ClockOnConfirming, Decodable {
  public let id: Int
  public let branchId: Int
  public let date: String
  public let clockOnTime: String
}
