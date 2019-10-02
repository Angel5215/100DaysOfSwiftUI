import UIKit

// INITIALIZERS
do {
    struct User {
        var username: String
        
        init() {
            username = "Anonymous"
            print("Creating a new user!")
        }
    }
    
    var user = User()
    user.username = "twostraws"
}

// REFERING TO THE CURRENT INSTANCE
do {
    struct Person {
        var name: String
        
        init(name: String) {
            print("\(name) was born!")
            self.name = name
        }
    }
}

// LAZY PROPERTIES
do {
    struct FamilyTree {
        init() {
            print("Creating family tree!")
        }
    }
    
    struct Person {
        var name: String
        lazy var familyTree = FamilyTree()
        
        init(name: String) {
            self.name = name
        }
    }
    
    var ed = Person(name: "Ed")
    ed.familyTree // prints "Creating family tree!" when property is accessed.
}

// STATIC PROPERTIES AND METHODS
do {
    struct Student {
        static var classSize = 0
        var name: String
        
        init(name: String) {
            self.name = name
            Student.classSize += 1
        }
    }
    
    let ed = Student(name: "Ed")
    let taylor = Student(name: "Taylor")
    print(ed)
    print(taylor)
    print(Student.classSize)
}

// ACCESS CONTROL
do {
    struct Person {
        private var id: String
        
        init(id: String) {
            self.id = id
        }
        
        func identify() -> String {
            return "My social security number is \(id)"
        }
    }
    
    let ed = Person(id: "12345")
    ed.identify()
}
