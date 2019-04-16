//
//  OrderTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-15.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet var orderNrLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var estimatedDateLbl: UILabel!
    @IBOutlet var orderDateLbl: UILabel!
    @IBOutlet var cardLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
