//
//  PaymentPopupViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-11.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class PaymentPopupViewController: StoryboardNavigationViewController {
    
    var finalPrice = 0
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
    }
    
    func dismisskeyboard(){
        view.endEditing(true)
    }
    // Aims to create a document in firestore to trigger a procceseing mail
    //Test with Temp Mail
    @IBAction func procedeWithPayment(_ sender: UIButton) {
        if allFieldsFilledIn(){
            if discountField.text == ""{
                checkDiscountCode()
            }
            let fullName = fullNameField.text
            let cardNumber = enshroud(cardNumber: accNumberField.text!)
            let monthYear = "\(monthField.text!)/\(yearField.text!)"
            let orderNumber = Int(arc4random_uniform(9999999) + 1000000)
            let orderDate = Date.getCurrentDate(fromFormat: "yyyy-MM-dd HH:mm")
            let finalDate = Date.getDateFromToday(fromFormat: "yyyy-MM-dd", daysInFuture: Int(arc4random_uniform(21) + 7))
            if let userID = Auth.auth().currentUser?.uid{
                Firestore.firestore().collection("Users").document(userID).collection("orders").addDocument(data:
                    ["fullName": fullName,
                     "cardNR": cardNumber,
                     "monthYear": monthYear,
                     "orderNR": orderNumber,
                     "orderDate": orderDate,
                     "finalDate": finalDate,
                     "finalprice": finalPrice], completion: { (err) in
                        if err != nil{
                        self.presentDefaultAlert(message: "Something Went Wrong With order Please Check Your Internet Connection")
                        }
                        else{
                            guard let user = CurrentStates.currentCustomer else{
                                return
                            }
                            let userRef = Firestore.firestore().collection("Users").document(userID)
                            userRef.setData(["email":user.email,
                                             "firstName":user.firstName,
                                             "lastName": user.lastName], merge: false)
                            CurrentStates.currentCustomer?.cart = [:]
                            self.presentNextViewController(enumValue: .cart)
                        }
                })
                
            }
            
            
        }
    }
    @IBAction func returnToCart(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //Check for field Validity
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
    
    //Hide all but last four numbers of card for saving and mailing purposes
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

//Exstension of date class to get a specified date string easy
extension Date{
    static func getCurrentDate(fromFormat format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    
    //Gets date n number of days in the future from today
    static func getDateFromToday(fromFormat format: String, daysInFuture days: Int) -> String{
        if let futureDate = Calendar.current.date(byAdding: .day, value: days, to: Date()){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: futureDate)
        }
        return "No Final Date Set Yet"
    }
}
