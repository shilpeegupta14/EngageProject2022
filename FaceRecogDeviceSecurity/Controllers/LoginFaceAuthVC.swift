//
//  FaceAuthLoginViewController.swift
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

class LoginFaceAuthVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var camScanner: ARSCNView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//    @IBSegueAction func OpenTabView(_ coder: NSCoder) -> UIViewController? {
//        UIHostingController(coder: coder, rootView: ContentView())
//    }
    lazy var config = ARFaceTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dataInfo1 = AzureFaceRecognition.shared.getSyncDetectFaceIds(imageData: (UIImage(named: "5")?.jpegData(compressionQuality: 1))!)
        let dataInfo2 = AzureFaceRecognition.shared.getSyncDetectFaceIds(imageData: (UIImage(named: "6")?.jpegData(compressionQuality: 1))!)
        
        activityIndicator.startAnimating()
        
        config.isLightEstimationEnabled = true
        camScanner.session.run(config)
        camScanner.delegate = self
        
        var numScans = 0
        
        var oldImage = UIImage(named: "2")!
        var dataInfo3 = AzureFaceRecognition.shared.getSyncDetectFaceIds(imageData: oldImage.jpegData(compressionQuality: 1)!)
        
        //need to put
        _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { timer in
            print(dataInfo1)
            print(dataInfo3)
            numScans = numScans + 1
            AzureFaceRecognition.shared.findSimilars(faceId: dataInfo3, faceIds: [dataInfo1, dataInfo2]) { (authenticated) in
                if (authenticated) {
                    self.goToHomeScreen()
                }
            }
            oldImage = self.camScanner.snapshot()
            dataInfo3 = AzureFaceRecognition.shared.getSyncDetectFaceIds(imageData: oldImage.jpegData(compressionQuality: 1)!)
            
            if (numScans % 2 == 1) {
                self.activityIndicator.isHidden = true
                self.infoLabel.text = "Sorry, couldn't authenticate. Please try again."
            } else {
                self.activityIndicator.isHidden = false
                self.infoLabel.text = ""
            }
        })
    }
    
    func goToHomeScreen() {
        camScanner.session.pause()
        self.present(HomeViewController(), animated: true, completion: nil)
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
