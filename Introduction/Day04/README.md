
# Day 04. Loops

- Loops let us repeat code until a condition is false.

- There are various kinds of loops:
    - The `for` loop is the most common, it assigns each item inside the loop to a **temporary constant**. The temporary constant can be omitted using an underscore `for _ in 1...10`.

    - There's also `while` loops, which you provide with an explicit condition to check.

    - The `repeat` loops are similar to `while` loops, but they always run the body of their loop **at least once**.

- You can exit a loop using `break`.

- If you have nested loops, you can also exit them using `break` followes by whatever label you placed before the loop you're trying to exit.

- You can skip items in a loop using `continue`.

- You can create infinite loops using `while true`. Make sure you have a condition somewhere to end them.