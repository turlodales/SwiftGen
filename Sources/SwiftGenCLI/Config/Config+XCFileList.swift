//
// SwiftGen
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import PathKit
import SwiftGenKit

extension Config {
  // MARK: Input XCFileList
  public func inputXCFileList() throws -> String {
    let inputPaths = try groupPathsByCommand { command, entry -> [Path] in
      let templatePaths = entry.outputs.compactMap { output -> Path? in
        guard case .path(let path) = output.template else { return nil }
        return path
      }

      let inputPaths = entry.inputs.map { (sourcePath + $0).absolute() }
      let filter = try Filter(
        pattern: entry.filter ?? command.parserType.defaultFilter,
        options: command.parserType.filterOptions
      )

      let matchingInputPaths = try command.parserType
        .subpaths(in: inputPaths, matching: filter)
        .map { $0.path }

      return templatePaths + matchingInputPaths
    }

    return xcFileList(for: inputPaths)
  }

  // MARK: Output XCFileList
  public func outputXCFileList() throws -> String {
    let outputPaths = try groupPathsByCommand { _, entry -> [Path] in
      entry.outputs.map { (sourcePath + $0.output).absolute() }
    }

    return xcFileList(for: outputPaths)
  }

  // MARK: Helpers

  private func groupPathsByCommand(
    pathsForEntry: (ParserCLI, ConfigEntry) throws -> [Path]
  ) throws -> [String: Set<Path>] {
    var pathsByCommand: [String: Set<Path>] = [:]

    for (command, var entry) in commands {
      entry.makeRelativeTo(inputDir: inputDir, outputDir: outputDir)
      let paths = try pathsForEntry(command, entry)
      pathsByCommand[command.name, default: []].formUnion(paths)
    }

    return pathsByCommand
  }

  /// Generates `xcfilelist` with all the paths, grouped per command into sections, like:
  ///
  ///     # fonts
  ///     …
  ///
  ///     # xcassets
  ///     …
  private func xcFileList(for pathsByCommand: [String: Set<Path>]) -> String {
    pathsByCommand
      .sorted { $0.key < $1.key }
      .map { commandName, paths in
        let formattedPaths = paths.sorted()
          .map { $0.string.replacingOccurrences(of: Path.current.absolute().string, with: "$(SRCROOT)") }
          .joined(separator: "\n")

        return """
          # \(commandName)
          \(formattedPaths)
          """
      }
      .joined(separator: "\n\n")
  }
}
