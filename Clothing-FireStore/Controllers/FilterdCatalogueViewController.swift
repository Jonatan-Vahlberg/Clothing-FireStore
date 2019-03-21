//
//  CatalogueViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class FilterdCatalogueViewController: CatalogueViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                tableView.register(UINib(nibName:"TopTableViewCell", bundle: nil), forCellReuseIdentifier: "topTableCell")
        
        
                tableView.register(UINib(nibName:"CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "catalogueTableCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            tableView.rowHeight = 116
            let cell = tableView.dequeueReusableCell(withIdentifier: "topTableCell", for: indexPath) as! TopTableViewCell
            
            return cell
        }
        else{
            tableView.rowHeight = tableView.frame.height - 116
            let cell = tableView.dequeueReusableCell(withIdentifier: "catalogueTableCell", for: indexPath) as! CatalogueTableViewCell
            cell.title.text = "Catalogue"
            cell.delegate = self
            
            
            return cell
        }
    
    
    
    
    }
}

extension FilterdCatalogueViewController: NavigationalItems{
    func navigate(with index: Int) {
        
    }
    
    
}
