import Foundation
import SpriteKit

class BST {
    var nodes : [Node]
    
    init(withNodes nodes : [Node]) {
        self.nodes = nodes
    }
}

class Node : SKShapeNode {
    
    var value : Int
    
    init(withValue value : Int, andRadius radius : CGFloat, andPosition position : Point) {
        
        self.value = value
        
        
        
        
        super.init()
        let circle = SKShapeNode(circleOfRadius: 35.0)
        self.path = circle.path!
        
        self.fillColor = #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
        self.position = position.center
        self.name = "Node"
        self.addParticle(withName: "Red")
        
        // Setting the value of the text to the label
        let text = SKLabelNode(text: "\(value)")
        text.fontName = "Futura"
        text.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: 0.0, y: -10.0)
        text.name = "Texto"
        self.addChild(text)

        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
