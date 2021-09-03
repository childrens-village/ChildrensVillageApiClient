//
//  buildDailyRegisterRequestFilter.swift
//  buildDailyRegisterRequestFilter
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildDailyRegisterRequestFilter(_ dayOfWeekIndex: Int) -> DailyRegisterFilterRequestNode {
  let dayOfWeek = getDayOfWeekByIndex(dayOfWeekIndex)

  return DRFRN(
    include: [
      DRFRN.DaysOfWeekRelation(
        relation: "daysOfWeek",
        scope: DRFRN.DaysOfWeekScope(
          where: DRFRN.DaysOfWeekWhere(
            day: dayOfWeek
          ),
          include: [
            DRFRN.PupilsRelation(
              relation: "pupils",
              scope: DRFRN.PupilsScope(
                order: "lastName, firstName"
              )
            )
          ]
        )
      )
    ]
  )
}
