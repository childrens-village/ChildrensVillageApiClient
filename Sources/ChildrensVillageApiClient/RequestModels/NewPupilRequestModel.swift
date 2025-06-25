//
//  NewPupilRequestModel.swift
//  ChildrensVillageApiClient
//
//  Created by Chris Kobrzak on 25/06/2025.
//
import Foundation

public struct NewPupilRequestModel: Codable, Equatable {
  public let prefix: TitlePrefix
  public let firstName: String
  public let lastName: String
  public let dateOfBirth: String
  public let active: Bool
  public let activeUntil: String?
  public let photographyConsent: Bool
  public let allergies: String
}
