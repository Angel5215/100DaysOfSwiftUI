
# Project 9. Drawing

This technique project takes a close look at drawing in SwiftUI, including creating custom paths and shapes, animating changes, solving performance problems and more.

## Topics

- `Path`
- `Shape`, `InsettableShape`
- `CGAffineTransform`
- `ImagePaint`
- `drawingGroup()`
- `animatableData`
- `AnimatablePair`
- Blend modes

## Challenges

1. Create an `Arrow` shape made from a rectangle and a triangle – having it point straight up is fine.

2. Make the line thickness of your `Arrow` shape animatable.

3. Create a `ColorCyclingRectangle` shape that is the rectangular cousin of `ColorCyclingCircle`, allowing us to control the position of the gradient using a property.

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

- Blend modes allow us to control the way one view is rendered on top of another.

- `AnimatablePair` is a type that contains two animatable values, and because both its values can be animated, the `AnimatablePair` can itself be animated. We can read individual values from the pair using `.first` and `.second`.

- SwiftUI can read and write the animatable data for a shape regardless of what that data is or what it means, it doesn’t need to re-invoke the body property of our views 60 or even 120 times a second during an animation – it just changes the parts that actually are changing.