//
//  SCNVector+Extensions.swift
//  RotatingSpheres
//
//  Created by Inam Ahmad-zada on 2018-09-20.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import SceneKit

extension SCNVector3 {
    
    public func distance(receiver: SCNVector3) -> Float {
        
        let xd = receiver.x - self.x
        let yd = receiver.y - self.y
        let zd = receiver.z - self.z
        
        let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
        
        if distance < 0 {
            return distance * -1
        }
        else {
            return distance
        }
    }
}
