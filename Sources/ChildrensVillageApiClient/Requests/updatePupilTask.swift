//
//  updatePupilTask.swift
//
//
//  Created on 2/11/2025.
//

import Foundation
import JwtApiClient

func updatePupilTask(
  apiClient: JsonApiCompatible = JsonApiClient(),
  _ token: String,
  _ pupilId: UUID,
  _ pupil: UpdatePupilRequestModel
) async throws {
  let endpoint = buildPupilUrlComponent(pupilId: pupilId).url!

  var body: [String: Any] = [:]

  if let prefix = pupil.prefix {
    body["prefix"] = prefix.rawValue
  }
  if let firstName = pupil.firstName {
    body["firstName"] = firstName
  }
  if let lastName = pupil.lastName {
    body["lastName"] = lastName
  }
  if let dateOfBirth = pupil.dateOfBirth {
    body["dateOfBirth"] = dateOfBirth
  }
  if let active = pupil.active {
    body["active"] = active
  }
  if let activeUntil = pupil.activeUntil {
    body["activeUntil"] = activeUntil
  }
  if let photographyConsent = pupil.photographyConsent {
    body["photographyConsent"] = photographyConsent
  }
  if let allergies = pupil.allergies {
    body["allergies"] = allergies
  }

  try await apiClient.patch(url: endpoint, dictionary: body, token: token)
}

fileprivate func buildPupilUrlComponent(pupilId: UUID) -> URLComponents {
  let path = "/pupils/\(pupilId)"

  return buildUrlComponent(path)
}
