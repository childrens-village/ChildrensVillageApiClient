//
//  JwtApiClientMocks.generated.swift
//  JwtApiClient
//
//  Generated by Mockingbird v0.20.0.
//  DO NOT EDIT
//

@testable import JwtApiClient
@testable import Mockingbird
import Foundation
import Swift

private let mkbGenericStaticMockContext = Mockingbird.GenericStaticMockContext()

// MARK: - Mocked JsonApiClient
public final class JsonApiClientMock: JwtApiClient.JsonApiClient, Mockingbird.Mock {
  typealias MockingbirdSupertype = JwtApiClient.JsonApiClient
  public static let mockingbirdContext = Mockingbird.Context()
  public let mockingbirdContext = Mockingbird.Context(["generator_version": "0.20.0", "module_name": "JwtApiClient"])

  public enum InitializerProxy {
    public static func initialize(__file: StaticString = #file, __line: UInt = #line) -> JsonApiClientMock {
      let mock: JsonApiClientMock = JsonApiClientMock()
      mock.mockingbirdContext.sourceLocation = SourceLocation(__file, __line)
      return mock
    }
  }

  // MARK: Mocked `post`(`url`: URL, `dictionary`: [String: Any])
  public override func `post`(`url`: URL, `dictionary`: [String: Any]) async throws -> URLResponse {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`post`(`url`: URL, `dictionary`: [String: Any]) async throws -> URLResponse", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`dictionary`)], returnType: Swift.ObjectIdentifier((URLResponse).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, [String: Any]) async throws -> URLResponse { return try await mkbImpl(`url`, `dictionary`) }
      if let mkbImpl = mkbImpl as? () async throws -> URLResponse { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`post`(url: `url`, dictionary: `dictionary`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: URLResponse = try await mkbObject.`post`(url: `url`, dictionary: `dictionary`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (URLResponse).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `post`(`url`: @autoclosure () -> URL, `dictionary`: @autoclosure () -> [String: Any]) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any]) async throws -> URLResponse, URLResponse> {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any]) async throws -> URLResponse, URLResponse>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`post`(`url`: URL, `dictionary`: [String: Any]) async throws -> URLResponse", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`dictionary`)], returnType: Swift.ObjectIdentifier((URLResponse).self)))
  }

