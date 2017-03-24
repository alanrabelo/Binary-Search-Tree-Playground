/*:
Olá pessoal, tudo bom?
Vamos falar de árvores de busca binária, ou BST
*/
//#-hidden-code
import PlaygroundSupport
import UIKit
import SpriteKit
func say(_ message : String) {
    print(message)
}

//#-end-hidden-code

let frame = CGRect(x: 0, y: 0, width: 400, height: 600)
let view = SKView(frame: frame) //GameView(frame: frame)
let scene = GameScene(size: frame.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view

say(/*#-editable-code*/ "Helloo" /*#-end-editable-code*/)



