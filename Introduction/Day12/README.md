
# Day 12. Optionals

- Optionals represent the **absence of a value** in a clear and unambiguous way.

- Swift will not let us use optionals without **unwrapping** them. The most common ways of unwrapping an optional are:
    - Using `if let` (safe)
    - Using `guard let` (safe)
    - Force unwrapping `!` (unsafe)

- When force-unwrapping an optional that is `nil`, your code will crash.

- **Implicitly unwrapped optionals** do not have the safety checks of regular optionals, they are automatically unwrapped for you when you try to use them.

- Use **nil coalescing** `??` to unwrap an optional and provide a default value if there was nothing inside.

- **Optional chaining** `a.b?.c` lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.

- Use `try?` to convert a throwing function into an optional return value in a safe way.

- Use `try!` to crash if an error is thrown.

- Initializers that fail when given bad input are known as **failable initializers**, they are created using `init?()`.

- **Typecasting** (`as?`, `as!`) is used to convert one type of object into another when they are related by an inheritance hierarchy or by a protocol.