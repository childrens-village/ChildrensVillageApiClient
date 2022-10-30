//
//  buildDailyRegisterRequestFilter.swift
//  Builds a tree of nested structures representing the URL
//  filter for the daily register API request query string.
//
//  The second `maybeDeactivatedPupilIds` argument has been
//  introduced to include past pupils that might have been
//  present but due to the active=true filter, would not be
//  included in the results.
//
//  Created by Chris Kobrzak on 20/07/2021.
//  Updated by Chris Kobrzak on 29/10/2022.
//

import Foundation

public func buildPupilsRegisterRequestFilter(
  _ date: Date,
  _ maybeDeactivatedPupilIds: [UUID]?
) -> PupilsRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)
  let dayOfWeek = try! getDayOfWeek(date: date)

  var pupilPredicates: [PRRF.PupilWhere] = [PRRF.PupilWhere(active: true)]

  if !(maybeDeactivatedPupilIds?.isEmpty ?? true) {
    let idPredicate = PredicateInUuid(inq: maybeDeactivatedPupilIds!)
    pupilPredicates.append(PRRF.PupilWhere(id: idPredicate))
  }

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
                where: PRRF.PupilOrPredicate(or: pupilPredicates),
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
