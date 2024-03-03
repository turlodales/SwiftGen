// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable superfluous_disable_command implicit_return
// swiftlint:disable sorted_imports
import CoreData
import Foundation

// swiftlint:disable attributes file_length vertical_whitespace_closing_braces
// swiftlint:disable identifier_name line_length type_body_length

// MARK: - AbstractEntity

public class AbstractEntity: NSManagedObject {
  public class var entityName: String {
    return "AbstractEntity"
  }

  public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
  @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractEntity> {
    return NSFetchRequest<AbstractEntity>(entityName: entityName)
  }

  @nonobjc public class func makeFetchRequest() -> NSFetchRequest<AbstractEntity> {
    return NSFetchRequest<AbstractEntity>(entityName: entityName)
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection implicit_getter
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection implicit_getter
}

// MARK: - AutoClassGen

// Note: 'AutoClassGen' has codegen enabled for Xcode, skipping code generation.

// MARK: - AutoExtensionGen

// Note: 'AutoExtensionGen' has codegen enabled for Xcode, skipping code generation.

// MARK: - ChildEntity

public final class ChildEntity: CustomMainEntity {
  override public class var entityName: String {
    return "ChildEntity"
  }

  override public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ChildEntity> {
    return NSFetchRequest<ChildEntity>(entityName: entityName)
  }

  @nonobjc public class func makeFetchRequest() -> NSFetchRequest<ChildEntity> {
    return NSFetchRequest<ChildEntity>(entityName: entityName)
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection implicit_getter
  public var canonicalOptionalString: String? {
    let key = "canonicalOptionalString"
    willAccessValue(forKey: key)
    defer { didAccessValue(forKey: key) }

    return primitiveValue(forKey: key) as? String
  }
  public var derivedCount: Int64? {
    get {
      let key = "derivedCount"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
  }
  public var now: Double {
    let key = "now"
    willAccessValue(forKey: key)
    defer { didAccessValue(forKey: key) }

    guard let value = primitiveValue(forKey: key) as? Double else {
      fatalError("Could not convert value for key '\(key)' to type 'Double'")
    }
    return value
  }
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection implicit_getter
}

// MARK: - ImpossibleType

// Warning: 'We.Cannot.Handle.ImpossibleType' cannot be a valid type name, skipping code generation.

// MARK: - MainEntity

public class CustomMainEntity: NSManagedObject {
  public class var entityName: String {
    return "MainEntity"
  }

  public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomMainEntity> {
    return NSFetchRequest<CustomMainEntity>(entityName: entityName)
  }

