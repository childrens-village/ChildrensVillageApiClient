//
//  File.swift
//  
//
//  Created by Chris Kobrzak on 05/12/2022.
//

import Foundation

public func buildParentRegisterRequestFilter(
  _ date: Date,
  _ maybeDeactivatedPupilIds: [UUID]?
) -> ParentRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)
  let dayOfWeek = try! getDayOfWeek(date: date)

  var pupilPredicates: [APRRF.PupilsScope.PupilWhere] = [APRRF.PupilsScope.PupilWhere(active: true)]

  if !(maybeDeactivatedPupilIds?.isEmpty ?? true) {
    let idPredicate = PredicateInUuid(inq: maybeDeactivatedPupilIds!)
    pupilPredicates.append(APRRF.PupilsScope.PupilWhere(id: idPredicate))
  }

  return APRRF(
    include: [
      APRRF.DaysOfWeekRelation(
        relation: "daysOfWeek",
        scope: APRRF.DaysOfWeekScope(
          where: APRRF.DaysOfWeekScope.DaysOfWeekWhere(
            day: dayOfWeek
          ),
          include: [
            APRRF.PupilsRelation(
              relation: "pupils",
              scope: APRRF.PupilsScope(
                where: APRRF.PupilsScope.PupilOrPredicate(or: pupilPredicates),
                include: [
                  APRRF.PupilsScope.ParentsRelation(
                    relation: "parents",
                    scope: APRRF.ParentsScope(
                      include: [
                        ARRF(
                          relation: "attendances",
                          scope:  ARRF.AttendancesScope(
                            where: ARRF.AttendancesScope.AttendancesWhere(
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
      )
    ]
  )
}
