import Foundation
import SpriteKit

public class Tree : NSObject, NSCopying {

    
    var head : Node!
    var right : Tree?
    var left : Tree?
    var balance : Int = 0
    var positions : [Point]?
    
    public convenience init(withHead headNode : Node) {
        self.init()
        self.head = headNode
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Tree(withHead: self.head)
    }
    public func insert(newNode node : Node) {
        if head == nil {
            head = node
            return
        }
        
        if node.value < self.head.value {
            if self.left == nil {
                self.balance -= 1
                self.left = Tree(withHead: node)
            } else {
                self.balance -= 1
                self.left!.insert(newNode: node)
            }
        } else if node.value > self.head.value {
            if self.right == nil {
                self.balance += 1
                self.right = Tree(withHead: node)
            } else {
                self.balance += 1
                self.right!.insert(newNode: node)
            }
        }

        return
    }

    public static func balance(Tree p : inout Tree) {
                
        if p.balance > 1 {
            Tree.rotateLeft(Tree: &p)
        } else if p.balance < -1 {
            Tree.rotateRight(Tree: &p)
        }
        
        
    }
    
    
    public func path(withTree tree : Tree, andMax max : inout Int, andLength length : Int) {
        
        if self.right != nil {
            path(withTree: self.right!, andMax: &max, andLength: length+1)
        }
        
        if self.left == nil && self.right == nil && max < length {
            max = length
        }
        
        if self.left != nil {
            path(withTree: self.left!, andMax: &max, andLength: length+1)
        }
        
    }
    
    public static func rotateRight(Tree p : inout Tree) {
        guard let q = p.left else {
            print("Can't rotate because the node on left is empty")
            return
        }
                
        if let temp = q.right {
            q.right = p
            p.left = temp
            p = q
        } else {
            q.right = p
            p.left = nil
            p = q
        }
        
    }
    
    public static func rotateLeft(Tree p : inout Tree) {
        guard let q = p.right else {
            print("Can't rotate because the node on left is empty")
            return
        }
        
        if let temp = q.left {
            q.left = p
            p.right = temp
            p = q
        } else {
            q.left = p
            p.right = nil
            p = q
        }
        
    }
    
    

    public func printChildenValue() {
        print("PARENT IS \(self.head.value) with BALANCE \(self.balance)")
        
        if self.left != nil {
            print("LEFT OF \(self.head.value)")
            self.left!.printChildenValue()

        }
        if self.right != nil {
            print("RIGHT OF \(self.head.value)")
            self.right!.printChildenValue()

        }
    }
        
}

public class Node : SKShapeNode {
    
    var value : Int
    var leftNode : Node?
    var righNode : Node?
    var balanceFactor : Int = 0
    var isLeaf = false
    
    public init(withValue value : Int) {
        
        self.value = value
        let radius = referenceSize * 0.15
        super.init()
        let circle = SKShapeNode(circleOfRadius: radius)
        self.path = circle.path!
        self.fillColor = #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
        self.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        self.lineWidth = 0.0
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.name = "Node"
        self.addParticle(withName: "Red")
        
        // Setting the value of the text to the label
        let text = SKLabelNode(text: "\(value)")
        text.fontName = "Futura"
        text.fontSize = radius
        text.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: 0.0, y: -radius * 0.3)
        text.name = "Texto"
        self.addChild(text)

    }
    
    public init(withValue value : Int, andRadius radius : CGFloat, andPosition position : Point) {
        
        self.value = value
        
        super.init()
        let circle = SKShapeNode(circleOfRadius: radius)
        self.path = circle.path!
        self.fillColor = #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
        self.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        self.lineWidth = 0.0
        self.position = position.center
        self.name = "Node"
        self.addParticle(withName: "Red")
        
        // Setting the value of the text to the label
        let text = SKLabelNode(text: "\(value)")
        text.fontName = "Futura"
        text.fontSize = radius
        text.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: 0.0, y: -radius * 0.3)
        text.name = "Texto"
        self.addChild(text)
        
    }
    
    func add(newChild childNode : Node) {
        
        if self.balanceFactor == 0 {
            if childNode.value < self.value {
                self.balanceFactor -= 1
                if self.leftNode == nil {
                    self.leftNode = childNode
                } else {
                    self.leftNode!.add(newChild: childNode)
                }
            } else {
                self.balanceFactor += 1
                if self.righNode == nil {
                    self.righNode = childNode
                } else {
                    self.righNode!.add(newChild: childNode)
                }
            }
        } else if self.balanceFactor < 0 {
            if self.righNode!.balanceFactor < 1 {
                self.righNode!.leftNode?.righNode = self.righNode!
                self.righNode = self.righNode?.leftNode
            } else {
                
            }
            
            
        }
        
        
        
        
        
    }
    
    func singleRotateLeft() {
        
        self.righNode?.leftNode = self.copy() as? Node
        
        
        
    }
    
    
    func blink() {
        
        self.clearAllActions()
        
        let increaseAction = SKAction.scale(to: 1.04, duration: 0.1)
        let decreaseAction = SKAction.scale(to: 1, duration: 0.1)
        let waitAction = SKAction.wait(forDuration: 0.5)

        let shakeAction = SKAction.sequence([increaseAction, decreaseAction, waitAction])
        
        let repeatForeverShake = SKAction.repeatForever(shakeAction)
        self.run(repeatForeverShake)
        
        self.run(SKAction.customAction(withDuration: 1, actionBlock: { (node, elapsedTime) in
            self.lineWidth = elapsedTime * 5
        })) {
            self.unBlink()
        }
        

    }
    
    func unBlink() {
        
        self.run(SKAction.customAction(withDuration: 1.5, actionBlock: { (node, elapsedTime) in
            self.lineWidth -= elapsedTime * 5
        }))
        
        self.run(SKAction.scale(to: 1.0, duration: 0.5)) {
            self.removeAllActions()

        }
        
    }
    
    func clearAllActions() {
        self.lineWidth = 0.0
        self.removeAllActions()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
