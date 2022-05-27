//
//  AuthenticationViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 16/05/22.
//

import UIKit
import ARKit
import CoreML
import Vision
import ImageIO
import Foundation
import SwiftUI

class SignUpFaceAuthVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var camScanner: ARSCNView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var config = ARFaceTrackingConfiguration()
    var timer: Timer? = nil
    
//    @IBSegueAction func showTabView(_ coder: NSCoder) -> UIViewController? {
//        UIHostingController(coder: coder, rootView: ContentView())
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.startAnimating()
        
        config.isLightEstimationEnabled = true
        camScanner.session.run(config)
        camScanner.delegate = self
        
        var numScans = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { timer in
            numScans = numScans + 1
            //add pictures to local here
            _ = self.camScanner.snapshot()

            if (numScans % 2 == 1) {
                self.activityIndicator.isHidden = true
                self.infoLabel.text = "Please wait while we set up your authentication \(numScans/2 + 1)/3."
            } else {
                self.activityIndicator.isHidden = false
                self.infoLabel.text = ""
            }

            if (numScans > 5) {
                self.timer?.invalidate()
                self.goToHomeScreen()
            }
        })
    }
    func goToHomeScreen() {
        camScanner.session.pause()
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        self.present(homeScreen, animated: true, completion: nil)
        
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        guard let device = camScanner.device else {
//            return nil
//        }
//        let faceGeometry = ARSCNFaceGeometry(device: device)
//        let node = SCNNode(geometry: faceGeometry)
//        node.geometry?.firstMaterial?.fillMode = .lines
//        return node
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let faceAnchor = anchor as? ARFaceAnchor,
//            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
//                return
//        }
//        faceGeometry.update(from: faceAnchor.geometry)
//    }
 
}
