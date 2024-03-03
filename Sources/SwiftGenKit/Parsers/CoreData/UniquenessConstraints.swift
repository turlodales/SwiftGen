//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna

private enum XML {
  fileprivate enum Attributes {
    static let value = "value"
  }

  static let uniquenessConstraintPath = "uniquenessConstraint"
  static let constraintPath = "constraint"
}

extension CoreData {
  public enum UniquenessConstraints {
    public static func parse(from object: Kanna.XMLElement) throws -> [[String]] {
      try object.xpath(XML.uniquenessConstraintPath).map { uniquenessConstraintElement in
        try uniquenessConstraintElement.xpath(XML.constraintPath).map { constaint in
          guard let value = constaint[XML.Attributes.value] else {
            throw CoreData.ParserError.invalidFormat(reason: "Missing required uniqueness constraint value")
          }

          return value
        }
      }
    }
  }
}
