
# # Project 12. Core Data: Introduction

Technique project to explore Core Data in more detail and its integration with SwiftUI.

## Topics

- Core Data
- Why `\.self` works inside a `ForEach`
- `Identifiable`, `Hashable`

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- When `\.self` is used as an identifier we mean *the whole object*.  Swift computes the **hash value** of the object, which is a way of representing complex data in fixed-size values, then uses the hash as an identifier.

- There are many ways of generating hash values, but two concepts are identical for all hash-generating functions:
    1. The output should be the same fixed size regardless of input size.
    2. Calculating the hash value for an object twice in a row should return the same value.

- When Xcode generates a class for managed objects, it makes that class conform to `Hashable`. 

