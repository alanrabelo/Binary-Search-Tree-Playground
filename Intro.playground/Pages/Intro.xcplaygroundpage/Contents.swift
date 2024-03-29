/*:
 
 **Binary Search Trees:** Let's discover Computer Science together! 
 
 - Note: The default values are:
 * minor: -3.0
 * offset: 130.0
 * color: .black()
 
*/

//#-hidden-code

import SpriteKit
import PlaygroundSupport

public let frame = CGRect(x: 0, y: 0, width: 500, height: 600)

let view = SKView(frame: frame)
let scene = GameScene(size: frame.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view

var values = [8, 3, 10, 1, 6, 9, 14]

let tree = Tree()

for value in values {
    let node = Node(withValue: value)
}

//#-end-hidden-code


