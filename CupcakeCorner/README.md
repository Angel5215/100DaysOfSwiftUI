
# Project 10. Cupcake Corner

This is a multi-screen app for ordering cupcakes. It uses a couple of forms but focuses more in learning how to make classes conform to `Codable` when they have `@Published` properties, how to send and receive the order data from the internet and how to validate forms using the `disabled` modifier.

## Challenges

1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.

2. If our call to `placeOrder()` fails – for example if there is no internet connection – show an informative alert for the user. To test this, just disable WiFi on your Mac so the simulator has no connection either.

3. For a more challenging task, see if you can convert our data model from a class to a struct, then create an `ObservableObject` class wrapper around it that gets passed around. This will result in your class having one `@Published` property, which is the data struct inside it, and should make supporting `Codable` on the struct much easier.

## Topics

- Codable with `@Published` properties
- `URLSession`
- `DispatchQueue`

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- Any subclass from a class that contains a `required init` must override the initializer with a custom implementation to make sure they add their own values. One way to avoid using `required` in the parent class is marking it as `final class` so that subclassing isn't allowed.

