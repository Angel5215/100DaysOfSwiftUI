
# Project 7. iExpense

This is an expense tracker app that separates personal costs from business costs. 

## Topics

- `GeometryReader`, `GeometryProxy`

## Images

<p align="center"><img src="img/run-example.gif" height="600px"></p>

## Notes

- `GeometryReader` is a view that has access to a `GeometryProxy` object - this object lets us query the environment to determine how big is the container, what position is our view, and many more.

- All views used inside a `ScrollView` will get created immediately - even if they aren't even shown in the screen. Alternatively, all views created inside a `List` will get created lazily: created only when really needed.

- Both `sheet()` and `NavigationLink` allow us to show a new view from the current one, but the way they do it is different and you should choose them carefully:

    - `NavigationLink` is for showing details about the user’s selection, like you’re digging deeper into a topic.
    - `sheet()` is for showing unrelated content, such as settings or a compose window.