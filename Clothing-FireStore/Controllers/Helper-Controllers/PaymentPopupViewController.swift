//
//  PaymentPopupViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-11.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class PaymentPopupViewController: StoryboardNavigationViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var topLbl: UILabel!
    @IBOutlet var fullNameField: UITextField!
    @IBOutlet var accNumberField: UITextField!
    
    @IBOutlet var monthField: UITextField!
    
    @IBOutlet var yearField: UITextField!
    
    @IBOutlet var cvcField: UITextField!
    @IBOutlet var discountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func procedeWithPayment(_ sender: UIButton) {
        if allFieldsFilledIn(){
            if discountField.text == ""{
                checkDiscountCode()
            }
            let fullName = fullNameField.text
            let cardNumber = enshroud(cardNumber: accNumberField.text!)
            let monthYear = "\(monthField)/\(yearField)"
            
            
        }
    }
    @IBAction func returnToCart(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func allFieldsFilledIn() -> Bool{
        for field in textFields{
            if field.text == ""{
                presentDefaultAlert(message: "Make Sure That All Fields Are Correctly Filled In")
                return false
            }
        }
        return true
    }
    
    func presentDefaultAlert(message: String){
        let alert = UIAlertController(title: "Problem In payment", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
            //self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkDiscountCode(){
        
    }
    func enshroud(cardNumber: String) -> String{
        let length = cardNumber.count - 5
        var newCardString = ""
        for _ in 0...length{
            newCardString += "*"
        }
        let num = cardNumber.suffix(4)
        newCardString += num
        print(cardNumber,newCardString)
        return newCardString
    }
}
