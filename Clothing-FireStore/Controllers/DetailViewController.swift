//
//  DetailViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-15.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var typeName = ""
    var orders = [Order]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        if typeName == "Orders"{
            orders = (CurrentStates.currentCustomer?.purchases)!
            tableView.register(UINib(nibName: "OrderTableViewCell",bundle: nil), forCellReuseIdentifier: "orderCell")
        }
        else{
            //tableView.register(UINib(nibName: "OrderTableViewCell"), forCellReuseIdentifier: "favouritesCell")
        }
        title = typeName
        
    }

    @IBAction func `return`(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeName == "Orders"{
            return orders.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if typeName == "Orders"{
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
            cell.nameLbl.text = "Name: \(order.name)"
            cell.cardLbl.text = "Card Nr: \(order.cardNr)"
            cell.priceLbl.text = "Price: \(order.price)"
            cell.orderDateLbl.text = "Order Date: \(order.orderDate)"
            cell.estimatedDateLbl.text = "Delivery Date: \(order.finalDate)"
            
             return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
            return cell
        }
        
       
    }
}
