//: Playground - noun: a place where people can play

import UIKit


// variables and constants
var myString:String = "Leon Baird"
let myConst:String = "Leon Baird"

// myConst = "Bob" throws error

myString = myString + "BOB"
var something = myString
myString += "BOB"
something
myString

var username = "Leon"

username == "Leon"

let anotherConstant = "Frank"

let bbcURL = NSURL(string: "http://www.bbc.co.uk")
do {
    let bbcHTML = try String(contentsOfURL: bbcURL!, encoding: NSUTF8StringEncoding)
} catch let error as NSError {
    print("Download error " + error.localizedDescription)
}

let myValue = 30
let myFloat:UInt = 20

let cgFloatVersion = CGFloat(myFloat)
let number = Int(Double("100.0")!)

var numbers = [10, 20, 30, 40, 50]

numbers.count
numbers[3]

numbers.append(10)

numbers[3] = 300

numbers

var myCollection:[AnyObject] = [10, "BOB", true]

let recordInteger = myCollection[0] as! Int

//dictionary

var myDictionary:Dictionary<String, String> = [ "surname": "baird", "forename": "Leon" ]

myDictionary["surname"]

var fingers:Set<Int> = [10, 20, 30, 40, 50, 10]
fingers.insert(10)
fingers

fingers.first

let arrayVersion = Array(fingers)

var names = [String]()
names.append("Bob")


for finger in fingers {
    print("Finger is \(finger)")
}


for (key, value) in myDictionary {
    print("\(key) = \(value)")
}

for i in 0...1000 {
    sin(Double(i*2)/100)
}


for var i=0; i<1000; i++ {
    sin(Double(i*2)/100)
}


let name = "Frank"

switch name {
    case "Betty":
        print("HI there Betty!")
    case "Bob":
        print("Go away horrible person!")
    case "rita", "Brenda", "Sue":
        print("There terrible gang is here")
        fallthrough
    case "Frank":
        print("Welcome")
    default:
        print("You are not recoginsed")
}

func movePlayer(xPOS x:Int, yPOS y:Int, speed:Int, animation:Bool) {
    // code
}

movePlayer(xPOS: 100, yPOS: 100, speed: 500, animation: true)

func addValues(a:Int, b:Int) -> Int {
    return a + b
}

// () -> ()
// (Int, Float, Double) -> Void

//{
//    (a, b, c) -> Void in
//    // code 
//}

func doSomething(val:Int, completion:(Int, Int) -> Int) {
    // code
}

doSomething(45, completion: { (a, b) -> Int in
    // code
    return 5
})

// class

class Person {
    
    var surname:String
    var forename:String
    
    var fullname:String {
        return forename + " " + surname
    }
    
    lazy var details:String! = {
        return self.forename + " " + self.surname
    }()
    
    convenience init() {
        self.init(surname: "Person", forename: "New")
    }
    
    init(surname:String, forename:String) {
        self.surname = surname
        self.forename = forename
    }
    
    init(value:Int) {
        surname = "\(value)"
        forename = "\(value)"
    }
    
    func getFullName() -> String {
        return surname + ", " + forename
    }
    
}

var person1 = Person(surname: "Bob", forename: "Bob")
var person2 = Person(value: 42)


class Manager: Person {
    override func getFullName() -> String {
        // code
        return ""
    }
}


enum NameTitles {
    case Mr, Mrs, Miss, Ms, Dr, Proff
}


var title:NameTitles = .Mr

enum MapType:Int {
    case Standard, Satellite, Hybrid
}

var state = MapType(rawValue: 0)

state?.rawValue


// optionals

var stuff:String?

stuff = "BOB"

if let name = stuff {
    print("Name is \(name)")
}

if stuff != nil {
    print("Stuff is \(stuff!)")
}


stuff?.propertyList()

var downloadedStiff = Dictionary<String, AnyObject>()

if let surname = downloadedStiff["user"]?[0]?["surname"] {
    
}

var sender:AnyObject = UISlider()

if let slider = sender as? UISlider {
    print("We have a slider")
} else if let button = sender as? UIButton {
    print("We have a button")
}


var myValueCool:Int!

myValueCool = 20

myValueCool


