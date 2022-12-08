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

func buildPupilsRegisterRequestFilter(
  _ date: Date,
  _ maybeDeactivatedPupilIds: [UUID]?
) -> PupilsRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)
  let dayOfWeek = try! getDayOfWeek(date: date)
  
  var pupilPredicates: [PR.Where] = [PR.Where(active: true)]
  
  if !(maybeDeactivatedPupilIds?.isEmpty ?? true) {
    let idPredicate = PredicateInUuid(inq: maybeDeactivatedPupilIds!)
    pupilPredicates.append(PR.Where(id: idPredicate))
  }
  
  return PRRF(
    include: [
      DOWR(
        relation: "daysOfWeek",
        scope: DOWR.Scope(
          where: DOWR.Where(
            day: dayOfWeek
          ),
          include: [
            PR(
              relation: "pupils",
              scope: PR.Scope(
                where: PR.Predicate(or: pupilPredicates),
                order: "firstName, lastName",
                include: [
                  Relation(
                    relation: "attendances",
                    scope: Relation.Scope(
                      where: Relation.Where(
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
