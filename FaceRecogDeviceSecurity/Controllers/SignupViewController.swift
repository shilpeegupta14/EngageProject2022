//
//  SignupViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 17/05/22.
//

import UIKit
import Firebase

class SignupViewController: UITableViewController {

    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ProfileImg.addGestureRecognizer(tapGesture)
    }
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text, confirmPasswordTextField==passwordTextField {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e=error{
                            print(e.localizedDescription)
                        }else{
                            self.performSegue(withIdentifier: "SignUpFaceAuthVC", sender: self)
                        }
                    }
                }
    }
}
extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            ProfileImg.image = img
        }
        dismiss(animated: true)
    }
}
