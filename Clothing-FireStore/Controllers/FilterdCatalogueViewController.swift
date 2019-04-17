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
    var searchController = UISearchController(searchResultsController: nil)
    var searchString: String?
    var searchValue = ""
    var filterdCatalogue = [CatalogueItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search for items"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
                tableView.register(UINib(nibName:"TopTableViewCell", bundle: nil), forCellReuseIdentifier: "topTableCell")
        
        
                tableView.register(UINib(nibName:"CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "catalogueTableCell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            tableView.rowHeight = 70
            let cell = tableView.dequeueReusableCell(withIdentifier: "topTableCell", for: indexPath) as! TopTableViewCell
            cell.delegate = self
            return cell
        }
        else{
            tableView.rowHeight = tableView.frame.height - 70
            print (tableView.rowHeight)
            let cell = tableView.dequeueReusableCell(withIdentifier: "catalogueTableCell", for: indexPath) as! CatalogueTableViewCell
            cell.title.text = "Catalogue"
            cell.delegate = self
            
            
            return cell
        }
    
    
    
    
    }
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }
}

extension FilterdCatalogueViewController: NavigationalItems{
    
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

extension FilterdCatalogueViewController: NavigationalCatalogue{
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

extension FilterdCatalogueViewController: UISearchControllerDelegate{
    func didDismissSearchController(_ searchController: UISearchController) {
        if searchString != ""{
            navigateWith(searchTerm: searchValue)
        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            searchValue = text
        }
    }
}
