import UIKit

// ARRAYS
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"
let beatles = [john, paul, george, ringo]

beatles[1]

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// SETS
let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red"])

let set = Set(["aardvark", "astronaut", "azalea"])

// TUPLES
var name = (first: "Taylor", last: "Swift")
name.0
name.first

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

// DICTIONARIES
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]

// DICTIONARY DEFAULT VALUES
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]
favoriteIceCream["Charlotte", default: "Unknown"]

// CREATING EMPTY COLLECTIONS
var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()
var words = Set<String>()
var numbers = Set<Int>()
var scores = Dictionary<String, Int>()
var results2 = Array<Int>()

// ENUMERATIONS
enum Result {
    case success
    case failure
}
let result = Result.failure

// ENUM ASSOCIATED VALUES
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")

// ENUM RAW VALUES
enum Planet: Int {
    case mercury    // 0 by default
    case venus      // 1
    case earth      // 2
    case mars       // 3
}
let earth = Planet(rawValue: 2)

enum Planet2: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
let alsoEarth = Planet2(rawValue: 3)

