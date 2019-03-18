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

        // Do any additional setup after loading the view.
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
        if(emailField.text?.count == 0 || passwordField.text?.count == 0){
            presentDefaultAlert(message: "Please Fill out all Nececary Fields")
        }
        else{
            SVProgressHUD.show()
                        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if(error != nil ){
                    SVProgressHUD.dismiss()
                    self.presentDefaultAlert(message: "There was an Error Logging In, Check Your Internet Connection And That The Email And Password Is Correct")
                }
                else{
                    SVProgressHUD.dismiss()
                    let emailSaved: Bool = KeychainWrapper.standard.set(self.emailField.text!, forKey:"currentEmail")
                    let passwordSaved: Bool = KeychainWrapper.standard.set(self.passwordField.text!, forKey: "currentPassword")
                    if emailSaved && passwordSaved{
                        print("saved")
                    }
                    self.presentNextViewController(enumValue: .home)
                }
            })
            
        }
       
        
    }
    
    func presentDefaultAlert(message: String){
        let alert = UIAlertController(title: "Problem Logging in", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
            //self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

}
