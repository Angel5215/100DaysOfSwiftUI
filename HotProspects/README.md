
# Project 16. Hot Prospects

This is an app to track who you meet at conferences. It will show a QR code taht stores your attendee information, then others can scan that cod eto add you to their list of possible leads for later follow up.

## Topics

- Environment (`@EnvironmentObject`)
- Local Notifications
- Tab bars
- Context menus
- `Result`
- `objectWillChange`
- Image interpolation
- Context menus

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- `@EnvironmentObject` let us place an object into the enviroment so that any child view can automatically have access to it.

- Every class that conforms to `ObservableObject` gains a `objectWillChange` property. This is a **publisher**, which means it does the same job as the `@Published` property wrapper (announce changes to properties, so that any views using the object get their `body` property reinvoked). This publisher should be triggered **immediately before** we make our change to allow SwiftUI to examine the state of our UI and prepare for animation changes.

- Local notifications are broken intor three parts to give them maximum flexibility:
    - A **content** of what should be shown - this can be a title, subtitle, sound, image, and so on.
    - A **trigger** that deterimnes when the notification should be shown - it can be from a few seconds from now to a date and time in the future, or even a location.
    - A **request** which is the combination of content and trigger but also adds a **unique identifier** so you can edit or remove specific alerts later on.