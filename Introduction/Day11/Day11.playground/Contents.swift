import UIKit

// PROTOCOLS
protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

let user = User(id: UUID().uuidString)
displayID(thing: user)


// PROTOCOL INHERITANCE
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }


// EXTENSIONS
extension Int {
    var isEven: Bool {
        return self % 2 == 0
        
    }
    
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()
number.isEven


// PROTOCOL EXTENSIONS
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us: ")
        for name in self {
            print(name)
        }
    }
}

// Both arrays and sets conform to the `Collection` protocol.
pythons.summarize()
beatles.summarize()


// PROTOCOL-ORIENTED PROGRAMMING
protocol IdentifiableType {
    var id: String { get set }
    func identify()
}

extension IdentifiableType {
    func identify() {
        print("My ID is \(id)")
    }
}

// Types that conform to `IdentifiableType` get a default implementation of `identify()`
struct Customer: IdentifiableType {
    var id: String
}

let twostraws = Customer(id: "twostraws")
twostraws.identify()
