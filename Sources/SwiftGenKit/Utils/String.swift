//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation

extension String {
  func uppercasedFirst() -> String {
    guard let first = self.first else {
      return self
    }
    return String(first).uppercased() + String(self.dropFirst())
  }
}
