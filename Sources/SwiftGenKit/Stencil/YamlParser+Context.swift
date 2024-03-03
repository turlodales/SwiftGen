//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Stencil

//
// See the documentation file for a full description of this context's structure:
// Documentation/SwiftGenKit Contexts/yaml.md
//

extension Yaml.Parser {
  public func stencilContext() -> [String: Any] {
    let files = self.files
      .sorted { lhs, rhs in lhs.name < rhs.name }
      .map(map(file:))

    return [
      "files": files
    ]
  }

  private func map(file: Yaml.File) -> [String: Any] {
    [
      "name": file.name,
      "path": file.path.string,
      "documents": file.documents.map { document in
        [
          "data": document,
          "metadata": LazyValueWrapper(Metadata.generate(for: document))
        ]
      }
    ]
  }
}
