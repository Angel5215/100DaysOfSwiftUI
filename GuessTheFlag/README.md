
# Project 2. Guess the Flag

Guessing game that helps user learn some of the many flags of the world.

## Topics

- `VStack`, `HStack`, `ZStack`

## Challenge

Go back to project 2 and create a `FlagImage` view that renders one flag image using the specific set of modifiers we had.



## Images

<p align="center"><img src="./img/run-example.gif" height="600px"></p>

## Notes

- A `VStack` is a vertical stack of views. It's possible to stack up to 10 children. If you need to add more, stack multiple `Group` views.

- By default, `VStack` aligns its views to be centered. You can customize this behavior using the `alignment` property.

- You can use `Spacer` views to push the contents of a stack to one side. A Spacer will automatically take up all the remaining space.

```swift
// These `Text` views will be pushed to the top of the screen.
VStack {
    Text("1")
    Text("2")
    Text("3")
    Spacer()
}
```
- An `HStack` is a horizontal stack of views.

- A `ZStack` is a view used for arranging things by depth.

- `Color.red` is a `View` which is why it can be used like shapes and text. It automatically takes up all the space available, but you can use the `frame(width:height:)` modifier to ask for specific sizes.

- Use the `edgesIgnoringSafeArea(_:)` modifier when you want your content to go under the [safe area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area).

- SwiftUI gives us **three kinds** of **gradients** to work with. They also conform to `View` so they can be drawn in our UI.

- Gradients need several components to be created: 
    1. An array of colors.
    2. Size and direction information.
    3. Type of gradient to use: `LinearGradient`, `RadialGradient`, `AngularGradient`.

- Buttons in SwiftUI can be made in two ways depending on how they should look.

```swift 
VStack {
    // Standard button. The closure is the code 
    // that should be run when the button is tapped.
    Button("Tap me!") {
        print("Button tapped")
    }

    // Customized button. The `action` closure is the code 
    // that should be run when the button is tapped.
    // The `label` closure defines how the button should look.
    Button(action: {
        print("Button tapped")
    }, label: {
        Text("Tap me!")
    })
}
```

- Use the `Image` type when you want to use pictures in your apps. There are three initializers:
    - `Image("pencil")`: loads an image called *pencil* from the project files.
    - `Image(decorative: "pencil")`: loads and image called *pencil* from the project files but won't read it out for users that enable the screen reader.
    - `Image(systemName: "pencil")`: loads the pencil icon build into iOS. It uses the [**SF Symbols** icon collection](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) from Apple.

- Because views are a function of the program state, **we set the conditions under which an `Alert` is shown** instead of assigning it to a variable and then calling a method on it. 