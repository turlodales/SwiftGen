//
// SwiftGenKit UnitTests
// Copyright © 2022 SwiftGen
// MIT Licence
//

@testable import SwiftGenKit
import TestUtils
import XCTest

final class InterfaceBuilderiOSTests: XCTestCase {
  func testEmpty() throws {
    let parser = try InterfaceBuilder.Parser()

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "empty", sub: .interfaceBuilderiOS)
  }

  func testMessageStoryboard() throws {
    let parser = try InterfaceBuilder.Parser()
    do {
      try parser.searchAndParse(path: Fixtures.resource(for: "Message.storyboard", sub: .interfaceBuilderiOS))
    } catch {
      print("Error: \(error.localizedDescription)")
    }

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "messages", sub: .interfaceBuilderiOS)
  }

  func testAnonymousStoryboard() throws {
    let parser = try InterfaceBuilder.Parser()
    do {
      try parser.searchAndParse(path: Fixtures.resource(for: "Anonymous.storyboard", sub: .interfaceBuilderiOS))
    } catch {
      print("Error: \(error.localizedDescription)")
    }

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "anonymous", sub: .interfaceBuilderiOS)
  }

  func testAllStoryboards() throws {
    let parser = try InterfaceBuilder.Parser()
    do {
      try parser.searchAndParse(path: Fixtures.resourceDirectory(sub: .interfaceBuilderiOS))
    } catch {
      print("Error: \(error.localizedDescription)")
    }

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "all", sub: .interfaceBuilderiOS)
  }

  // ensure we still have a test case for checking support of module placeholders
  func testConsistencyOfModules() throws {
    let fakeModuleName = "NotCurrentModule"

    let parser = try InterfaceBuilder.Parser()
    try parser.searchAndParse(path: Fixtures.resourceDirectory(sub: .interfaceBuilderiOS))

    XCTAssert(
      parser.storyboards.contains { storyboard in
        storyboard.scenes.contains { $0.moduleIsPlaceholder && $0.module == fakeModuleName } &&
        storyboard.segues.contains { $0.moduleIsPlaceholder && $0.module == fakeModuleName }
      }
    )
  }

  // MARK: - Custom options

  func testUnknownOption() throws {
    do {
      _ = try InterfaceBuilder.Parser(options: ["SomeOptionThatDoesntExist": "foo"])
      XCTFail("Parser successfully created with an invalid option")
    } catch ParserOptionList.Error.unknownOption(let key, _) {
      // That's the expected exception we want to happen
      XCTAssertEqual(key, "SomeOptionThatDoesntExist", "Failed for unexpected option \(key)")
    } catch let error {
      XCTFail("Unexpected error occured: \(error)")
    }
  }
}
