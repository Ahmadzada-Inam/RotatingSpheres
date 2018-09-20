//
//  SceneObject.swift
//  RotatingSpheres
//
//  Created by Inam Ahmad-zada on 2018-09-19.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import SceneKit

class SceneObject: SCNNode {
    
    init(from file: String) {
        super.init()
        
        let nodesInFile = SCNNode.allNodes(from: file)
        nodesInFile.forEach { self.addChildNode($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
