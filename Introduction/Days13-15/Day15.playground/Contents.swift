import UIKit

// PROPERTIES
struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    
    var age: Int
    
    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
    
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
    
    func updateUI(msg: String) {
        print(msg)
    }
}

var taylor = Person(clothes: "T-shirts", age: 29, shoes: "sneakers")
let other = Person(clothes: "short skirts", age: 24, shoes: "high heels")
taylor.describe()
other.describe()

taylor.clothes = "short skirts"

var fan = Person(clothes: "T-shirts", age: 25, shoes: "sneakers")
fan.ageInDogYears

// STATIC PROPERTIES AND METHODS & ACCESS CONTROL
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    private var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let taylorFan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)


// POLYMORPHISM AND TYPECASTING
class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}


var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

// CLOSURES
let vw = UIView()
UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}

