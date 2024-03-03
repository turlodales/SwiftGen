// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
public typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum FontFamily {
  public enum SFNSDisplay {
    public static let black = FontConvertible(name: ".SFNSDisplay-Black", family: ".SF NS Display", path: "SFNSDisplay-Black.otf")
    public static let bold = FontConvertible(name: ".SFNSDisplay-Bold", family: ".SF NS Display", path: "SFNSDisplay-Bold.otf")
    public static let heavy = FontConvertible(name: ".SFNSDisplay-Heavy", family: ".SF NS Display", path: "SFNSDisplay-Heavy.otf")
    public static let regular = FontConvertible(name: ".SFNSDisplay-Regular", family: ".SF NS Display", path: "SFNSDisplay-Regular.otf")
    public static let all: [FontConvertible] = [black, bold, heavy, regular]
  }
  public enum SFNSText {
    public static let bold = FontConvertible(name: ".SFNSText-Bold", family: ".SF NS Text", path: "SFNSText-Bold.otf")
    public static let heavy = FontConvertible(name: ".SFNSText-Heavy", family: ".SF NS Text", path: "SFNSText-Heavy.otf")
    public static let regular = FontConvertible(name: ".SFNSText-Regular", family: ".SF NS Text", path: "SFNSText-Regular.otf")
    public static let all: [FontConvertible] = [bold, heavy, regular]
  }
  public enum Avenir {
    public static let black = FontConvertible(name: "Avenir-Black", family: "Avenir", path: "Avenir.ttc")
    public static let blackOblique = FontConvertible(name: "Avenir-BlackOblique", family: "Avenir", path: "Avenir.ttc")
    public static let book = FontConvertible(name: "Avenir-Book", family: "Avenir", path: "Avenir.ttc")
    public static let bookOblique = FontConvertible(name: "Avenir-BookOblique", family: "Avenir", path: "Avenir.ttc")
    public static let heavy = FontConvertible(name: "Avenir-Heavy", family: "Avenir", path: "Avenir.ttc")
    public static let heavyOblique = FontConvertible(name: "Avenir-HeavyOblique", family: "Avenir", path: "Avenir.ttc")
    public static let light = FontConvertible(name: "Avenir-Light", family: "Avenir", path: "Avenir.ttc")
    public static let lightOblique = FontConvertible(name: "Avenir-LightOblique", family: "Avenir", path: "Avenir.ttc")
    public static let medium = FontConvertible(name: "Avenir-Medium", family: "Avenir", path: "Avenir.ttc")
    public static let mediumOblique = FontConvertible(name: "Avenir-MediumOblique", family: "Avenir", path: "Avenir.ttc")
    public static let oblique = FontConvertible(name: "Avenir-Oblique", family: "Avenir", path: "Avenir.ttc")
    public static let roman = FontConvertible(name: "Avenir-Roman", family: "Avenir", path: "Avenir.ttc")
    public static let all: [FontConvertible] = [black, blackOblique, book, bookOblique, heavy, heavyOblique, light, lightOblique, medium, mediumOblique, oblique, roman]
  }
  public enum ZapfDingbats {
    public static let regular = FontConvertible(name: "ZapfDingbatsITC", family: "Zapf Dingbats", path: "ZapfDingbats.ttf")
    public static let all: [FontConvertible] = [regular]
  }
  public enum Public {
    public static let `internal` = FontConvertible(name: "private", family: "public", path: "class.ttf")
    public static let all: [FontConvertible] = [`internal`]
  }
  public static let allCustomFonts: [FontConvertible] = [SFNSDisplay.all, SFNSText.all, Avenir.all, ZapfDingbats.all, Public.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
