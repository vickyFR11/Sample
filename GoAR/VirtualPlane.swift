//
//  VirtualPlane.swift
//  GoAR
//
//  Created by Victoria Fuenmayor on 12/29/17.
//  Copyright © 2017 Victoria Fuenmayor. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class VirtualPlane: SCNNode {
    var anchor : ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        self.anchor = anchor
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        let planeMaterial = createPlaneMaterial()
        
        self.planeGeometry!.materials = [planeMaterial]
    
        let node = SCNNode(geometry: self.planeGeometry)
        node.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        node.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
    
        updatePlaneMaterialDimensions()
        
        self.addChildNode(node)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAnchorPosition(_ anchor: ARPlaneAnchor){
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        updatePlaneMaterialDimensions()
        
    }
    
    func createPlaneMaterial()->SCNMaterial{
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.blue.withAlphaComponent(0.50)
        
        return material
    }
    
    func updatePlaneMaterialDimensions(){
        let material = self.planeGeometry.materials.first!
        
        let width = SCNFloat(self.planeGeometry.width)
        let height = SCNFloat(self.planeGeometry.height)
        
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1.0)
    }
    
}
