//
//  Attending.swift
//
//  Created by Chris Kobrzak on 02/11/2021.
//

import Foundation

public protocol Attending {
  var id: String  { get }
  var prefix: TitlePrefix { get }
  var firstName: String { get }
  var lastName: String { get }
  var attendances: [Attendance]? { get }
}
