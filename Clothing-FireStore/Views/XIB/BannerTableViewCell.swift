//
//  BannerTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-10.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet var bannerImage: UIImageView!
    
    @IBOutlet var bannerText: UILabel!
    var bannerSegueIdentifier = "bannerToCatalogue"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
