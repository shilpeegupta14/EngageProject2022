//
//  StoreImageViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 20/05/22.
//

//import UIKit
//
//class ScanCardViewController: UIViewController, CCScannerDelegate {
//    func ccScannerCompleted(cardNumber: String, expDate: String, cardType: String) {
////        self.cardNoTextField=cardNumber
////        self.expiryDateTextField=expDate
////        self.
////        print(cardNumber, expDate, cardType)
//    }
//
//
//    // Initialize the CC scanner
//    let ccScanner = CCScanner()
//
//    @IBOutlet weak var cardNoTextField: UITextField!
//    @IBOutlet weak var cardNameTextField: UITextField!
//    @IBOutlet weak var expiryDateTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Set the CC scanner delegate to your view controller
//        self.ccScanner.delegate = self
//
//    }
//
//    @IBAction func scanCardBtnPressed(_ sender: UIButton) {
//        // Start the CC scanner
//        self.ccScanner.startScanner(viewController: self)
//    }
//
//    @IBAction func submitPressed(_ sender: UIButton) {
//        // This delegate callback function is called upon a completed successful scan
//        func ccScannerCompleted(cardNumber: String, expDate: String, cardType: String) {
//
//            // Do what you wish with the data.
//            print(cardNumber, expDate, cardType)
//        }
//    }
//}
