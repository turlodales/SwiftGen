//
// SwiftGen
// Copyright © 2022 SwiftGen
// MIT Licence
//

import PathKit

public enum TemplateRef: Equatable {
  case name(String)
  case path(Path)

  enum Error: Swift.Error {
    case namedTemplateNotFound(name: String)
    case templatePathNotFound(path: Path)
    case noTemplateProvided
    case multipleTemplateOptions(path: String, name: String)
  }

  public init(templateShortName: String, templateFullPath: String) throws {
    switch (!templateFullPath.isEmpty, !templateShortName.isEmpty) {
    case (false, false):
      throw Self.Error.noTemplateProvided
    case (false, true):
      self = .name(templateShortName)
    case (true, false):
      self = .path(Path(templateFullPath))
    case (true, true):
      throw Self.Error.multipleTemplateOptions(path: templateFullPath, name: templateShortName)
    }
  }

  /// Returns the path of a template
  ///
  /// * If it's a `.path`, check that the path exists and return it (throws if it isn't an existing file)
  /// * If it's a `.name`, search the named template in the folder `parserName`
  ///   in the Application Support directory first, then in the bundled templates,
  ///   and returns the path if found (throws if none is found)
  ///
  /// - Parameter parserName: The folder to search for the template.
  ///                         Typically the name of one of the SwiftGen parsers like `strings`, `colors`, etc
  /// - Returns: The Path matching the template found
  /// - Throws: TemplateRef.Error
  ///
  public func resolvePath(forParser parser: ParserCLI, logger: (LogLevel, String) -> Void = logMessage) throws -> Path {
    switch self {
    case .name(let templateShortName):
      var path = Path.deprecatedAppSupportTemplates + parser.templateFolder + "\(templateShortName).stencil"
      if path.isFile {
        logger(
          .warning,
          """
          Referring to templates in Application Support by name is deprecated and will be removed in SwiftGen 7.0.
          For custom templates, please use `templatePath` instead of `templateName` to point to them.
          We also recommend you move your custom templates from \(Path.deprecatedAppSupportTemplates)
          to your project's folder so that your project is able to run independently on all machines.
          """
        )
      } else {
        path = Path.bundledTemplates + parser.templateFolder + "\(templateShortName).stencil"
      }
      guard path.isFile else {
        throw Self.Error.namedTemplateNotFound(name: templateShortName)
      }
      return path
    case .path(let fullPath):
      guard fullPath.isFile else {
        throw Self.Error.templatePathNotFound(path: fullPath)
      }
      return fullPath
    }
  }

  /// Check if the template is a bundled template for the given parser
  /// - Parameter parserName: The folder to search for the template.
  ///                         Typically the name of one of the SwiftGen parsers like `strings`, `colors`, etc
  /// - Returns: The Path matching the template found
  public func isBundled(forParser parser: ParserCLI) -> Bool {
    switch self {
    case .name(let templateShortName):
      let path = Path.bundledTemplates + parser.templateFolder + "\(templateShortName).stencil"
      return path.isFile
    case .path:
      return false
    }
  }
}

extension TemplateRef.Error: CustomStringConvertible {
  var description: String {
    switch self {
    case .namedTemplateNotFound(let name):
      return """
        Template named \(name) not found. Use `swiftgen template list` to list available named templates \
        or use `templatePath` to specify a template by its full path.
        """
    case .templatePathNotFound(let path):
      return "Template not found at path \(path.description)."
    case .noTemplateProvided:
      return """
        You must specify a template by name (templateName) or path (templatePath).

        To list all the available named templates, use 'swiftgen template list'.
        """
    case .multipleTemplateOptions(let path, let name):
      return "You need to choose EITHER a named template OR a template path. Found name '\(name)' and path '\(path)'"
    }
  }
}
