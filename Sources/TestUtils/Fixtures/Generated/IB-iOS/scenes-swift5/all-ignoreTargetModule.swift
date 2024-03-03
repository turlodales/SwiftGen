// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import AVKit
import ExtraModule
import GLKit
import LocationPicker
import SlackTextViewController
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum AdditionalImport: StoryboardType {
    internal static let storyboardName = "AdditionalImport"

    internal static let initialScene = InitialSceneType<LocationPicker.LocationPickerViewController>(storyboard: Self.self)

    internal static let `public` = SceneType<SlackTextViewController.SLKTextViewController>(storyboard: Self.self, identifier: "public")
  }
  internal enum Anonymous: StoryboardType {
    internal static let storyboardName = "Anonymous"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Self.self)
  }
  internal enum Dependency: StoryboardType {
    internal static let storyboardName = "Dependency"

    internal static let dependent = SceneType<ExtraModule.ValidatePasswordViewController>(storyboard: Self.self, identifier: "Dependent")
  }
  internal enum KnownTypes: StoryboardType {
    internal static let storyboardName = "Known Types"

    internal static let item1 = SceneType<GLKit.GLKViewController>(storyboard: Self.self, identifier: "item 1")

    internal static let item2 = SceneType<AVKit.AVPlayerViewController>(storyboard: Self.self, identifier: "item 2")

    internal static let item3 = SceneType<UIKit.UITabBarController>(storyboard: Self.self, identifier: "item 3")

    internal static let item4 = SceneType<UIKit.UINavigationController>(storyboard: Self.self, identifier: "item 4")

    internal static let item5 = SceneType<UIKit.UISplitViewController>(storyboard: Self.self, identifier: "item 5")

    internal static let item6 = SceneType<UIKit.UIPageViewController>(storyboard: Self.self, identifier: "item 6")

    internal static let item7 = SceneType<UIKit.UITableViewController>(storyboard: Self.self, identifier: "item 7")

    internal static let item8 = SceneType<UIKit.UICollectionViewController>(storyboard: Self.self, identifier: "item 8")

    internal static let item9 = SceneType<UIKit.UIViewController>(storyboard: Self.self, identifier: "item 9")
  }
  internal enum Message: StoryboardType {
    internal static let storyboardName = "Message"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: Self.self)

    internal static let composer = SceneType<UIKit.UIViewController>(storyboard: Self.self, identifier: "Composer")

    internal static let messagesList = SceneType<UIKit.UITableViewController>(storyboard: Self.self, identifier: "MessagesList")

    internal static let navCtrl = SceneType<UIKit.UINavigationController>(storyboard: Self.self, identifier: "NavCtrl")

    internal static let urlChooser = SceneType<PickerViewController>(storyboard: Self.self, identifier: "URLChooser")
  }
  internal enum Placeholder: StoryboardType {
    internal static let storyboardName = "Placeholder"

    internal static let navigation = SceneType<UIKit.UINavigationController>(storyboard: Self.self, identifier: "Navigation")
  }
  internal enum Wizard: StoryboardType {
    internal static let storyboardName = "Wizard"

    internal static let initialScene = InitialSceneType<CreateAccViewController>(storyboard: Self.self)

    internal static let acceptToS = SceneType<UIKit.UIViewController>(storyboard: Self.self, identifier: "Accept-ToS")

    internal static let createAccount = SceneType<CreateAccViewController>(storyboard: Self.self, identifier: "CreateAccount")

    internal static let preferences = SceneType<UIKit.UITableViewController>(storyboard: Self.self, identifier: "Preferences")

    internal static let validatePassword = SceneType<ExtraModule.ValidatePasswordViewController>(storyboard: Self.self, identifier: "Validate_Password")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
  }
}

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
