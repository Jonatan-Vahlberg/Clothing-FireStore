//
//  ItemViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-14.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    var catalogueItem: CatalogueItem?
    

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = catalogueItem {
            nameLabel.text = item.name
            priceLabel.text = " \(item.price) kr"
            if let itemImage = UIImage(named:"item_\(item.id)"){
                imageView.image = itemImage
            }
        }
        else{
            
            
        }
    }


}
