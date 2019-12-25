
# Project 18. Layout and Geometry

Technique project used to explore how SwiftUI handles layout. 

## Topics

- `GeometryReader`
- Alignment
- `ViewDimensions`

## Images

<p align="center"><img src="img/run-example.gif"></p>

## Notes

- All SwiftUI layout happens in three (four) steps:
    1. A parent view proposes a size for its child
    2. Based on that information, the child then chooses its own size and the parent **must** respect that choice.
    3. The parent then positions the child in its coordinate space.
    4. Behind the scenes, SwiftUI rounds off any pixels to their nearest values so any graphics remain sharp.

- If your view hierarchy is all layout neutral, then it will automatically take up all available space. For example, shapes and colors are layout neutral so if your view contains a color and nothing else, it will automatically fill the screen. 

```swift
var body: some View {
    Color.red
}
```

- The simplest alignment option is to use the `alignment` parameter of the `frame()` modifier. Another option is to use the `alignment` parameter of a stack.

- SwiftUI provides an `alignmentGuide()` modifier to create custom alignments. It takes two parameters: the guide we want to change and a closure that returns a new alignment. The closure is given a **`ViewDimensions`** object that contains the width and height of its view, along with the ability to read its various edges.

- To define a custom layout guide you should create an extension on either `VerticalAlignment` or `HorizontalAlignment`, and be a custom type that conforms to the `AlignmentID` protocol.

- SwiftUI offers two ways of positioning views: absolute positions using `position()` and relative positions using `offset()`.

- When using `position()` we get back a new view that **takes up all available space** so it can position its child at the correct location.

