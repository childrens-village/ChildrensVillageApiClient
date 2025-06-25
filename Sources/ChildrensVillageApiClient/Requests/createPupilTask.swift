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
) async throws -> PupilModel {
  let endpoint = buildPupilsUrlComponent().url!

  var body: [String: Any] = [
    "prefix": pupil.prefix.rawValue,
    "firstName": pupil.firstName,
    "lastName": pupil.lastName,
    "dateOfBirth": pupil.dateOfBirth,
    "active": pupil.active,
    "photographyConsent": pupil.photographyConsent,
    "allergies": pupil.allergies
  ]

  if let activeUntil = pupil.activeUntil {
    body["activeUntil"] = activeUntil
  }

  return try await apiClient.post(url: endpoint, dictionary: body, token: token)
}

fileprivate func buildPupilsUrlComponent() -> URLComponents {
  let path = "/pupils"

  return buildUrlComponent(path)
}
