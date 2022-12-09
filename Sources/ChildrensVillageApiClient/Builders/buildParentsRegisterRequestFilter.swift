//
//  buildParentRegisterRequestFilter.swift
//  
//
//  Created by Chris Kobrzak on 05/12/2022.
//

import Foundation

func buildParentsRegisterRequestFilter(
  _ date: Date,
  _ maybeDeactivatedPupilIds: [UUID]?
) -> ParentRegisterRequestFilter {
  let (isoDate, _) = getLocalIsoTimeParts(date)
  let dayOfWeek = try! getDayOfWeek(date: date)
  
  var pupilPredicates: [PR.Where] = [PR.Where(active: true)]
  
  if !(maybeDeactivatedPupilIds?.isEmpty ?? true) {
    let idPredicate = PredicateInUuid(inq: maybeDeactivatedPupilIds!)
    pupilPredicates.append(PR.Where(id: idPredicate))
  }
  
  return APRRF(
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
                include: [
                  Relation(
                    relation: "parents",
                    scope: Relation.Scope(
                      include: [
                        Relation(
                          relation: "attendances",
                          scope:  Relation.Scope(
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
      )
    ]
  )
}