  @nonobjc public class func makeFetchRequest() -> NSFetchRequest<CustomMainEntity> {
    return NSFetchRequest<CustomMainEntity>(entityName: entityName)
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection implicit_getter
  @NSManaged public var attributedString: NSAttributedString?
  @NSManaged public var binaryData: Data?
  @NSManaged public var boolean: Bool
  @NSManaged public var date: Date?
  @NSManaged public var decimal: NSDecimalNumber?
  @NSManaged public var double: Double
  @NSManaged public var float: Float
  @NSManaged public var int16: Int16
  @NSManaged public var int32: Int32
  @NSManaged public var int64: Int64
  public var integerEnum: IntegerEnum {
    get {
      let key = "integerEnum"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      guard let value = primitiveValue(forKey: key) as? IntegerEnum.RawValue else {
        fatalError("Could not convert value for key '\(key)' to type 'IntegerEnum.RawValue'")
      }
      guard let result = IntegerEnum(rawValue: value) else {
        fatalError("Could not convert value for key '\(key)' to type 'IntegerEnum'")
      }
      return result
    }
    set {
      let key = "integerEnum"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue.rawValue, forKey: key)
    }
  }
  public var integerOptionSet: IntegerOptionSet {
    get {
      let key = "integerOptionSet"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      guard let value = primitiveValue(forKey: key) as? IntegerOptionSet.RawValue else {
        fatalError("Could not convert value for key '\(key)' to type 'IntegerOptionSet.RawValue'")
      }
      return IntegerOptionSet(rawValue: value)
    }
    set {
      let key = "integerOptionSet"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue.rawValue, forKey: key)
    }
  }
  public var optionalBoolean: Bool? {
    get {
      let key = "optionalBoolean"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Bool
    }
    set {
      let key = "optionalBoolean"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  public var optionalDouble: Double? {
    get {
      let key = "optionalDouble"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Double
    }
    set {
      let key = "optionalDouble"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged public var optionalFloat: Float
  public var optionalInt16: Int16? {
    get {
      let key = "optionalInt16"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int16
    }
    set {
      let key = "optionalInt16"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged public var optionalInt32: Int32
  public var optionalInt64: Int64? {
    get {
      let key = "optionalInt64"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
    set {
      let key = "optionalInt64"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged public var optionalString: String?
  @NSManaged public var string: String
  public var stringEnum: StringEnum? {
    get {
      let key = "stringEnum"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      guard let value = primitiveValue(forKey: key) as? StringEnum.RawValue else {
        return nil
      }
      return StringEnum(rawValue: value)
    }
    set {
      let key = "stringEnum"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue?.rawValue, forKey: key)
    }
  }
  @NSManaged public var transformable: AnyObject?
  @NSManaged public var transformableCustomArray: CustomArray?
  @NSManaged public var transformableCustomPolyline: CustomPolyline?
  @NSManaged public var transient: String?
  @NSManaged public var uri: URL?
  @NSManaged public var uuid: UUID?
  @NSManaged public var manyToMany: Set<SecondaryEntity>?
  @NSManaged public var oneToMany: NSOrderedSet?
  @NSManaged public var oneToOne: SecondaryEntity?
  @NSManaged public var fetchedProperty: [CheckedNewEntity]
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection implicit_getter
}

// MARK: Relationship ManyToMany

extension CustomMainEntity {
  @objc(addManyToManyObject:)
  @NSManaged public func addToManyToMany(_ value: SecondaryEntity)

  @objc(removeManyToManyObject:)
  @NSManaged public func removeFromManyToMany(_ value: SecondaryEntity)

  @objc(addManyToMany:)
  @NSManaged public func addToManyToMany(_ values: Set<SecondaryEntity>)

  @objc(removeManyToMany:)
  @NSManaged public func removeFromManyToMany(_ values: Set<SecondaryEntity>)
}

// MARK: Relationship OneToMany

extension CustomMainEntity {
  @objc(insertObject:inOneToManyAtIndex:)
  @NSManaged public func insertIntoOneToMany(_ value: SecondaryEntity, at idx: Int)

  @objc(removeObjectFromOneToManyAtIndex:)
  @NSManaged public func removeFromOneToMany(at idx: Int)

  @objc(insertOneToMany:atIndexes:)
  @NSManaged public func insertIntoOneToMany(_ values: [SecondaryEntity], at indexes: NSIndexSet)

  @objc(removeOneToManyAtIndexes:)
  @NSManaged public func removeFromOneToMany(at indexes: NSIndexSet)

  @objc(replaceObjectInOneToManyAtIndex:withObject:)
  @NSManaged public func replaceOneToMany(at idx: Int, with value: SecondaryEntity)

  @objc(replaceOneToManyAtIndexes:withOneToMany:)
  @NSManaged public func replaceOneToMany(at indexes: NSIndexSet, with values: [SecondaryEntity])

  @objc(addOneToManyObject:)
  @NSManaged public func addToOneToMany(_ value: SecondaryEntity)

  @objc(removeOneToManyObject:)
  @NSManaged public func removeFromOneToMany(_ value: SecondaryEntity)

  @objc(addOneToMany:)
  @NSManaged public func addToOneToMany(_ values: NSOrderedSet)

  @objc(removeOneToMany:)
  @NSManaged public func removeFromOneToMany(_ values: NSOrderedSet)
}

// MARK: Fetch Requests

extension CustomMainEntity {
  class func fetchDictionaryFetchRequest(managedObjectContext: NSManagedObjectContext) throws -> [[String: Any]] {
    guard let persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator else {
      fatalError("Managed object context has no persistent store coordinator for getting fetch request templates")
    }
    let model = persistentStoreCoordinator.managedObjectModel
    let substitutionVariables: [String: Any] = [
      :
    ]

    guard let fetchRequest = model.fetchRequestFromTemplate(withName: "DictionaryFetchRequest", substitutionVariables: substitutionVariables) else {
      fatalError("No fetch request template named 'DictionaryFetchRequest' found.")
    }

    guard let result = try managedObjectContext.fetch(fetchRequest) as? [[String: Any]] else {
      fatalError("Unable to cast fetch result to correct result type.")
    }

    return result
  }

  class func fetchObjectFetchRequest(managedObjectContext: NSManagedObjectContext, uuid: UUID) throws -> [CustomMainEntity] {
    guard let persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator else {
      fatalError("Managed object context has no persistent store coordinator for getting fetch request templates")
    }
    let model = persistentStoreCoordinator.managedObjectModel
    let substitutionVariables: [String: Any] = [
      "UUID": uuid
    ]

    guard let fetchRequest = model.fetchRequestFromTemplate(withName: "ObjectFetchRequest", substitutionVariables: substitutionVariables) else {
      fatalError("No fetch request template named 'ObjectFetchRequest' found.")
    }

    guard let result = try managedObjectContext.fetch(fetchRequest) as? [CustomMainEntity] else {
      fatalError("Unable to cast fetch result to correct result type.")
    }

    return result
  }

  class func fetchObjectIDFetchRequest(managedObjectContext: NSManagedObjectContext, name: String, needle: String) throws -> [NSManagedObjectID] {
    guard let persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator else {
      fatalError("Managed object context has no persistent store coordinator for getting fetch request templates")
    }
    let model = persistentStoreCoordinator.managedObjectModel
    let substitutionVariables: [String: Any] = [
      "NAME": name,
      "NEEDLE": needle
    ]

    guard let fetchRequest = model.fetchRequestFromTemplate(withName: "ObjectIDFetchRequest", substitutionVariables: substitutionVariables) else {
      fatalError("No fetch request template named 'ObjectIDFetchRequest' found.")
    }

    guard let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObjectID] else {
      fatalError("Unable to cast fetch result to correct result type.")
    }

    return result
  }

}

// MARK: - NewEntity

public final class CheckedNewEntity: AbstractEntity {
  override public class var entityName: String {
    return "NewEntity"
  }

  override public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckedNewEntity> {
    return NSFetchRequest<CheckedNewEntity>(entityName: entityName)
  }

  @nonobjc public class func makeFetchRequest() -> NSFetchRequest<CheckedNewEntity> {
    return NSFetchRequest<CheckedNewEntity>(entityName: entityName)
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection implicit_getter
  @NSManaged public var identifier: UUID?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection implicit_getter
}

// MARK: - SecondaryEntity

public final class SecondaryEntity: NSManagedObject {
  public class var entityName: String {
    return "SecondaryEntity"
  }

  public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
  @nonobjc public class func fetchRequest() -> NSFetchRequest<SecondaryEntity> {
    return NSFetchRequest<SecondaryEntity>(entityName: entityName)
  }

  @nonobjc public class func makeFetchRequest() -> NSFetchRequest<SecondaryEntity> {
    return NSFetchRequest<SecondaryEntity>(entityName: entityName)
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection implicit_getter
  @NSManaged public var name: String
  @NSManaged public var manyToMany: Set<CustomMainEntity>?
  @NSManaged public var oneToMany: CustomMainEntity?
  @NSManaged public var oneToOne: CustomMainEntity?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection implicit_getter
}

// MARK: Relationship ManyToMany

extension SecondaryEntity {
  @objc(addManyToManyObject:)
  @NSManaged public func addToManyToMany(_ value: CustomMainEntity)

  @objc(removeManyToManyObject:)
  @NSManaged public func removeFromManyToMany(_ value: CustomMainEntity)

  @objc(addManyToMany:)
  @NSManaged public func addToManyToMany(_ values: Set<CustomMainEntity>)

  @objc(removeManyToMany:)
  @NSManaged public func removeFromManyToMany(_ values: Set<CustomMainEntity>)
}

// swiftlint:enable identifier_name line_length type_body_length
