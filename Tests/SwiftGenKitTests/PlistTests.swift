//
// SwiftGenKit UnitTests
// Copyright © 2022 SwiftGen
// MIT Licence
//

import PathKit
@testable import SwiftGenKit
import TestUtils
import XCTest

final class PlistTests: XCTestCase {
  func testEmpty() throws {
    let parser = try Plist.Parser()

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "empty", sub: .plist)
  }

  func testArray() throws {
    let parser = try Plist.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "shopping-list.plist", sub: .plistGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "shopping-list", sub: .plist)
  }

  func testDictionary() throws {
    let parser = try Plist.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "configuration.plist", sub: .plistGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "configuration", sub: .plist)
  }

  func testInfo() throws {
    let parser = try Plist.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "Info.plist", sub: .plistGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "info", sub: .plist)
  }

  func testDirectoryInput() {
    do {
      let parser = try Plist.Parser()
      try parser.searchAndParse(path: Fixtures.resourceDirectory(sub: .plistGood))

      let result = parser.stencilContext()
      XCTDiffContexts(result, expected: "all", sub: .plist)
    } catch let error {
      XCTFail("Unexpected error occured while parsing: \(error)")
    }
  }

  func testFileWithBadSyntax() {
    do {
      _ = try Plist.Parser().searchAndParse(path: Fixtures.resource(for: "syntax.plist", sub: .plistBad))
      XCTFail("Code did parse file successfully while it was expected to fail for bad syntax")
    } catch Plist.ParserError.invalidFile {
      // That's the expected exception we want to happen
    } catch let error {
      XCTFail("Unexpected error occured while parsing: \(error)")
    }
  }

  // MARK: - Custom options

  func testUnknownOption() throws {
    do {
      _ = try AssetsCatalog.Parser(options: ["SomeOptionThatDoesntExist": "foo"])
      XCTFail("Parser successfully created with an invalid option")
    } catch ParserOptionList.Error.unknownOption(let key, _) {
      // That's the expected exception we want to happen
      XCTAssertEqual(key, "SomeOptionThatDoesntExist", "Failed for unexpected option \(key)")
    } catch let error {
      XCTFail("Unexpected error occured: \(error)")
    }
  }
}
