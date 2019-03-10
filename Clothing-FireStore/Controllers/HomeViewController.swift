//
//  HomeViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
protocol updateSelectedCatalogue {
    func updateCatalogue(withNew Catalogue: Catalogue)
}
class HomeViewController: CatalogueViewController{
    
    

    @IBOutlet var tableView: UITableView!
    
    var catalogue = Catalogue()
    
    var catalogueDelegate : updateSelectedCatalogue?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName:"TopTableViewCell", bundle: nil), forCellReuseIdentifier: "topTableCell")
        
        tableView.register(UINib(nibName:"BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "bannerCell")
        
        tableView.register(UINib(nibName:"CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "catalogueTableCell")
        
        
        
        catalogue.add(to: CatalogueItem(name: "Stilletto Heeels", price: 400, description: "", stock: 20){})
        catalogue.add(to: CatalogueItem(name: "Mobamba Heeels", price: 400, description: "", stock: 20){})
        catalogue.add(to: CatalogueItem(name: "Stilletto Heeels", price: 100, description: "", stock: 20){})
        catalogue.add(to: CatalogueItem(name: "Mobamba Heeels", price: 900, description: "", stock: 20){})
        
        catalogueDelegate?.updateCatalogue(withNew: catalogue)
        // Do any additional setup after loading the view.
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
            
            
            return cell
        }
       
        
        
        
    }
}


//MARK: - Collection View Overrides
//extension HomeViewController{
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(catalogue.count())
//        return catalogue.count()
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print(indexPath.item)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallItemCell", for: indexPath) as! ItemCollectionViewCell
//        let item = catalogue.get(for: indexPath.item)
//        cell.itemName.text = item.name
//        cell.itemPrice.text = String(item.price)
//
//        return cell
//    }
//}

