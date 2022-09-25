//
//  ClockOnConfirming.swift
//
//  Created by Chris Kobrzak on 25/09/2022.
//

import Foundation

public protocol ClockOnConfirming {
  var id: Int { get }
  var branchId: Int { get }
  var date: String { get }
  var clockOnTime: String { get }
}
