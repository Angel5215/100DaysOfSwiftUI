
# Project 19. SnowSeeker

This is an app to let users browse ski resorts around the world, to help them find one suitable for their next holiday. It aims to take advantage for all the extra space offered by iPads and Max-Sized iPhones in landscape orientation.

## Topics

- `UISplitViewController`

## Challenges

1. Add a photo credit over the `ResortView` image. The data is already loaded from the JSON for this purpose, so you just need to make it look good in the UI.

2. Fill in the loading and saving methods for `Favorites`.

3. For a real challenge, let the user sort and filter the resorts in `ContentView`. For sorting use default, alphabetical, and country, and for filtering let them select country, size, or price.

## Images

<p align="center"><img src="img/run-example.gif"></p>

## Notes

- `UISplitViewController` makes possible showing split views (two views side by side) on iPads. On iPhones, the split view automatically collapses the two views into one, so you get navigation view push-and-pop behavior.

- Another way to show an alert and sheet is using an optional `Identifiable` object as your condition, and the alert or sheet will be shown when that object has a value. 

```swift
struct User: Identifiable {
    var id = "ID"
}

struct ContentView: View {
    
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
            }
        .alert(item: $selectedUser) { user in
            Alert(title: Text(user.id))
        }
    }
}
```

- A `Group` can act as a transparent layout container which means you can create a serires of views inside a group, then wrap that group in different stacks to get different behaviors.

```swift 
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}
```

- When using a stack that has only one view that doesn't take any parameters, you can pass a view initializer directly to the stack to make your code shorter.