import Foundation
import SpriteKit

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}




let degree = CGFloat(M_PI_2) / 90

var referenceSize: CGFloat!

public class GameScene: SKScene {
    var selectedNode: SKNode?
    var shakeAction: SKAction?
    var positions : [Point] = []

    
    var changedPositions : [Point] = []
    public var currentSize : CGSize!
    
    override public init(size: CGSize) {
        
        referenceSize = min(size.width, size.height)

        super.init(size: size)
        makeShakeAction()
        self.size = size

        self.configurePositions()
        self.setupLines()
        
        var arrayOfPositions = [8, 3, 10, 1, 6, 9, 14]
        let radiusIntern = size.width * 0.075

        for (index,position) in positions.enumerated() {
            let redCircle = Node(withValue: arrayOfPositions[index], andRadius: radiusIntern, andPosition: position)
            addChild(redCircle)
        }
        
        let radiusBack = size.width * 0.085
        
        for (_,position) in positions.enumerated() {
            let redCircle = SKShapeNode(circleOfRadius: radiusBack)
            redCircle.zPosition = -1
            redCircle.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            redCircle.lineWidth = 0.0
            redCircle.position = position.center
            redCircle.name = "NodeEmpty"

            addChild(redCircle)
        }

        setupBackGround()
    }
    
    func setupLines() {
        var lines = [SKShapeNode]()
        
        //ROOT NODE
        let line1 = Line.line(fromPoint: positions[0].center, toPoint: positions[1].center)
        let line2 = Line.line(fromPoint: positions[0].center, toPoint: positions[2].center)
        
        // FIRST LAYER FIRST NODE
        let line3 = Line.line(fromPoint: positions[1].center, toPoint: positions[3].center)
        let line4 = Line.line(fromPoint: positions[1].center, toPoint: positions[4].center)
        
        // FIRST LAYER SECOND NODE
        let line5 = Line.line(fromPoint: positions[2].center, toPoint: positions[5].center)
        let line6 = Line.line(fromPoint: positions[2].center, toPoint: positions[6].center)
        
        lines.append(line1)
        lines.append(line2)
        lines.append(line3)
        lines.append(line4)
        lines.append(line5)
        lines.append(line6)


        
        for line in lines {
            line.name = "justALine"
            line.zPosition = -2
            addChild(line)
        }
        
    }
    
    func configurePositions() {
        let centerWidth = (size.width / 2)
        let centerHeight = (size.height / 2) + 50
        
        
        let valueForH3 = centerWidth * 0.4
        let valueForH41 = centerWidth * 0.2
        let valueForH42 = centerWidth * 0.6
//        valueForH3 = 100
        
        positions = [Point.init(withPoint: CGPoint(x: centerWidth, y: centerHeight + valueForH3), andIndex : 0),
                     Point.init(withPoint: CGPoint(x: centerWidth - valueForH3, y: centerHeight ), andIndex : 1),
                     Point.init(withPoint: CGPoint(x: centerWidth + valueForH3, y: centerHeight), andIndex : 2),
                     Point.init(withPoint: CGPoint(x: centerWidth - valueForH42, y: centerHeight - valueForH3), andIndex : 3),
                     Point.init(withPoint: CGPoint(x: centerWidth - valueForH41, y: centerHeight - valueForH3), andIndex : 4),
                     Point.init(withPoint: CGPoint(x: centerWidth + valueForH42, y: centerHeight - valueForH3), andIndex : 5),Point.init(withPoint: CGPoint(x: centerWidth + valueForH41, y: centerHeight - valueForH3), andIndex : 6)
        ]

        
    }
    
    public func makeShakeAction(){
        var sequence = [SKAction]()
        for _ in 0..<10 {
            let shake = CGFloat(drand48() * 2) + 1
            let shake2 = CGFloat(drand48() * 2) + 1
            let duration = 0.08 // + (drand48() * 0.14)
            let antiClockwise = SKAction.group([
                SKAction.rotate(byAngle: degree * shake, duration: duration),
                SKAction.moveBy(x: shake, y: shake2, duration: duration)
                ])
            let clockWise = SKAction.group([
                SKAction.rotate(byAngle: degree * shake * -2, duration: duration * 2),
                SKAction.moveBy(x: shake * -2, y: shake2 * -2, duration: duration * 2)
                ])
            sequence += [antiClockwise, clockWise, antiClockwise]
        }
        
        
        shakeAction = SKAction.repeatForever(SKAction.sequence(sequence))
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let positionInScene = touch?.location(in: self) else {return}
        
        
        
        
        if let touchedNode = self.nodes(at: positionInScene).first {
            
            if touchedNode.name == "Texto" {
                selectedNode = touchedNode.parent!
//                selectedNode?.run(shakeAction!, withKey: "shake")
            } else if touchedNode.name == "Node" {
                selectedNode = touchedNode

//                selectedNode?.run(shakeAction!, withKey: "shake")
            } else if touchedNode.name == "Tree" {
                touchedNode.randomShake()
                touchedNode.addCrazyWideLeavesFalling()
                return
            } else {
                return
            }
            
            if selectedNode?.alpha == 1 {
                selectedNode?.addCrazyLeavesFalling()
            }
            selectedNode?.enableParticle()
            selectedNode?.alpha = 0.99
            
            if let node = selectedNode as? Node {
                node.blink()
            }

            for position in positions {
                if touchedNode.position.distance(toPoint: position.center) == 0 {
                    let removed = position
                    changedPositions.append(removed)
                }
            }

        }
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let translationInScene = touch.location(in: self) - touch.previousLocation(in: self)
        if selectedNode != nil && selectedNode?.name == "Node"{
            selectedNode!.position += translationInScene
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if selectedNode != nil {
            guard let touch = touches.first else {return}

            var finalLocation = touch.location(in: self.view)
            finalLocation.y = self.size.height - finalLocation.y
            for position in self.positions {
                if selectedNode!.position.isNext(toPosition: position.center) {
                    
                    var minorDistance : CGFloat = 999999
                    let nextPosition : Point = Point(withPoint: CGPoint.init(x: 0, y: 0), andIndex: 0)
                    
                    for position in self.positions {
                        if selectedNode!.position.distance(toPoint: position.center) < minorDistance {
                            nextPosition.center = position.center
                            nextPosition.positionIndex = position.positionIndex
                            minorDistance = selectedNode!.position.distance(toPoint: position.center)
                        }
                    }
                    selectedNode?.move(toPoint: nextPosition.center)
                    selectedNode?.alpha = 1
//                    selectedNode?.removeAction(forKey: "shake")
                    selectedNode = nil
                    break
                }
            }
            
        } else {
//            selectedNode?.removeAction(forKey: "shake")
            selectedNode = nil
        }
        
        
    }
    
    
}

extension GameScene {
    func setupBackGround() {
                
        let background = SKSpriteNode(imageNamed: "IMAGES/tree.png")
        background.name = "Tree"
        background.size = CGSize(width: frame.width * 0.95, height: frame.height * 0.95)
        
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.4)
        
        background.position = center
        background.zPosition = -99
        background.addLeavesFalling()
        background.randomShake()
        
        scene?.addChild(background)
        
        scene?.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.862745098, alpha: 1)
        
        // LABEL WITH TEXT "BINARY-SEARCH-TREES"
        let text = SKLabelNode(text: "BINARY-SEARCH-TREES")
        text.fontName = "Futura"
        text.horizontalAlignmentMode = .center
        text.fontSize = 35
        text.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: size.width / 2, y: size.height * 0.90)
        text.name = "Texto"
        scene?.addChild(text)

        
    }
}
