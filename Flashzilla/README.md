
# Project 17. Flashzilla

This is an app that helps users learn things using flashcards - cards with one thing written in one side, and another thing written on the other side.

## Topics

- Gestures
- CoreHaptics
- `allowsHitTesting()`
- Combine
- `Timer`
- `onReceive()`
- NotificationCenter

## Challenges

1. Make something interesting for when the timer runs out. At the very least make some text appear, but you should also try designing a custom haptic using Core Haptics.

2. Add a settings screen that has a single option: when you get an answer one wrong that card goes back into the array so the user can try it again.

3. If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: use a custom modifier for this to avoid cluttering your body property.)

## Images

<p align="center"><img src="img/run-example.gif"></p>

## Notes

- SwiftUI lets us control user interactivity in two ways: using the `allowsHitTesting()` and `contentShape()` modifiers.

- When `allowsHitTesting()` is attached to a view with its parameter set to `false`, the view isn't considered tapptable. It doesn't catch any taps, but things behind the view will get tapped instead.

- The `contentShape()` modifier lets us specify the tappable shape for something. For example, the tappable shape for a circle is a circle of the same size.

- The Combine framework adds an extension to `Timer` so that timers can become **publishers**, which are things that announce when their value changes. 

- The `@Published` property wrapped and the `ObsevableObject` protocol both come from Combine. When you import SwiftUI, it implicitly imports Combine.

- Run loops lets iOS handle running code while the user is actively doing something. 

- The `onReceive()` modifier let us catch announcements from regular publishers.

- NotificationCenter is Apple's internal message system, it has an API that lets the system notify us when events happen, but also lets us post messages between different parts of our code.