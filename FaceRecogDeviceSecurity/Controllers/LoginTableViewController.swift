//
//  LoginTableViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 15/05/22.
//

import UIKit
import LocalAuthentication
import Firebase

class LoginTableViewController: UITableViewController {
    
    //outlets that connect the text field from the screen to the code
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    //loading the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    //face id authentication for users with newer iPhones, if the user have older iPhones, they can login through touch ID auth.
    @IBAction func FaceIDAuth(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        //failed
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                }
                //show other screen
                //success
                let vc=HomeViewController()
                self?.present(vc, animated: true, completion: nil)
            }
        }else {
            //cant use
            let alert = UIAlertController(title: "Unavailable", message: "You can't use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    //login button pressed and the user is registered on the firebase.
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=PasswordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let e=error{
                    //if failed to auth, print error
                    print(e)
                }else{
                    //if authenticated successfully, move to the home view.
                    self?.performSegue(withIdentifier: "LoginSegueIdentifier", sender: self)
                }
            }
        }
    }
    
    //if signup is pressed the user moves to the signup page and asked for registering.
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let SignupViewController=self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(SignupViewController, animated: true)
        }
    }
}
//Dismiss the key board if the user taps on the screen after adding data
extension UITableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

