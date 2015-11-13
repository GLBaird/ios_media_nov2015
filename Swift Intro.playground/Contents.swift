//: Playground - noun: a place where people can play

import Foundation

var username:String = "Leon Baird"
username.uppercaseString

var anotherName = "Bob"
var myInteger = 42
var myFloat:Float = 52.6161
var myDouble = 45.3092
myInteger = Int(myFloat)

username += " ESQ";

print("The vaue is \(myInteger), and the name is \(username)")

var result = "The value is \(Float(myInteger) + myFloat)"
result += ", and the name is "
result += username
result += "\(myFloat)"

let myConstant = "Hi there"

//let bbcURL = NSURL(string: "http://www.bbc.co.uk")!
//do {
//    let bbcHTML = try String(contentsOfURL: bbcURL)
//} catch {}

var myIntegers:[Int] = [10, 20, 30, 40, 50]

myIntegers[2] = 500

myIntegers.append(600)
myIntegers.count

var myDictionary:Dictionary<String, String> = [
    "Surname": "Baird",
    "forename": "Leon"
]
myDictionary["Surname"]
myDictionary["Age"] = "40"

var mySet:Set<Int> = [10, 20, 30, 40, 50]

for i in 0...1000 {
    sin(Double(i) / 100)
}

for val in myIntegers {
    print("Value is \(val)")
}


func doSomething() -> String {
    return "HI"
}

func addValues(valueA a:Int, valueB b:Int) -> Int {
    return a + b;
}

addValues(valueA: 10, valueB: 10)

func doSomething(value:Int) -> (doubled:Int, added:Int) {
    return (value * 2, value + 2)
}

doSomething(10).added

func genSomething<index, thing>(genA:index, genB:thing) {
    
}

genSomething<String, Int>("BNOB", genB: 10)


