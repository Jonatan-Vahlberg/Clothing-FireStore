//
//  ItemCollectionViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-07.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    class var itemCell: ItemCollectionViewCell{
        let cell = Bundle.main.loadNibNamed("ItemCollectionViewCell", owner: self, options: nil)
        return cell as! ItemCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
