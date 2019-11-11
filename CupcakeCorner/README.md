
# Project 10. Cupcake Corner

## Topics

- Codable with `@Published` properties

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- Any subclass from a class that contains a `required init` must override the initializer with a custom implementation to make sure they add their own values. One way to avoid using `required` in the parent class is marking it as `final class` so that subclassing isn't allowed.

