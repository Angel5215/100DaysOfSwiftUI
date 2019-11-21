
# # Project 12. Core Data: Introduction

Technique project to explore Core Data in more detail and its integration with SwiftUI.

## Topics

- Core Data
- Why `\.self` works inside a `ForEach`
- `Identifiable`, `Hashable`
- Managed Object
- `@FetchRequest`
- `@NSManaged`
- `hasChanges`
- Core data constraints
- `NSMergeByPropertyObjectTrumpMergePolicy`
- `NSPredicate`, `NSCompoundPredicate`

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- When `\.self` is used as an identifier we mean *the whole object*.  Swift computes the **hash value** of the object, which is a way of representing complex data in fixed-size values, then uses the hash as an identifier.

- There are many ways of generating hash values, but two concepts are identical for all hash-generating functions:
    1. The output should be the same fixed size regardless of input size.
    2. Calculating the hash value for an object twice in a row should return the same value.

- When Xcode generates a class for managed objects, it makes that class conform to `Hashable`. 

- When creating a new Core Data entity, Xcode generates a **managed object class** automatically when we build our code. We can use instances of this class with `@FetchRequest` to show data in our UI. 

- When we write or read the value of a property that is `@NSManaged`, Core Data catches that and handles it internally. 

- It is common to bulk saves together so that you save everything at once, which has a lower performance impact when using `NSManagedObjectContext`. You should always wrap calls to `save()` in a check first:

```swift
if self.moc.hasChanges {
    try? self.moc.save()
}
```

- Core Data give us **constraints** - for example, we can make one attribute constrained so that it must always be unique. When we try to save objects, Core Data will resolve duplicates so that only one piece of data gets written. We can even choose how it should handle merging data when some data clashes with a constraint.

- Using `NSMergeByPropertyObjectTrumpMergePolicy`, Core Data will try to overwrite the version in its database using properties from the new version. 

- We can provide an array of sort descriptors to control the ordering results of `@FetchRequest`.

- We can provide an `NSPredicate` to `@FetchRequest` to filter which results should be shown.

#### Sample predicates for `NSPredicate`:

```swift
// Assuming a ship entity with `name` and `universe` attributes.

// Ships that are from Star Wars
NSPredicate(format: "universe == %@", "Star Wars")

// Return ships with names from "A" to "E"
NSPredicate(format: "name < %@", "F")

// Ships that match any universe contained in the array.
NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])

// Examines part of a string with `BEGINSWITH` and `CONTAINS`
NSPredicate(format: "name BEGINSWITH %@", "E")
NSPredicate(format: "name BEGINSWITH[c] %@", "E") // case-insensitive
NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
```

- You can join more complex predicates using `AND` or using a `NSCompoundPredicate`.

