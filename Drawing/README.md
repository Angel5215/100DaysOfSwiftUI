
# Project 9. Drawing

This technique project takes a close look at drawing in SwiftUI, including creating custom paths and shapes, animating changes, solving performance problems and more.

## Topics

- `Path`
- `Shape`, `InsettableShape`
- `CGAffineTransform`
- `ImagePaint`
- `drawingGroup()`


## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes 

- **`Path`** is a dedicated type given to us by SwiftUI used for drawing custom shapes. It's very low level so you will usually want to wrap it in something else to make it more usefult but it is still the building block that underlies other work.

- Like colors, gradients and shapes, paths are also a `View`.

- SwiftUI’s dedicated `ShapeStyle` struct gives us control over how every line should be connected to the line after it (**line join**) and how every line should be drawn when it ends without a connection after it (**line cap**)

- SwiftUI enables custom drawing with two subtly different types: **paths and shapes**. 
    - A path is a series of drawing instructions such as “start here, draw a line to here, then add a circle there”, all using absolute coordinates. 
    - A shape has no idea where it will be used or how big it will be used, but instead will be asked to draw itself inside a given rectangle.

- Shapes are also views.

- SwiftUI 0 degrees is not straight upwards, but instead directly to the right. Shapes measure their coordinates from the bottom-left corner rather than the top-left corner, which means SwiftUI goes the other way around from one angle to the other.

- `Color` conforms to `View` but also to the `ShapeStyle` protocol, which means it can be used for fills, strokes and borders when drawing.

- `Image` views can also be used for fills, strokes and borders through the `ImagePaint` type.                

- Using the `drawingGroup()` modifier we tell SwiftUI it should render the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output, which is significantly faster. Behind the scenes, this modifier is powered by **Metal**, which is Apple's framework for working directly with the GPU for extremely fast graphics.

