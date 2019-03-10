//
//  CatalogueTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-08.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit



class CatalogueTableViewCell: UITableViewCell{

    @IBOutlet var title: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    let collectionId = "smallItemCell"
    
    var catalogue : Catalogue?
    
    class var catalogueCell: CatalogueTableViewCell {
        let cell = Bundle.main.loadNibNamed("CatalogueTableViewCell", owner: self, options: nil)
        return cell as! CatalogueTableViewCell
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CatalogueTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc =  sb.instantiateViewController(withIdentifier: "homeStoryboard") as! HomeViewController
        
        vc.catalogueDelegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 220)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell" ,bundle:nil), forCellWithReuseIdentifier: collectionId)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = catalogue?.get(for: indexPath.item){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionId, for: indexPath) as! ItemCollectionViewCell
            cell.itemName.text = item.name
            cell.itemPrice.text = "\(item.price) kr"
            return cell
        }else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionId, for: indexPath) as! ItemCollectionViewCell
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item \(indexPath.item)")
    }

}

extension CatalogueTableViewCell: updateSelectedCatalogue{
    func updateCatalogue(withNew catalogue: Catalogue) {
        self.catalogue = catalogue
        collectionView.reloadData()
    }
    
    
}

