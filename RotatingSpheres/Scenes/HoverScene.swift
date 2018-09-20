//
//  HoverScene.swift
//  RotatingSpheres
//
//  Created by Inam Ahmad-zada on 2018-09-19.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import SceneKit

struct HoverScene {
    
    var scene: SCNScene?
    
    init() {
        scene = self.initializeScene()
    }
    
    private func initializeScene() -> SCNScene? {
        let scene = SCNScene()
        
        self.setDefaults(scene: scene)
        
        return scene
    }
    
    private func setDefaults(scene: SCNScene) {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = SCNLight.LightType.ambient
        ambientLightNode.light?.color = UIColor(white: 0.8, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 0.8, alpha: 1.0)
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-40), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        scene.rootNode.addChildNode(directionalLightNode)
    }
    
    func addSphere(position: SCNVector3) {
        guard let scene = self.scene else { return }
        
        let sphere = Sphere()
        sphere.position = position
        
        let prevScale = sphere.scale
        sphere.scale = SCNVector3(0.01, 0.01, 0.01)
        let scaleAction = SCNAction.scale(to: CGFloat(prevScale.x), duration: 1.5)
        scaleAction.timingMode = .linear
        
        scaleAction.timingFunction = { (p: Float) in
            return self.easeOutElastic(p)
        }
        
        scene.rootNode.addChildNode(sphere)
        sphere.runAction(scaleAction, forKey: "scaleAction")
    }
    
    func easeOutElastic(_ t: Float) -> Float {
        let p: Float = 0.3
        let div: Float = p / 4.0
        let diff: Float = t - div
        let result = pow(2.0, -10.0 * t) * sin(diff * (2.0 * Float.pi) / p) + 1.0
        return result
    }
    
    func makeUpdateCameraPos(towards: SCNVector3) {
        guard let scene = self.scene else { return }
        
        scene.rootNode.childNodes.forEach {
            if let sphere = $0.topMost(until: scene.rootNode) as? Sphere {
                sphere.patrol(targetPos: towards)
            }
        }
    }
}
