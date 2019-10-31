
# Project 7. iExpense

This is an expense tracker app that separates personal costs from business costs. 

## Topics

- Present and dismiss a second screen of data.
- Delete rows from a list.
- Save and load user data.
- `@State`, `@ObservedObject`,  `@Published` and `@Environment` property wrappers.
- The `Identifiable` protocol.
- `UUID`: universally unique identifier

## Challenges

1. Add an Edit/Done button to `ContentView` so users can delete rows more easily.

2. Modify the expense amounts in `ContentView` to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.

3. Add some validation to the Save button in `AddView`. If you enter “fish” or another thing that can’t be converted to an integer, show an alert telling users what the problem is.

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- Every time we modify a property of a struct Swift creates a new instance of the struct. `@State` is able to spot these changes, and automatically reloads views.

- `@State` doesn't work with classes. You may use `@ObservedObject` and `@Published` instead.

- The `@Published` property wrapped tells Swift that whenever a property changes, it should send an announcement out to any SwiftUI views that are watching that they should reload. How these views know which classes might send these notifications is through the `@ObservedObject` property wrapper.

- The `@ObservedObject` property wrapper can only be used on types that conform to the `ObservableObject` protocol.

- The `@Environment` property wrapper allows us to create properties that store values provided to use externally such as:
    - Is the user in light mode or dark mode?
    - What timezone are they on?
    - Have they asked for smaller or larger fonts?

- UUIDs are long hexadecimal strings (e.g. 08B15DB4-2F02-4AB8-A965-67A9C90D8A44). UUIDs are made of eight digits,four digits, four digits, four digits, then twelve digits, of which the only requirement is that there's a 4 in the first number of the third block.