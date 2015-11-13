//: Playground - noun: a place where people can play

import UIKit


func doSomething(val:Int, callback: ()->()) {
    
}


func empty() { }

doSomething(20, callback: {
    // code
})

func moreComplex(val:Int, callback: (index:Int, evil:Int) -> (String, Int) ) {
    
}


moreComplex(10) { (index, evil) -> (String, Int) in
    return("", index)
}


