

# Project 3. Views and Modifiers

Technique project to explore certain SwiftUI features in depth - looking at how and why they work in detail.

## Topics

- Structs
- Opaque return types (`some Type`)

## Images

<p align="center"><img src="./img/run-example.gif" height="600px"></p>

## Notes

- SwiftUI uses structs for two main reasons.
    1. **Performance**. Structs are simpler and faster than classes. Structs are almost free to create - when you make an struct with one integer, the entire size of that struct is that one integer. Comparing them to a typical `UIView` that inherits almost 200 properties that you don't use most of the time.
    2. **Immutability**. SwiftUI forces us to think about isolating state in a clean way. Classes are able to change their values freely (which leads to messier code), but using structs don't mutate over time.  

- Whenever we apply a modifier to a SwiftUI view, it creates a new view with that change applied.

- An opaque return type indicates that one method or computed property will return one specific type of something. SwiftUI `body` property returning `some View` indicates that it will return one specific type of view - such as `Button` or `Text` without specifying what, but we must always return that same type of view. Even though we don't know that view type is going back, the compiler does - and this is important to keep performance.

