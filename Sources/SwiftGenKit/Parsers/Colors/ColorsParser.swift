//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import PathKit

public enum Colors {
  public enum ParserError: Error, CustomStringConvertible {
    case colorNotFound(path: Path, name: String)
    case invalidHexColor(path: Path, string: String, key: String?)
    case invalidFile(path: Path, reason: String)
    case unsupportedFileType(path: Path, supported: [String])
    case unsupportedColorFormat(string: String, supported: [String])

    public var description: String {
      switch self {
      case .colorNotFound(let path, let name):
        return "error: Unable to find color \"\(name)\" (\(path))."
      case .invalidHexColor(let path, let string, let key):
        let keyInfo = key.flatMap { " for key \"\($0)\"" } ?? ""
        return "error: Invalid hex color \"\(string)\" found\(keyInfo) (\(path))."
      case .invalidFile(let path, let reason):
        return "error: Unable to parse file at \(path). \(reason)"
      case .unsupportedFileType(let path, let supported):
        return """
          error: Unsupported file type for \(path). \
          The supported file types are: \(supported.joined(separator: ", "))
          """
      case .unsupportedColorFormat(let string, let supported):
        return """
        error: Unsupported color format \(string). \
        The supported color formats are: \(supported.joined(separator: ", "))
        """
      }
    }
  }

  public enum Option {
    static let colorFormat = ParserOption(
      key: "colorFormat",
      defaultValue: "rgba",
      help: "Give the format of the colors in the file you want to parse."
    )
  }

  public enum ColorFormat: String, CaseIterable {
    case rgba
    case argb
  }

  public final class Parser: SwiftGenKit.Parser {
    private var parsers = [String: ColorsFileTypeParser.Type]()
    private let options: ParserOptionValues
    var palettes = [Palette]()
    public var warningHandler: Parser.MessageHandler?

    private static let subParsers: [ColorsFileTypeParser.Type] = [
      CLRFileParser.self,
      JSONFileParser.self,
      TextFileParser.self,
      XMLFileParser.self
    ]

    public init(options: [String: Any] = [:], warningHandler: Parser.MessageHandler? = nil) throws {
      self.options = try ParserOptionValues(options: options, available: Self.allOptions)
      self.warningHandler = warningHandler

      for parser in Self.subParsers {
        register(parser: parser)
      }
    }

    public static var defaultFilter: String {
      let extensions = Parser.subParsers.flatMap { $0.extensions }.sorted()
      return filterRegex(forExtensions: extensions)
    }

    public static var allOptions: ParserOptionList {
      ParserOptionList(lists: Self.subParsers.map { $0.allOptions })
    }

    public func parse(path: Path, relativeTo parent: Path) throws {
      guard let parserType = parsers[path.extension?.lowercased() ?? ""] else {
        throw ParserError.unsupportedFileType(path: path, supported: parsers.keys.sorted())
      }

      let parser = try parserType.init(options: options)
      let palette = try parser.parseFile(at: path)
      palettes += [palette]
    }

    func register(parser: ColorsFileTypeParser.Type) {
      for ext in parser.extensions {
        if let old = parsers[ext] {
          warningHandler?(
            """
            error: Parser \(parser) tried to register the file type '\(ext)' already \
            registered by \(old).
            """,
            #file,
            #line
          )
        }
        parsers[ext] = parser
      }
    }
  }
}
