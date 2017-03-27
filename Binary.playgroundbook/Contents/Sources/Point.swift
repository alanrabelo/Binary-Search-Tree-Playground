import Foundation
import UIKit

public class Point {
    public var center : CGPoint
    public var positionIndex : Int
    
    public init(withPoint point : CGPoint, andIndex index : Int) {
        self.positionIndex = index
        self.center = point
        positionIndex = 0
    }
    

}


extension CGPoint {
    
    func isNext(toPosition position : CGPoint) -> Bool {
        return distance(toPoint: position) <= referenceSize * 0.1 ? true : false
    }
    
    func distance(toPoint point : CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
}
