import UIKit

// WRITING FUNCTIONS
func printHelp() {
    let message = """
    Welcome to MyApp!

    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """
    
    print(message)
}
printHelp()

// ACCEPTING PARAMETERS
func square(number: Int) {
    print(number * number)
}
square(number: 8)

// RETURNING VALUES
func cube(number: Int) -> Int {
    return number * number * number
}
let result = cube(number: 8)
print(result)


// PARAMETER LABELS
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "Taylor")

// OMITTING PARAMETER LABELS
func greet(_ person: String) {
    print("Hello, \(person)")
}
greet("Taylor")

// DEFAULT PARAMETERS
func greet2(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet2("Taylor")
greet2("Taylor", nicely: false)

// VARIADIC FUNCTIONS
print("Haters", "gonna", "hate")

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square(numbers: 1, 2, 3, 4, 5)

// WRITING THROWING FUNCTIONS
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

// RUNNING THROWING FUNCTIONS
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password")
}

// `inout` parameters
func doubleInPlace(number: inout Int) {
    number *= 2
}
var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)
