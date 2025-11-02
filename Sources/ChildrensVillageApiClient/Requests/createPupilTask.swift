//
//  createPupilTask.swift
//
//
//  Created on 25/06/2025.
//

import Foundation
import JwtApiClient

func createPupilTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupil: NewPupilRequestModel
) async throws -> UUID {
  let endpoint = buildPupilsUrlComponent().url!

  var body: [String: Any] = [
    "prefix": pupil.prefix.rawValue,
    "firstName": pupil.firstName,
    "lastName": pupil.lastName,
    "active": pupil.active,
    "photographyConsent": pupil.photographyConsent
  ]

  if let dateOfBirth = pupil.dateOfBirth {
    body["dateOfBirth"] = dateOfBirth
  }

  if let allergies = pupil.allergies {
    body["allergies"] = allergies
  }

  if let activeUntil = pupil.activeUntil {
    body["activeUntil"] = activeUntil
  }

  let createdPupil: PupilModel = try await apiClient.post(url: endpoint, dictionary: body, token: token)
  return createdPupil.id
}

fileprivate func buildPupilsUrlComponent() -> URLComponents {
  let path = "/pupils"

  return buildUrlComponent(path)
}
