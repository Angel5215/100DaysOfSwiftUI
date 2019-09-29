import UIKit

// CREATING BASIC CLOSURES
let driving = {
    print("I'm driving in my car")
}
driving()

// ACCEPTING PARAMETERS IN A CLOSURE
let drive = { (place: String) in
    print("I'm going to \(place) in my car")
}
drive("London")

// RETURNING VALUES FROM A CLOSURE
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
let message = drivingWithReturn("London")
print(message)

// CLOSURES AS PARAMETERS
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
travel(action: driving)

// TRAILING CLOSURE SYNTAX
travel() {
    print("I'm driving in my car")
}

travel {
    print("I'm driving in my car")
}
