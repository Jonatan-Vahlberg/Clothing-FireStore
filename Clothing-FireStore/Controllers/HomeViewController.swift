//
//  HomeViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: CatalogueViewController{
    
    

    @IBOutlet var tableView: UITableView!
    
    //var catalogue = Catalogue()
    
    @IBOutlet var menuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        
       
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName:"TopTableViewCell", bundle: nil), forCellReuseIdentifier: "topTableCell")
        
        tableView.register(UINib(nibName:"BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "bannerCell")
        
        tableView.register(UINib(nibName:"CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "catalogueTableCell")
        
//        for x in 0...(Catalogue.shared.count() - 1){
//            print("Item \(x): \(Catalogue.shared.get(for: x)?.name)")
//        }
        //updateDatabase()
    }
    
    func updateDatabase(){
        let refrence = Database.database().reference()
        let catalogueDB = refrence.child("Catalogue")
        
        for x in 0...(Catalogue.shared.count() - 1){
            if let item = Catalogue.shared.get(for: x){
                let itemChild = catalogueDB.child(String(item.id))
                
                itemChild.child("Id").setValue(item.id)
                itemChild.child("Name").setValue(item.name)
                itemChild.child("Price").setValue(item.price)
                itemChild.child("Description").setValue(item.description)
                itemChild.child("Stock").setValue(item.stock)
            }
            
        }
        
    }
}
//MARK: - Table View Overrides
extension HomeViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            tableView.rowHeight = 116
            let cell = tableView.dequeueReusableCell(withIdentifier: "topTableCell", for: indexPath) as! TopTableViewCell
            
            return cell
        }
        else if indexPath.row == 1{
            tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "bannerCell", for: indexPath) as! BannerTableViewCell
            
            cell.bannerText.text = "Get The new Spring Collection"
            cell.bannerImage.image = UIImage(named: "spring")
            cell.bannerImage.contentMode = .scaleAspectFill
            //tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            return cell
            
        }
        else{
            tableView.rowHeight = 260
              let cell = tableView.dequeueReusableCell(withIdentifier: "catalogueTableCell", for: indexPath) as! CatalogueTableViewCell
            cell.title.text = "Most Liked Items"
            cell.delegate = self
            
            
            return cell
        }
       
        
        
        
    }
}

extension HomeViewController: NavigationalItems{
    
    func navigate(with index: Int) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "itemSB") as! ItemViewController
//        vc.catalogueItem = Catalogue.shared.get(for: index)
//        present(vc, animated: true, completion: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "catalogueSB") as! FilterdCatalogueViewController
        present(vc, animated: true, completion: nil)
        CurrentStates.shared.catalogueState = GlobalState.catalogue
    }
    
    
}


