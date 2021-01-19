//
//  ViewController.swift
//  Planets
//
//  Created by Ansh Maroo on 7/5/19.
//  Copyright © 2019 Mygen Contac. All rights reserved.
//

import UIKit
import ARKit


class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.32))
        
        let earthParent = SCNNode()
        
        let venusParent = SCNNode()
        
        let moonParent = SCNNode()
        
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
        sun.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2,0,0)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2,0,0))
        
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular:nil , emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        
        let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3,0,0))
        
        
        
        let sunAction = Rotation(time: 25.05/5)
        
        
        let earthParentRotation = Rotation(time: 365/5)
        let venusParentRotation = Rotation(time: 225/5)
        let earthRotation = Rotation(time: 1/5)
        let venusRotation = Rotation(time: 8/5)
        let moonRotation = Rotation(time: 1/5)
        
        
        sun.runAction(sunAction)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(moonParent)
        moonParent.addChildNode(earthMoon)
        
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        moonParent.runAction(moonRotation)
        
        
        
       
    }
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        
        let foreverRotation = SCNAction.repeatForever(Rotation)
        
        return foreverRotation
        
    }
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        
        planet.position = position
        
        return planet
        
        
    }
    
    
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/100 }
    
}
