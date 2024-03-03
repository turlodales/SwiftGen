## Template Information

| Name      | Description       |
| --------- | ----------------- |
| File name | strings/structured-swift4.stencil |
| Configuration example | <pre>strings:<br />  inputs: path/to/Localizable.strings<br />  outputs:<br />    templateName: structured-swift4<br />    output: Strings.swift</pre> |
| Language | Swift 4 |
| Author | Olivier Halligon |

## When to use it

- When you need to generate *Swift 4* code.
- If you use "structured" keys for your strings, that is components separated by the `.` character, for example:

```
"some.deep.structure"
"some.deep.something"
"hello.world"
```

## Customization

You can customize some elements of this template by overriding the following parameters when invoking `swiftgen`. See the [dedicated documentation](../../ConfigFile.md).

| Parameter Name | Default Value | Description |
| -------------- | ------------- | ----------- |
| `bundle` | `BundleToken.bundle` | Allows you to set from which bundle strings are loaded from. By default, it'll point to the same bundle as where the generated code is. Note: ignored if `lookupFunction` parameter is set. |
| `enumName` | `L10n` | Allows you to change the name of the generated `enum` containing all string tables. |
| `forceFileNameEnum` | N/A | Setting this parameter will generate an `enum <FileName>` _even if_ only one FileName was provided as input. |
| `lookupFunction` | N/A¹ | Allows you to set your own custom localization function. The function needs to have as signature: `(key: String, table: String, fallbackValue: String) -> String`. The parameters of your function can have any name (or even no external name), but if it has named parameters, you must provide the complete function signature, including those named parameters – e.g. `yourFunctionName(forKey:table:fallbackValue:)`. Note: if you define this parameter, the `bundle` parameter will be ignored. |
| `noComments` | N/A | Setting this parameter will disable the comments containing the comment from the strings file or the translation of a key. |
| `publicAccess` | N/A | If set, the generated constants will be marked as `public`. Otherwise, they'll be declared `internal`. |

1. _If you don't provide a `lookupFunction`, we will use `localizedString(forKey:value:table:)` on the `bundle` parameter instead._

## Generated Code

**Extract:**

```swift
internal enum L10n {
  /// Some alert body there
  internal static let alertMessage = L10n.tr("Localizable", "alert__message", fallback: "Some alert body there")
  /// Title for an alert
  internal static let alertTitle = L10n.tr("Localizable", "alert__title", fallback: "Title of the alert")
  internal enum Apples {
    /// You have %d apples
    internal static func count(_ p1: Int) -> String {
      return L10n.tr("Localizable", "apples.count", p1, fallback: "You have %d apples")
    }
  }
  internal enum Bananas {
    /// A comment with no space above it
    internal static func owner(_ p1: Int, _ p2: Any) -> String {
      return L10n.tr("Localizable", "bananas.owner", p1, String(describing: p2), fallback: "Those %d bananas belong to %@.")
    }
  }
}
```

[Full generated code](../../../Sources/TestUtils/Fixtures/Generated/Strings/structured-swift4/localizable.swift)

## Usage example

```swift
// Simple strings
let message = L10n.alertMessage
let title = L10n.alertTitle

// with parameters, note that each argument needs to be of the correct type
let apples = L10n.Apples.count(3)
let bananas = L10n.Bananas.owner(5, "Olivier")
```
