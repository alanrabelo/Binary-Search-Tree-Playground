//
//  BST.swift
//  
//
//  Created by Alan Rabelo Martins on 16/03/17.
//
//
import Foundation

class Node : NSObject {
    var value : Int
    var left : Node?
    var right : Node?
    
    func insert(newNode node : Node) {
        
        if node.value = self.value {
            return false
        } else if node.value < self.value {
            if left != nil {
                return left.insert(newNode : node)
            } else {
                left = node
                return true
            }
        } else if node.value > self.value {
            if right != nil {
                return right.insert(newNode : node)
            } else {
                right = node
                return true

            }
        }
        return false
    }
}

class Tree: NSObject {
    
    var rootNode : Node?
    
    init(withRootNode node : Node) {
        rootNode = node
        super.init()
    }
    

    
}
