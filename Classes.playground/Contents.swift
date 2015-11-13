//: Playground - noun: a place where people can play

import UIKit

class Demo {
    var surname:String?
    var forename:String!
    
    lazy var data:String? = {
        return "VALUE"
    }()
    
    init() {

    }
}

var test = Demo()
test.surname = "Bob"

if test.surname != nil {
    print("Surname is \(test.surname!)")
}

if let name = test.surname {
    print("Surname is \(name)")
}

//delegate?.doSomething()


var values:[AnyObject] = [0, 20, 110.5, 90, true]

var valueA = values[0] as! Int

if let valueB = values[1] as? String {
    print("String: \(valueB)")
}


var testValue = 5

switch testValue {
    
case 5, 10, 15:
    print("5, 10 or 15")
    
case 100...1000:
    print("100 -> 1000")
    
default:
    print("Default")
}
