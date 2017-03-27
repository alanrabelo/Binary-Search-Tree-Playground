/*
//#-code-completion(identifier, hide, setupLiveView())
//#-hidden-code
import Foundation
//#-end-hidden-code
//#-editable-code Tap to enter code
// 1. Ask for a date
show("What is your birthdate?")
let birthdate = askForDate("Birthdate")

// 2. Ask for a number
show("What is your favorite number?")
let number = askForNumber("Number")

// 3. Ask for a choice from a set of options
show("What is your favorite color?")
let color = askForChoice("Color", options: ["Blue", "Green", "Orange", "Purple", "Red", "Yellow"])

//#-end-editable-code
*/

//#-hidden-code

import SpriteKit
import UIKit
import PlaygroundSupport



public let frame = CGRect(x: 0, y: 0, width: 1000, height: 1200)
let viewController = UIViewController()
let view = SKView()
let scene = GameScene(size: view.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view

//var values = [8, 3, 10, 1, 6, 14, 9]
//
//let tree = Tree()
//
//for value in values {
//    let node = Node(withValue: value)
//}

//#-end-hidden-code
