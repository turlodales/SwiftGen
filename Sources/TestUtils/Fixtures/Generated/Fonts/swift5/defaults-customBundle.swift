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
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum SFNSDisplay {
    internal static let black = FontConvertible(name: ".SFNSDisplay-Black", family: ".SF NS Display", path: "SFNSDisplay-Black.otf")
    internal static let bold = FontConvertible(name: ".SFNSDisplay-Bold", family: ".SF NS Display", path: "SFNSDisplay-Bold.otf")
    internal static let heavy = FontConvertible(name: ".SFNSDisplay-Heavy", family: ".SF NS Display", path: "SFNSDisplay-Heavy.otf")
    internal static let regular = FontConvertible(name: ".SFNSDisplay-Regular", family: ".SF NS Display", path: "SFNSDisplay-Regular.otf")
    internal static let all: [FontConvertible] = [black, bold, heavy, regular]
  }
  internal enum SFNSText {
    internal static let bold = FontConvertible(name: ".SFNSText-Bold", family: ".SF NS Text", path: "SFNSText-Bold.otf")
    internal static let heavy = FontConvertible(name: ".SFNSText-Heavy", family: ".SF NS Text", path: "SFNSText-Heavy.otf")
    internal static let regular = FontConvertible(name: ".SFNSText-Regular", family: ".SF NS Text", path: "SFNSText-Regular.otf")
    internal static let all: [FontConvertible] = [bold, heavy, regular]
  }
  internal enum Avenir {
    internal static let black = FontConvertible(name: "Avenir-Black", family: "Avenir", path: "Avenir.ttc")
    internal static let blackOblique = FontConvertible(name: "Avenir-BlackOblique", family: "Avenir", path: "Avenir.ttc")
    internal static let book = FontConvertible(name: "Avenir-Book", family: "Avenir", path: "Avenir.ttc")
    internal static let bookOblique = FontConvertible(name: "Avenir-BookOblique", family: "Avenir", path: "Avenir.ttc")
    internal static let heavy = FontConvertible(name: "Avenir-Heavy", family: "Avenir", path: "Avenir.ttc")
    internal static let heavyOblique = FontConvertible(name: "Avenir-HeavyOblique", family: "Avenir", path: "Avenir.ttc")
    internal static let light = FontConvertible(name: "Avenir-Light", family: "Avenir", path: "Avenir.ttc")
    internal static let lightOblique = FontConvertible(name: "Avenir-LightOblique", family: "Avenir", path: "Avenir.ttc")
    internal static let medium = FontConvertible(name: "Avenir-Medium", family: "Avenir", path: "Avenir.ttc")
    internal static let mediumOblique = FontConvertible(name: "Avenir-MediumOblique", family: "Avenir", path: "Avenir.ttc")
    internal static let oblique = FontConvertible(name: "Avenir-Oblique", family: "Avenir", path: "Avenir.ttc")
    internal static let roman = FontConvertible(name: "Avenir-Roman", family: "Avenir", path: "Avenir.ttc")
    internal static let all: [FontConvertible] = [black, blackOblique, book, bookOblique, heavy, heavyOblique, light, lightOblique, medium, mediumOblique, oblique, roman]
  }
  internal enum ZapfDingbats {
    internal static let regular = FontConvertible(name: "ZapfDingbatsITC", family: "Zapf Dingbats", path: "ZapfDingbats.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal enum Public {
    internal static let `internal` = FontConvertible(name: "private", family: "public", path: "class.ttf")
    internal static let all: [FontConvertible] = [`internal`]
  }
  internal static let allCustomFonts: [FontConvertible] = [SFNSDisplay.all, SFNSText.all, Avenir.all, ZapfDingbats.all, Public.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
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
    return ResourcesBundle.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
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
