import UIKit

// USING CLOSURES AS PARAMETERS WHEN THEY ACCEPT PARAMETERS
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
travel { (place: String) in
    print("I'm goint to \(place) in my car")
}

// USING CLOSURES AS PARAMETERS WHEN THEY RETURN VALUES
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
travel { (place: String) -> String in
    return "I'm going to \(place) in my car."
}

// SHORTHAND PARAMETER NAMES
travel { place -> String in
    return "I'm going to \(place) in my car."
}

travel { place in
    return "I'm going to \(place) in my car"
}

travel { place in
    "I'm going to \(place) in my car."
}

travel {
    "I'm going to \($0) in my car."
}

// CLOSURES WITH MULTIPLE PARAMETERS
func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}
travel {
    "I'm going to \($0) at \($1) miles per hour."
}

// RETURNING CLOSURES FROM FUNCTIONS
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
let result = travel()
result("London")

// CAPTURING VALUES
func navigate() -> (String) -> Void {
    var counter = 1
    
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
let result2 = navigate()
result2("London")
result2("London")
result2("London")
