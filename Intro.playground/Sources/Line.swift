import Foundation
import SpriteKit

public class Line {
    public static func line(fromPoint initialPoint: CGPoint, toPoint finalPoint : CGPoint ) -> SKShapeNode {
        
        let line_path:CGMutablePath = CGMutablePath()
        line_path.move(to: initialPoint)
        line_path.addLine(to: finalPoint)
        
        let shape = SKShapeNode()
        shape.path = line_path
        shape.strokeColor = UIColor.white
        shape.lineWidth = 2
        return shape
        
        
        
    }
}

