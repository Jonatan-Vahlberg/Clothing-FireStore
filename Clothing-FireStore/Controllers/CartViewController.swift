//
//  CartViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-29.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class CartViewController: StoryboardNavigationViewController {

    @IBOutlet var finalPriceLbl: UINavigationItem!
    var finalPrice = 0
    var cartArray = [CatalogueItem]()
    var cartAmount = [Int]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CartTableViewCell" ,bundle: nil), forCellReuseIdentifier: "cartCell")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let cart = CurrentStates.currentCustomer?.cart{
            
            for (key,value) in cart{
                if let item = Catalogue.shared.get(ForID: key){
                    cartArray.append(item)
                    cartAmount.append(value)
                    finalPrice += (item.price * value)
                }
            }
            tableView.reloadData()
        }
        finalPriceLbl.title = "\(finalPrice)kr"
        tableView.reloadData()
    }
    
    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }

    @IBAction func goToPayment(_ sender: UIBarButtonItem) {
        if let user = Auth.auth().currentUser{
            performSegue(withIdentifier: "paymentModal", sender: self)
        }
        else{
            let alert = UIAlertController(title: "Unable to Continue With Purchase", message: "Due to not being logged in the item can't be added to cart or paid for.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Login/Register", style: .default, handler: { (action) in
                self.presentNextViewController(enumValue: .login)
            })
            let notNowAction = UIAlertAction(title: "Not Now", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(loginAction)
            alert.addAction(notNowAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentModal"{
            let vc = segue.destination as! PaymentPopupViewController
            vc.finalPrice = finalPrice
        }
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cartArray.count > 0) ? cartArray.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        if !cartArray.isEmpty{
            let item  = cartArray[indexPath.row]
            cell.nameLbl.text = item.name
            cell.amount = cartAmount[indexPath.row]
            let priceTimesAmount = item.price * cell.amount
            cell.priceLbl.text = ("\(item.price) * \(cell.amount) = \(priceTimesAmount) kr")
            cell.removeBtn.tag = indexPath.row
            cell.delegate = self
            if let image = UIImage(named:item.image){
                cell.itemImageView.image = image
            }
            
        }
        calculateFinalPrice()
        
        return cell
    }
    
    func calculateFinalPrice(){
        finalPrice = 0
        for x in 0...(cartArray.count - 1){
            let priceOfItems = (cartArray[x].price * cartAmount[x])
            finalPrice += priceOfItems
        }
        
        finalPriceLbl.title = "\(finalPrice)kr"
    }
    
    
    
    
}

extension CartViewController: cartItemControll{
    
    func change(itemAt row: Int, With amount: Int) {
        cartAmount[row] = amount
        tableView.reloadData()
        updateCart()
    }
    
    func removeTheItem(atRow row: Int) {
        cartArray.remove(at: row)
        updateCart()
        tableView.reloadData()
    }
    
    
}

import Firebase
//Firebase spesific methods
extension CartViewController{
    
    func updateCart(){
        if let uid = Auth.auth().currentUser?.uid{
            var dict = [String:Int]()
            CurrentStates.currentCustomer?.cart = [:]
            for x in 0...(cartArray.count - 1){
                let id = cartArray[x].id
                let amount = cartAmount[x]
                dict[id] = amount
                CurrentStates.currentCustomer?.cart![cartArray[x].id] = cartAmount[x]
            }
            let userRefrence = Firestore.firestore().collection("Users").document(uid)
            userRefrence.setData(["Cart": dict], merge: true)
            
        }
    }
    
}
