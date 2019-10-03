# Day 10. Classes

- Classes and structs are similiar, in that they can both let you **create your own types** with properties and methods.

- One class can **inherit** from another, and it gains all the properties and methods of the parent class. It's common to talk about **class hierarchies** (one class based on another, which itself is based on another).

- Classes marked with the `final` keyword stop other classes from inheriting from them.

- A subclass is able to replace a method in its parent class with a new implementation using the `override` keyword. Swift will complain if you try to override a method that doesn't exist in the parent class.

- When two variables point at the same class instance, they both point at the **same piece of memory** (changing one changes the other).

- Classes can have a **deinitializer**, which is a block of code that gets run when an instance of the class is destroyed. Deinitializers are created using the `deinit` keyword.

- Classes don't enforce constants as strongly as structs. If a property is declared as variable, it can be changed no matter how the class was created (using `var` or `let`).