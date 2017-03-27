import Foundation
import SpriteKit

public extension SKNode {
    func addParticle(withName name : String) {
        if let redTrail = SKEmitterNode(fileNamed: name) {
            redTrail.zPosition = -99
            redTrail.name = "redTrail"
            redTrail.particleBirthRate = 0
            redTrail.targetNode = self.scene
            self.addChild(redTrail)
        } else {
            print("Error Adding Particle System")
        }
    }
    
    func addLeavesFalling() {
        if let leavesParticle = SKEmitterNode(fileNamed: "Leaves.sks") {
            leavesParticle.zPosition = -100
            leavesParticle.name = "leaves"
            leavesParticle.targetNode = self
            self.addChild(leavesParticle)
        } else {
            print("Error Adding Particle System")
        }
    }
    
    func addCrazyLeavesFalling() {
        if let leavesParticle = SKEmitterNode(fileNamed: "LeavesCrazy.sks") {
            leavesParticle.particleZPosition = -20
            
            leavesParticle.name = "leavesCrazy"            
            leavesParticle.targetNode = self.parent!
            leavesParticle.position = CGPoint(x: 0.0, y: -25)
            self.addChild(leavesParticle)
        } else {
            print("Error Adding Particle System")
        }
    }
    func addCrazyWideLeavesFalling() {
        if let leavesParticle = SKEmitterNode(fileNamed: "LeavesCrazyWide.sks") {
            leavesParticle.zPosition = -20
            
            leavesParticle.name = "leavesCrazy"
            leavesParticle.targetNode = self.parent!
            leavesParticle.position = CGPoint(x: 0.0, y: 80)
            leavesParticle.particleZPosition = -20
            self.addChild(leavesParticle)
        } else {
            print("Error Adding Particle System")
        }
    }
    
    func enableParticle() {
        for particle in self.children where particle.name == "redTrail" {
            (particle as! SKEmitterNode).particleBirthRate = 10
        }
    }
    
    func disableParticle() {
        for particle in self.children where particle.name == "redTrail" {
            (particle as! SKEmitterNode).particleBirthRate = 0
        }
    }
        
    func removeAllParticles() {
        for particle in self.children where particle.name == "redTrail" {
            particle.removeFromParent()
        }
    }
}
