//
//  Sphere.swift
//  RotatingSpheres
//
//  Created by Inam Ahmad-zada on 2018-09-19.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import SceneKit

class Sphere: SceneObject {
    var isAnimating: Bool = false
    let patrolDistance: Float = 4.85
    
    init() {
        super.init(from: "sphere.dae")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        if isAnimating { return }
        
        isAnimating = true
        let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(Float.random(min: -Float.pi, max: Float.pi)), z: 0, duration: 5.0)
        let backwards = rotationAction.reversed()
        
        let rotateSequence = SCNAction.sequence([rotationAction, backwards])
        let repeatForever = SCNAction.repeatForever(rotateSequence)
        runAction(repeatForever)
    }
    
    func patrol(targetPos: SCNVector3) {
        let distanceToTarget = targetPos.distance(receiver: self.position)
        
        if distanceToTarget < patrolDistance {
            removeAllActions()
            isAnimating = false
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.20
            look(at: targetPos)
            SCNTransaction.commit()
        }
        else {
            if !isAnimating {
                animate()
            }
        }
    }
}

public extension Float {
    public static func random(min: Float, max: Float) -> Float {
        let diff = max - min
        let mul = diff * (Float(arc4random()) / 0xFFFFFFFF)
        return mul + min
    }
}
