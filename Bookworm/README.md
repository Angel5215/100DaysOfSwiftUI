
# Project 11. Bookworm

This is an app to track which books you’ve read and what you thought of them.

## Topics

- Core Data
- `@Binding` property wrapper
- `@FetchRequest` property wrapper

## Challenges

1. Right now it’s possible to select no genre for books, which causes a problem for the detail view. Please fix this, either by forcing a default, validating the form, or showing a default picture for unknown genres – you can choose.

2. Modify `ContentView` so that books rated as 1 star have their name shown in red.

3. Add a new “date” attribute to the Book entity, assigning `Date()` to it so it gets the current date and time, then format that nicely somewhere in `DetailView`.

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes 

- `@Binding` lets us connect an `@State` property of one view to some underlying model data. It lets us create a mutable value in a view, that actually points to some other value from elsewhere.


- `AnyView` is a type-erased wrapper. It conforms to the `View` protocol and contains inside a view of a specific type. However, it doesn't expose what it contains, so SwiftUI only sees that it returns `AnyView`. This is where the name **type erasure** comes from: `AnyView` effectively hides – or erases – the type of the views it contains.

- Retrieving information from Core Data is done using a fetch request – we describe what we want, how it should sorted, and whether any filters should be used, and Core Data sends back all the matching data.

