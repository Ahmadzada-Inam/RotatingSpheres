//
//  Node+Extensions.swift
//  RotatingSpheres
//
//  Created by Inam Ahmad-zada on 2018-09-19.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    public class func allNodes(from file: String) -> [SCNNode] {
        var nodesInFile = [SCNNode]()
        
        do {
            guard let sceneUrl = Bundle.main.url(forResource: file, withExtension: nil) else {
                print("Could not find file")
                return nodesInFile
            }
            
            let objScene = try SCNScene(url: sceneUrl as URL, options: [SCNSceneSource.LoadingOption.animationImportPolicy : SCNSceneSource.AnimationImportPolicy.doNotPlay])
            objScene.rootNode.childNodes.forEach { nodesInFile.append($0) }
        }
        catch {}
        
        return nodesInFile
    }
    
    func topMost(parent: SCNNode? = nil, until: SCNNode) -> SCNNode {
        if let pNode = self.parent {
            return pNode == until ? self : pNode.topMost(parent: pNode, until: until)
        }
        else {
            return self
        }
    }
}
