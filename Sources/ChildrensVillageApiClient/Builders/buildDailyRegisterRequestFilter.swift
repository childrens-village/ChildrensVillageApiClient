//
//  buildDailyRegisterRequestFilter.swift
//  buildDailyRegisterRequestFilter
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildDailyRegisterRequestFilter(_ dayOfWeekIndex: Int) -> DailyRegisterFilterRequestNode {
  let dayOfWeek = getDayOfWeekByIndex(dayOfWeekIndex)

  return DailyRegisterFilterRequestNode(
    include: [
      DailyRegisterFilterRequestNode.DaysOfWeekRelation(
        relation: "daysOfWeek",
        scope: DailyRegisterFilterRequestNode.DaysOfWeekScope(
          where: DailyRegisterFilterRequestNode.DaysOfWeekWhere(
            day: dayOfWeek
          ),
          include: [
            DailyRegisterFilterRequestNode.PupilsRelation(
              relation: "pupils",
              scope: DailyRegisterFilterRequestNode.PupilsScope(
                order: "lastName, firstName"
              )
            )
          ]
        )
      )
    ]
  )
}
