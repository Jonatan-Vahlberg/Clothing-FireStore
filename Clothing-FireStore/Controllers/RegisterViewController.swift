//
//  RegisterViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: StoryboardNavigationViewController {

    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func loginPressed(_ sender: UIBarButtonItem) {
        presentNextViewController(enumValue: .login)
        
    }
    @IBAction func notNowButtonPressed(_ sender: UIBarButtonItem) {
        presentNextViewController(enumValue: .home)
    }
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        //presentNextViewController(enumValue: .home)
        if firstNameField.text?.count == 0 ||
        lastNameField.text?.count == 0 ||
        emailField.text?.count == 0 ||
        passwordField.text?.count == 0 ||
        repeatPasswordField.text?.count == 0{
            presentDefaultAlert(message: "One ore more Fields were left empty")
        }
        else{
            if !(passwordField.text! == repeatPasswordField.text){
                presentDefaultAlert(message: "Passwords Do Not Match")
            }
            else{
                Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                    if(error != nil){
                        self.presentDefaultAlert(message: "Process Could Not Be Finished Try Agian")
                    }
                    else{
                        self.uploadUserCoupleData()
                        self.presentNextViewController(enumValue: .home)
                        
                    }
                })
            }
        }
        
    }
    
    func presentDefaultAlert(message: String){
        let alert = UIAlertController(title: "Problem In Register Process", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
            //self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func uploadUserCoupleData(){
        let newUser = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
        
        newUser.child("Name").setValue("\(firstNameField.text!) \(lastNameField.text!)")
        newUser.child("Email").setValue(emailField.text!)
        newUser.child("ProfilePic").setValue(nil)
        //newUser.child("Cart").setValue([Int:Int])
    }

}
