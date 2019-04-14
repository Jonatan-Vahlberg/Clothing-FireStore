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
        
        if let cart = CurrentStates.currentCustomer?.cart{
            
            for (key,value) in cart{
                print("LOOK FOR THIS",key)
                if let item = Catalogue.shared.get(ForID: key){
                    cartArray.append(item)
                    cartAmount.append(value)
                    finalPrice += (item.price * value)
                }
            }
            tableView.reloadData()
        }
        finalPriceLbl.title = "\(finalPrice)kr"
    }
    
    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }

    @IBAction func goToPayment(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "paymentModal", sender: self)
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
        tableView.reloadData()
    }
    
    
}

import Firebase
//Firebase spesific methods
extension CartViewController{
    
    func updateCart(){
        if let uid = Auth.auth().currentUser?.uid{
            var dict = [String:Int]()
            for x in 0...(cartArray.count - 1){
                let id = cartArray[x].id
                let amount = cartAmount[x]
                dict[id] = amount
            }
            let userRefrence = Firestore.firestore().collection("Users").document(uid)
            userRefrence.setData(["Cart": dict], merge: true)
        }
    }
}