  // MARK: Mocked init()
  public required override init() {
    super.init()
    self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "init()", selectorType: Mockingbird.SelectorType.method, arguments: [], returnType: Swift.ObjectIdentifier((Void).self)))
  }

  public func initialize() -> Mockingbird.Mockable<Mockingbird.FunctionDeclaration, () -> Void, Void> {
    return Mockingbird.Mockable<Mockingbird.FunctionDeclaration, () -> Void, Void>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "init()", selectorType: Mockingbird.SelectorType.method, arguments: [], returnType: Swift.ObjectIdentifier((Void).self)))
  }

  // MARK: Mocked `delete`(`url`: URL, `token`: String)
  public override func `delete`(`url`: URL, `token`: String) async throws -> Void {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`delete`(`url`: URL, `token`: String) async throws -> Void", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`token`)], returnType: Swift.ObjectIdentifier((Void).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, String) async throws -> Void { return try await mkbImpl(`url`, `token`) }
      if let mkbImpl = mkbImpl as? () async throws -> Void { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`delete`(url: `url`, token: `token`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: Void = try await mkbObject.`delete`(url: `url`, token: `token`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (Void).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `delete`(`url`: @autoclosure () -> URL, `token`: @autoclosure () -> String) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, String) async throws -> Void, Void> {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, String) async throws -> Void, Void>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`delete`(`url`: URL, `token`: String) async throws -> Void", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`token`)], returnType: Swift.ObjectIdentifier((Void).self)))
  }

  // MARK: Mocked `patch`(`url`: URL, `dictionary`: [String: Any], `token`: String)
  public override func `patch`(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> Void {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`patch`(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> Void", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`dictionary`), Mockingbird.ArgumentMatcher(`token`)], returnType: Swift.ObjectIdentifier((Void).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, [String: Any], String) async throws -> Void { return try await mkbImpl(`url`, `dictionary`, `token`) }
      if let mkbImpl = mkbImpl as? () async throws -> Void { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`patch`(url: `url`, dictionary: `dictionary`, token: `token`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: Void = try await mkbObject.`patch`(url: `url`, dictionary: `dictionary`, token: `token`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (Void).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `patch`(`url`: @autoclosure () -> URL, `dictionary`: @autoclosure () -> [String: Any], `token`: @autoclosure () -> String) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any], String) async throws -> Void, Void> {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any], String) async throws -> Void, Void>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`patch`(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> Void", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`dictionary`), Mockingbird.resolve(`token`)], returnType: Swift.ObjectIdentifier((Void).self)))
  }

  // MARK: Mocked `get`<T>(`url`: URL, `token`: String)
  public override func `get`<T>(`url`: URL, `token`: String) async throws -> T where T: Decodable {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`get`<T>(`url`: URL, `token`: String) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`token`)], returnType: Swift.ObjectIdentifier((T).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, String) async throws -> T { return try await mkbImpl(`url`, `token`) }
      if let mkbImpl = mkbImpl as? () async throws -> T { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`get`(url: `url`, token: `token`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: T = try await mkbObject.`get`(url: `url`, token: `token`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (T).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `get`<T>(`url`: @autoclosure () -> URL, `token`: @autoclosure () -> String) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, String) async throws -> T, T> where T: Decodable {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, String) async throws -> T, T>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`get`<T>(`url`: URL, `token`: String) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`token`)], returnType: Swift.ObjectIdentifier((T).self)))
  }

  // MARK: Mocked `post`<T>(`url`: URL, `dictionary`: [String: Any])
  public override func `post`<T>(`url`: URL, `dictionary`: [String: Any]) async throws -> T where T: Decodable {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`post`<T>(`url`: URL, `dictionary`: [String: Any]) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`dictionary`)], returnType: Swift.ObjectIdentifier((T).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, [String: Any]) async throws -> T { return try await mkbImpl(`url`, `dictionary`) }
      if let mkbImpl = mkbImpl as? () async throws -> T { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`post`(url: `url`, dictionary: `dictionary`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: T = try await mkbObject.`post`(url: `url`, dictionary: `dictionary`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (T).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `post`<T>(`url`: @autoclosure () -> URL, `dictionary`: @autoclosure () -> [String: Any]) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any]) async throws -> T, T> where T: Decodable {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any]) async throws -> T, T>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`post`<T>(`url`: URL, `dictionary`: [String: Any]) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`dictionary`)], returnType: Swift.ObjectIdentifier((T).self)))
  }

  // MARK: Mocked `post`<T>(`url`: URL, `dictionary`: [String: Any], `token`: String)
  public override func `post`<T>(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> T where T: Decodable {
    return try await self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`post`<T>(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`url`), Mockingbird.ArgumentMatcher(`dictionary`), Mockingbird.ArgumentMatcher(`token`)], returnType: Swift.ObjectIdentifier((T).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (URL, [String: Any], String) async throws -> T { return try await mkbImpl(`url`, `dictionary`, `token`) }
      if let mkbImpl = mkbImpl as? () async throws -> T { return try await mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          return try await super.`post`(url: `url`, dictionary: `dictionary`, token: `token`)
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: T = try await mkbObject.`post`(url: `url`, dictionary: `dictionary`, token: `token`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (T).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `post`<T>(`url`: @autoclosure () -> URL, `dictionary`: @autoclosure () -> [String: Any], `token`: @autoclosure () -> String) async -> Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any], String) async throws -> T, T> where T: Decodable {
    return Mockingbird.Mockable<Mockingbird.ThrowingAsyncFunctionDeclaration, (URL, [String: Any], String) async throws -> T, T>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`post`<T>(`url`: URL, `dictionary`: [String: Any], `token`: String) async throws -> T where T: Decodable", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`url`), Mockingbird.resolve(`dictionary`), Mockingbird.resolve(`token`)], returnType: Swift.ObjectIdentifier((T).self)))
  }
}

/// Returns an abstract mock which should be initialized using `mock(JsonApiClient.self).initialize(…)`.
public func mock(_ type: JwtApiClient.JsonApiClient.Type, file: StaticString = #file, line: UInt = #line) -> JsonApiClientMock.InitializerProxy.Type {
  return JsonApiClientMock.InitializerProxy.self
}
