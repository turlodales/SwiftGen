//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import PathKit

public protocol Parser {
  /// Parser initializer. Please use the `createWith(options:warningHandler:)` factory method instead,
  /// it'll ensure the safety of the provided options.
  ///
  /// - Parameter options: Dictionary of options, used to customize processing.
  /// - Parameter warningHandler: Callback for logging issues.
  init(options: [String: Any], warningHandler: MessageHandler?) throws

  /// Regex for the default filter
  static var defaultFilter: String { get }

  /// Filter options (defaults to skipping hidden files, package descendants and directories)
  static var filterOptions: Filter.Options { get }

  /// List of supported options (defaults to none)
  static var allOptions: ParserOptionList { get }

  /// Try to parse the file (or directory) at the given path, relative to some parent path.
  ///
  /// - Parameter path: The file/directory to parse
  /// - Parameter parent: The parent path (may not be the direct parent)
  func parse(path: Path, relativeTo parent: Path) throws

  /// Generate the stencil context from the parsed content.
  ///
  /// - Returns: A dictionary representing the parsed data 
  func stencilContext() -> [String: Any]

  /// This callback will be called when a Parser want to emit a diagnostics message
  /// You can set this on the usage-site to a closure that prints the diagnostics in any way you see fit
  /// Arguments are (message, file, line)
  typealias MessageHandler = (String, String, UInt) -> Void
  var warningHandler: MessageHandler? { get set }
}

public extension Parser {
  /// Recursively search through the given paths, parsing any file or folder that matches the given filter.
  ///
  /// - Parameter paths: The paths to search recursively through.
  /// - Parameter filter: The filter to apply to each path.
  func searchAndParse(paths: [Path], filter: Filter) throws {
    for path in paths {
      try searchAndParse(path: path, filter: filter)
    }
  }

  /// Recursively search through the given path, parsing any file or folder that matches the given filter.
  ///
  /// - Parameter path: The path to search recursively through.
  /// - Parameter filter: The filter to apply to each path.
  func searchAndParse(path: Path, filter: Filter) throws {
    for (path, parentDir) in try Self.subpaths(in: path, matching: filter) {
      try parse(path: path, relativeTo: parentDir)
    }
  }

  /// Recursively search through the given paths, returning any files or folders that matches the given filter.
  ///
  /// - Parameter paths: The paths to search recursively through.
  /// - Parameter filter: The filter to apply to each path.
  /// - Returns: Each path, and it's parent path, found matching the filter.
  static func subpaths(in paths: [Path], matching filter: Filter) throws -> [(path: Path, parentDir: Path)] {
    try paths.flatMap { try subpaths(in: $0, matching: filter) }
  }

  /// Recursively search through the given path, returning any files or folders that matches the given filter.
  ///
  /// - Parameter path: The path to search recursively through.
  /// - Parameter filter: The filter to apply to each path.
  /// - Returns: Each path, and it's parent path, found matching the filter.
  static func subpaths(in path: Path, matching filter: Filter) throws -> [(path: Path, parentDir: Path)] {
    if path.matches(filter: filter) {
      let parentDir = path.absolute().parent()
      return [(path, parentDir)]
    } else {
      let parentDir = path.absolute()
      return path
        .iterateChildren(options: [.skipsHiddenFiles, .skipsPackageDescendants])
        .filter { $0.matches(filter: filter) }
        .map { ($0, parentDir) }
    }
  }
}

public extension Parser {
  static var filterOptions: Filter.Options {
    .default
  }

  static var allOptions: ParserOptionList {
    []
  }
}
