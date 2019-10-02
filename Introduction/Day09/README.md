
# Days 8 and 9. Structs

- Create your own types using structures, which can have their own properties and methods.

- Structs can have **computed properties** to calculate values on the fly.

- If you want to change a property inside a method, that method must be marked as `mutating`. Swift will only let you modify variable instances of a struct.

- Initializers are "special methods" that create structs. You get a **memberwise initializer** by default, but if you create your own **you must give all properties a value**.

- Use `self` to refer to the current instance of a struct inside a method.

- `lazy` properties are created **only when they are first used**.

- Properties and methods that are **shared across all instances** are created using the `static` keyword.

- Access control lets you restrict what code can use properties and methods. Some of the most common options are `public` and `private`. Struct properties are `internal` by default. 
