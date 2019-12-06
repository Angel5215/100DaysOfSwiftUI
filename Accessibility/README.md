
# Project 15. Accessibility

## Topics

- Accessibility labels
- Accessibility values
- Accessibility hints
- Accessibility traits

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- **Accessibility labels** are read immediately and should be a short piece of text that gets right to the point. If a view deletes an item from the user's data, it might say "Delete". They are created using the `.accessibility(label:)` modifier.

- **Accessibility hints** are read after a short delay, they should provide more details on what the view is there for. It might say "Deletes an email from your inbox" for example. They are created using the `.accessibility(hint:)` modifier.

- **Accessibility traits** let us provide some extra information behind the scenes to VoiceOver that describes how the view works. For example, in a view that contains a tap gesture, you might add a `.isButton` trait. Traits are added using the `.accessibility(addTraits:)` modifier. You can also remove traits if they are not being used for anything using the `.accessibility(removeTraits:)` modifier.

