import UIKit

// CREATING YOUR OWN STRUCTS
do {
    struct Sport {
        var name: String
    }

    var tennis = Sport(name: "Tennis")
    print(tennis.name)
    tennis.name = "Lawn tennis"
}

// COMPUTED PROPERTIES
do {
    struct Sport {
        var name: String
        var isOlympicSport: Bool
        
        var olympicStatus: String {
            if isOlympicSport {
                return "\(name) is an Olympic sport"
            } else {
                return "\(name) is not an Olympic sport"
            }
        }
    }
    
    let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
    print(chessBoxing.olympicStatus)
}

// PROPERTY OBSERVERS
do {
    struct Progress {
        var task: String
        var amount: Int {
            didSet {
                print("\(task) is now \(amount)% complete")
            }
        }
    }
    
    var progress = Progress(task: "Loading data", amount: 0)
    progress.amount = 30
    progress.amount = 80
    progress.amount = 100
}


// METHODS
do {
    struct City {
        var population: Int
        
        func collectTaxes() -> Int {
            return population * 1000
        }
    }
    
    let london = City(population: 9_000_000)
    london.collectTaxes()
}

// MUTATING METHODS
do {
    struct Person {
        var name: String
        
        // Swift will only allow this method to be called on `Person`
        // instances that are variables.
        mutating func makeAnonymous() {
            name = "Anonymous"
        }
    }
    
    var person = Person(name: "Ed")
    person.makeAnonymous()
}

// PROPERTIES AND METHODS OF STRINGS
do {
    let string = "Do or do not, there is no try."
    print(string.count)
    print(string.hasPrefix("Do"))
    print(string.uppercased())
    print(string.sorted())
    print(string.shuffled())
    print(string.reversed())
}

// PROPERTIES AND METHODS OF ARRAYS
do {
    var toys = ["Woody"]
    print(toys.count)
    
    toys.append("Buzz")
    toys.firstIndex(of: "Buzz")
    print(toys.sorted())
    toys.remove(at: 0)
}
