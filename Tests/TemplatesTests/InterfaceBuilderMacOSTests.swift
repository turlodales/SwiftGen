//
// Templates UnitTests
// Copyright © 2022 SwiftGen
// MIT Licence
//

import TestUtils

final class InterfaceBuilderMacOSTests: InterfaceBuilderTests {
  func testScenesSwift4() {
    test(
      template: "scenes-swift4",
      contextNames: Contexts.all,
      directory: .interfaceBuilder,
      resourceDirectory: .interfaceBuilderMacOS,
      contextVariations: sceneVariations
    )
  }

  func testSeguesSwift4() {
    test(
      template: "segues-swift4",
      contextNames: Contexts.all,
      directory: .interfaceBuilder,
      resourceDirectory: .interfaceBuilderMacOS,
      contextVariations: segueVariations
    )
  }

  func testScenesSwift5() {
    test(
      template: "scenes-swift5",
      contextNames: Contexts.all,
      directory: .interfaceBuilder,
      resourceDirectory: .interfaceBuilderMacOS,
      contextVariations: sceneVariations
    )
  }

  func testSeguesSwift5() {
    test(
      template: "segues-swift5",
      contextNames: Contexts.all,
      directory: .interfaceBuilder,
      resourceDirectory: .interfaceBuilderMacOS,
      contextVariations: segueVariations
    )
  }
}
