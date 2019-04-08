//
//  CartTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-29.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

protocol cartItemControll {
    func change(itemAt row:Int,With amount: Int)
    
    func removeTheItem(atRow row: Int)
}

class CartTableViewCell: UITableViewCell {

    var amount = 1
    
    @IBOutlet var removeBtn: UIButton!
    var delegate: cartItemControll?
    
    @IBOutlet var changeBtns: [UIButton]!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        for btn in changeBtns{
            btn.layer.borderColor = UIColor.black.cgColor
            btn.layer.borderWidth = 0.5
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeAmount(_ sender: UIButton) {
        
        if(amount + sender.tag <= 0){
            amount = 1
        }
        else{
            amount = amount + (sender.tag)
        }
        
        delegate?.change(itemAt: removeBtn.tag,With: amount)
    }
    
    @IBAction func prepareToDelete(_ sender: UIButton){
        delegate?.removeTheItem(atRow: sender.tag)
    }
    
}
