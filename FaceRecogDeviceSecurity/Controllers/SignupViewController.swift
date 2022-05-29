//
//  SignupViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 17/05/22.
//

import UIKit
import Firebase

class SignupViewController: UITableViewController {

    //properties on the screen displayed
    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
   
    //loads up the view
    override func viewDidLoad() {
        super.viewDidLoad()
        //user taps on the profile image view to add a profile picture
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ProfileImg.addGestureRecognizer(tapGesture)
    }
    //opens gallery to pick a profile photo
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    //login pressed and navigates to the home screen
    @IBAction func loginPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //after signup is pressed, user is registered and navigated to the home screen
    @IBAction func signupPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text, confirmPasswordTextField==passwordTextField {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e=error{
                            print(e.localizedDescription)
                        }else{
                            self.performSegue(withIdentifier: "SignupSegueIdentifier", sender: self)
                        }
                    }
                }
    }
}
extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //offered photos to choose from library to set a profile picture
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
