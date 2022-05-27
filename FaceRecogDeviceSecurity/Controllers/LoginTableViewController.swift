//
//  LoginTableViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 15/05/22.
//

import UIKit
import Firebase

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=PasswordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let e=error{
                    print(e)
                }else{
                    self?.performSegue(withIdentifier: "LoginFaceAuthVC", sender: self)
                }
            }
        }
    }

    @IBAction func signUpPressed(_ sender: UIButton) {
        if let SignupViewController=self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(SignupViewController, animated: true)
        }
    }
    
}
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
