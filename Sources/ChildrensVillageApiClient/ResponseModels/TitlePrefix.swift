import Foundation

public enum TitlePrefix: String, Codable, Sendable, CaseIterable {
  case Ms
  case Master
  case Miss
  case Mrs
  case Mr
  case Mx
}

// MARK: - Category extensions
public extension TitlePrefix {
  static var childCases: [TitlePrefix] {
    [.Miss, .Master, .Mx]
  }

  static var adultCases: [TitlePrefix] {
    [.Ms, .Mrs, .Mr, .Mx]
  }
}
