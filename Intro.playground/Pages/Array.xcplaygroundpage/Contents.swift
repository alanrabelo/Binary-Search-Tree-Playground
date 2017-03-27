//: [Previous](@previous)
import Foundation
import SpriteKit
import PlaygroundSupport

public let frame = CGRect(x: 0, y: 0, width: 500, height: 600)

let view = SKView(frame: frame)
let scene = ArrayScene(size: frame.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view

var values = [8, 3, 10, 1, 6, 9, 14]


/*:
 
 Binary search tree (BST) is a kind of data structure, a term in computer science that works like a container that saves data (like numbers, or names) in memory. It's a very fast way to manage (find, insert and remove) data.
 
 Usually, people save data in Arrays, or Dictionaries, for example:
 if we want to save the values 8, 3, 10, 1, 6, 14 and 9 using an array we can type:
 
 */

let arrayOfNumbers = [8, 3, 10, 1, 6, 14, 9]

/*:
 in the case of this array we have 7 values.
 
 One of the most common operations in data structures is to find a value in a set of numbers. If we want to find the number 14 in this array, we must type:
 */


for number in arrayOfNumbers where number == 14 {
    print("I Found \(number)")
}

/*:
 
 
 Wowwww, it's super fast. :)
 
 if we look that operation "under the hood" we actually, discover that the for operation percurs the whole array of numbers, trying to find a number equal to the passed value. So, your algorithm will make 6 comparisons to solve this problem.
 
 How much comparisons will your search need if I want to find the number 20?
 
 - 7
 
 You'll must to compare exactally the same number of elements in arrayOfNumbers, because it'll look all values, until the end of the array, with a unsucessfully result. It's what we call in computer science of "worst case". It's the case that has the most cost for the computer.
 
  In this case, we have only 7 values. But can you imagine the cost of unsucessifully searching a number in 10.000 values?
 
 */

// Generate a random array with all values equal to 100
var randomArray = (1...10000).map{_ in 100 }

for number in randomArray where number == 14 {
    // Will never be executed because he'll never find a 14 in an array of 100 :(
    print("I Found \(number)")
}


/*:
 
 It will compare exactally 10.000 times, before unsucessful. It's really sad :\
 
 It doesn't matter if we have 7 or 10.000 values, it will always need the number of elements in the worst case. If we call n the number of elements, we say our algoriths takes O(n) in the worst case.
 
 Can we improve it? Let's learn a data structure called Binary Search Trees.
 
 */


//#-hidden-code

//#-end-hidden-code

//: [Next](@next)
