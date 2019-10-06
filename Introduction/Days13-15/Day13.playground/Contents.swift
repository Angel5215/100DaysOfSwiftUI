import UIKit

// VARIABLES AND CONSTANTS
var name = "Tim McGraw"
name = "Romeo"

let otherName = "Romeo"
//otherName = "Tim McGraw"  --> Error

// TYPES OF DATA
var age: Int
age = 25

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333
longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false

// OPERATORS
var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var c = a + b

var name1 = "Tim McGraw"
var name2 = "Romeo"
var both = name1 + " and " + name2

var remainder = 9 % 3

c > 3
c >= 3
c > 4
c < 4

name == "Tim McGraw"
name != "Tim McGraw"

stayOutTooLate
!stayOutTooLate

// STRING INTERPOLATION
name = "Tim McGraw"
"Your name is \(name)"

age = 25
latitude = 36.16667
"Your name is \(name), your age is \(age), and our latitude is \(latitude)"
"You are \(age) years old. In another \(age) years you will be \(age * 2)"

// ARRAYS
var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]

songs[0]
songs[1]
songs[2]

type(of: songs)

var moreSongs = [String]()
moreSongs = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var combination = songs + moreSongs
combination += ["Everything has Changed"]


// DICTIONARIES
var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]

person["middle"]
person["month"]


// CONDITIONAL STATEMENTS
var action: String
var trait = "hater"

if trait == "hater" {
    action = "hate"
} else if trait == "player" {
    action = "play"
} else {
    action = "cruise"
}

if stayOutTooLate && nothingInBrain {
    action = "cruise"
}

if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}

// LOOPS
for i in 1...10 {
    "\(i) x 10 is \(i * 10)"
}


var str = "Fakers gonna"
for _ in 1...5 {
    str += " fake"
}
str

songs
for song in songs {
    "My favorite song is \(song)"
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ..< people.count {
    "\(people[i]) gonna \(actions[i])"
}

for i in 0 ..< people.count {
    var str = "\(people[i]) gonna"

    for _ in 1 ... 5 {
        str += " \(actions[i])"
    }

    str
}

var counter = 0

while true {
    "Counter is now \(counter)"
    counter += 1

    if counter == 556 {
        break
    }
}

songs
for song in songs {
    if song == "You Belong with Me" {
        continue
    }

    "My favorite song is \(song)"
}


let liveAlbums = 2
switch liveAlbums {
case 0:
    "You're just starting out"
case 1:
    "You just released iTunes Live From SoHo"
case 2:
    "You just released Speak Now World Tour"
default:
    "Have you done something new?"
}


let studioAlbums = 5
switch studioAlbums {
case 0...1:
    "You're just starting out"
case 2...3:
    "You're a rising star"
case 4...5:
    "You're world famous!"
default:
    "Have you done something new?"
}
