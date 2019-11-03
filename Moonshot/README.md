
# Project 7. iExpense

This is an expense tracker app that separates personal costs from business costs. 

## Topics

- `GeometryReader`, `GeometryProxy`
- Layout Priority
- `NavigationLink`
- `Spacer`

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- `GeometryReader` is a view that has access to a `GeometryProxy` object - this object lets us query the environment to determine how big is the container, what position is our view, and many more.

- All views used inside a `ScrollView` will get created immediately - even if they aren't even shown in the screen. Alternatively, all views created inside a `List` will get created lazily: created only when really needed.

- Both `sheet()` and `NavigationLink` allow us to show a new view from the current one, but the way they do it is different and you should choose them carefully:

    - `NavigationLink` is for showing details about the user’s selection, like you’re digging deeper into a topic.
    - `sheet()` is for showing unrelated content, such as settings or a compose window.

- To use a `Spacer` inside a `ScrollView` you have to use its `Spacer(minLength:)` initializer because the spacers take up all available remaining space and that makes no sense inside a scroll view. Also, using spacers this way works for both portrait and landscape orientations.

- **Layout priority** lets us control how readily a view shrinks when space is limited, or expands when space is plentiful. All views have a layout priority of **0 by default**, which means they each get equal chance to grow or shrink. A higher layout priority means a view will automatically take up all available space.



