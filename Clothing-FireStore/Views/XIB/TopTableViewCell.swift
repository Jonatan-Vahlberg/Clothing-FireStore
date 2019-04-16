//
//  TopTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-10.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

protocol NavigationalCatalogue{
    func navigateWith(searchTerm: String)
    func navigateWith(category: String)
}

class TopTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    let collectionId = "topBarCell"
    var delegate: NavigationalCatalogue?
    var categories = ["Skirts","Shoes","Shirts","Jackets","Extra"]

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}

extension TopTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 60)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "TopBarCollectionViewCell" ,bundle:nil), forCellWithReuseIdentifier: collectionId)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionId, for: indexPath) as! TopBarCollectionViewCell
        
        cell.nameLbl.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateWith(category: categories[indexPath.item])
    }
}

