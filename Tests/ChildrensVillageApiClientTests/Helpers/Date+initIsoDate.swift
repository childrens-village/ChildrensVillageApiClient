//
//  Date+initIsoDate.swift
//
//  Created by Chris Kobrzak on 09/09/2021.
//  https://stackoverflow.com/a/24090354/764906
//

import Foundation

extension Date {
  init(isoDate: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    let date = formatter.date(from: isoDate)!

    self.init(timeInterval: 0, since: date)
  }
}
