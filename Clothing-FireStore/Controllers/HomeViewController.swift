//
//  HomeViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: CatalogueViewController, UISearchControllerDelegate{
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchString = ""
    @IBOutlet var tableView: UITableView!
    
    //var catalogue = Catalogue()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search for items"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.register(UINib(nibName:"TopTableViewCell", bundle: nil), forCellReuseIdentifier: "topTableCell")
        
        tableView.register(UINib(nibName:"BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "bannerCell")
        
        tableView.register(UINib(nibName:"CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "catalogueTableCell")
        
//        for x in 0...(Catalogue.shared.count() - 1){
//            print("Item \(x): \(Catalogue.shared.get(for: x)?.name)")
//        }
        //updateDatabase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
    @IBAction func toggleMenu(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        if searchString != ""{
            navigateWith(searchTerm: searchString)
        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            searchString = text
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
            cell.delegate = self
            
            return cell
        }
        else if indexPath.row == 1{
            tableView.rowHeight = (self.view.frame.height / 4)
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "itemContainerSB") as! ContainerVC
        vc.passedData = [Catalogue.shared.get(for: index)]
        show(vc, sender: self)
    }
    func navigate(with item: CatalogueItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "itemContainerSB") as! ContainerVC
        vc.passedData = [item]
        show(vc, sender: self)
    }
}

extension HomeViewController: NavigationalCatalogue{
    func navigateWith(searchTerm: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "catalogueContainerSB")
        CurrentStates.shared.catalogueState = .searched(string: searchTerm)
        show(vc, sender: self)
    }
    
    func navigateWith(category: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "catalogueContainerSB")
        CurrentStates.shared.catalogueState = .category(type: category)
        show(vc, sender: self)
    }
    
    
}


