//
//  LoginViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: StoryboardNavigationViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
    }
    func dismisskeyboard(){
        view.endEditing(true)
    }

    

    @IBAction func loginPressed(_ sender: UIButton) {
        authenticateUser()
        
    }
    @IBAction func notNowButtonPressed(_ sender: UIBarButtonItem) {
        presentNextViewController(enumValue: .home)
    }
    @IBAction func registerButtonPressed(_ sender: UIBarButtonItem) {
        presentNextViewController(enumValue: .register)
    }
    
    func authenticateUser(){
        //Checks if email or password fields are empty before continuing
        if(emailField.text?.count == 0 || passwordField.text?.count == 0){
            presentDefaultAlert(message: "Please Fill out all Nececary Fields")
        }
        else{
            
            SVProgressHUD.show()
            //tries to authenticate user based on input to firebase
                        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if(error != nil ){
                    //if there was an error
                    SVProgressHUD.dismiss()
                    self.presentDefaultAlert(message: "There was an Error Logging In, Check Your Internet Connection And That The Email And Password Is Correct")
                }
                else{
                    //No errors
                    
                    SVProgressHUD.dismiss()
                    let emailSaved: Bool = KeychainWrapper.standard.set(self.emailField.text!, forKey:"currentEmail")
                    let passwordSaved: Bool = KeychainWrapper.standard.set(self.passwordField.text!, forKey: "currentPassword")
                    if emailSaved && passwordSaved{
                        print("saved")
                    }
                    CurrentStates.shared.getCurrentCustomer(fromDatabase: true)
                    self.presentNextViewController(enumValue: .home)
                }
            })
            
        }
       
        
    }
    
    //Function for presenting vanilla alert modal box with customizable message
    func presentDefaultAlert(message: String){
        let alert = UIAlertController(title: "Problem Logging in", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
            //self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

}
