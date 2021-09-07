//
//  buildDailyRegisterRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the daily register API request query string.
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildDailyRegisterRequestFilter(_ date: Date) -> DailyRegisterFilterRequestNode {
  let (isoDate, _, dayOfWeek) = getLocalIsoTimeParts(date)

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
                order: "firstName, lastName",
                include: [
                  DRFRN.AttendancesRelation(
                    relation: "attendances",
                    scope: DRFRN.AttendancesScope(
                      where: DRFRN.AttendancesWhere(
                        date: isoDate
                      )
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    ]
  )
}
