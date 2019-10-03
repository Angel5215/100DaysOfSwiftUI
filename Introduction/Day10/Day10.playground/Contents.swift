import UIKit

// CREATING YOUR OWN CLASSES
do {
    class Dog {
        var name: String
        var breed: String
        
        init(name: String, breed: String) {
            self.name = name
            self.breed = breed
        }
    }
    
    let poppy = Dog(name: "Poppy", breed: "Poodle")
    print(poppy.name, poppy.breed)
}

// CLASS INHERITANCE
do {
    class Dog {
        var name: String
        var breed: String
        
        init(name: String, breed: String) {
            self.name = name
            self.breed = breed
        }
    }
    
    class Poodle: Dog {
        init(name: String) {
            super.init(name: name, breed: "Poodle")
        }
    }
}

// OVERRIDING METHODS
do {
    class Dog {
        func makeNoise() {
            print("Woof!")
        }
    }
    
    class Poodle: Dog {
        override func makeNoise() {
            print("Yip!")
        }
    }
    
    let poppy = Poodle()
    poppy.makeNoise()
}

// FINAL CLASSES
do {
    // No othe class can inherit from `final` classes.
    final class Dog {
        var name: String
        var breed: String
        
        init(name: String, breed: String) {
            self.name = name
            self.breed = breed
        }
    }
}

// COPYING OBJECTS
do {
    class Singer {
        var name = "Taylor Swift"
    }
    
    let singer = Singer()
    print(singer.name)
    
    let singerCopy = singer
    singerCopy.name = "Justin Bieber"
    print(singer.name)
}

// DEINITIALIZERS
do {
    class Person {
        var name = "John Doe"
        
        init() {
            print("\(name) is alive!")
        }
        
        deinit {
            print("\(name) is no more!")
        }
        
        func printGreeting() {
            print("Hello, I'm \(name)")
        }
    }
    
    for _ in 1...3 {
        let person = Person()
        person.printGreeting()
    }
}

// MUTABILITY
do {
    class Singer {
        var name = "Taylor Swift"
    }
    
    let taylor = Singer()
    taylor.name = "Ed Sheeran"
    print(taylor.name)
}

