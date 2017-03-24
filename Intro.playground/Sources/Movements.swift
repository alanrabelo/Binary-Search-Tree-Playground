import Foundation
import SpriteKit

public extension SKNode {
    func move(toPoint point : CGPoint) {
        
        let moveAction = SKAction.move(to: point, duration: 0.5)
        
        self.run(moveAction) {
            //REMOVE ALL PARTICLES
            self.disableParticle()
        }

        
        
    }
    
    func randomShake() {
            let scaleUpAction = SKAction.scale(to: 1.07, duration: 0.1)
            //(by: 1.2, duration: 0.5)
            let scaleDownAction = SKAction.scale(to: 1, duration: 0.1)
            let waitAction = SKAction.wait(forDuration: 3)
            self.run(SKAction.sequence([scaleUpAction, scaleDownAction, waitAction]))
    }
    
}
