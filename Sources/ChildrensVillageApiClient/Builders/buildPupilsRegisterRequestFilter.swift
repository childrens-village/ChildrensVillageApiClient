//
//  buildDailyRegisterRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the daily register API request query string.
//
//  Created by Chris Kobrzak on 20/07/2021.
//

import Foundation

public func buildPupilsRegisterRequestFilter(_ date: Date) -> PupilsRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)
  let dayOfWeek = try! getDayOfWeek(date: date)

  return PRRF(
    include: [
      PRRF.DaysOfWeekRelation(
        relation: "daysOfWeek",
        scope: PRRF.DaysOfWeekScope(
          where: PRRF.DaysOfWeekWhere(
            day: dayOfWeek
          ),
          include: [
            PRRF.PupilsRelation(
              relation: "pupils",
              scope: PRRF.PupilsScope(
                where: PRRF.PupilWhere(active: true),
                order: "firstName, lastName",
                include: [
                  ARRF(
                    relation: "attendances",
                    scope: ARRF.AttendancesScope(
                      where: ARRF.AttendancesWhere(
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
