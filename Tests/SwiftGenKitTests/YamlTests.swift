//
// SwiftGenKit UnitTests
// Copyright © 2022 SwiftGen
// MIT Licence
//

import PathKit
@testable import SwiftGenKit
import TestUtils
import XCTest

final class YamlTests: XCTestCase {
  func testEmpty() throws {
    let parser = try Yaml.Parser()

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "empty", sub: .yaml)
  }

  func testSequence() throws {
    let parser = try Yaml.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "grocery-list.yaml", sub: .yamlGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "grocery-list", sub: .yaml)
  }

  func testMapping() throws {
    let parser = try Yaml.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "mapping.yaml", sub: .yamlGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "mapping", sub: .yaml)
  }

  func testScalar() throws {
    let parser = try Yaml.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "version.yaml", sub: .yamlGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "version", sub: .yaml)
  }

  func testMutlipleDocuments() throws {
    let parser = try Yaml.Parser()
    try parser.searchAndParse(path: Fixtures.resource(for: "documents.yaml", sub: .yamlGood))

    let result = parser.stencilContext()
    XCTDiffContexts(result, expected: "documents", sub: .yaml)
  }

  func testDirectoryInput() {
    do {
      let parser = try Yaml.Parser()
      let filter = try Filter(pattern: "[^/]*\\.(json|ya?ml)$")
      try parser.searchAndParse(path: Fixtures.resourceDirectory(sub: .yamlGood), filter: filter)

      let result = parser.stencilContext()
      XCTDiffContexts(result, expected: "all", sub: .yaml)
    } catch let error {
      XCTFail("Unexpected error occured while parsing: \(error)")
    }
  }

  func testFileWithBadSyntax() {
    do {
      _ = try Yaml.Parser().searchAndParse(path: Fixtures.resource(for: "syntax.yaml", sub: .yamlBad))
      XCTFail("Code did parse file successfully while it was expected to fail for bad syntax")
    } catch Yaml.ParserError.invalidFile {
      // That's the expected exception we want to happen
    } catch let error {
      XCTFail("Unexpected error occured while parsing: \(error)")
    }
  }

  // MARK: - Custom options

  func testUnknownOption() throws {
    do {
      _ = try Yaml.Parser(options: ["SomeOptionThatDoesntExist": "foo"])
      XCTFail("Parser successfully created with an invalid option")
    } catch ParserOptionList.Error.unknownOption(let key, _) {
      // That's the expected exception we want to happen
      XCTAssertEqual(key, "SomeOptionThatDoesntExist", "Failed for unexpected option \(key)")
    } catch let error {
      XCTFail("Unexpected error occured: \(error)")
    }
  }
}
