//
//  CatalogueTableViewCell.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-08.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

protocol NavigationalItems{
    func navigate(with index: Int)
    func navigate(with item: CatalogueItem)
}

class CatalogueTableViewCell: UITableViewCell{

    @IBOutlet var title: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    let collectionId = "smallItemCell"
    var filteredCatalogue = [CatalogueItem]()
    var filtered = false
    
    var delegate: NavigationalItems?
    
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
        title.text = CurrentStates.shared.catalogueState.get()
        let flowLayout = UICollectionViewFlowLayout()
        
        switch CurrentStates.shared.catalogueState{
        case .home:
            flowLayout.scrollDirection = .horizontal
            break
        case .catalogue:
            flowLayout.scrollDirection = .vertical
            break
        case .category:
            flowLayout.scrollDirection = .vertical
            filteredCatalogue = Catalogue.shared.getFilterdCatalogue(byCategory: true, value: CurrentStates.shared.catalogueState.get())
            filtered = true
            break
            
        case .searched:
            flowLayout.scrollDirection = .vertical
            filteredCatalogue = Catalogue.shared.getFilterdCatalogue(byCategory: false, value: CurrentStates.shared.catalogueState.get())
            filtered = true
            break
            
        default:
            flowLayout.scrollDirection = .vertical
        }
        
        flowLayout.itemSize = CGSize(width: 120, height: 220)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell" ,bundle:nil), forCellWithReuseIdentifier: collectionId)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return getNumberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItemsForeachSection()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionId, for: indexPath) as! ItemCollectionViewCell
        if filtered{
            let item = filteredCatalogue[indexPath.item]
                cell.itemName.text = item.name
                cell.itemPrice.text = "\(item.price) kr"
            if let image = UIImage(named: item.image){
                cell.imageView.image = image
            }
        }
        else{
            guard let item = Catalogue.shared.get(for: indexPath.item) else{
                print("empty")
                return UICollectionViewCell()
            }
            cell.itemName.text = item.name
            cell.itemPrice.text = "\(item.price) kr"
            if let image = UIImage(named: item.image){
                cell.imageView.image = image
            }
        }

            return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if filtered{
            delegate?.navigate(with: filteredCatalogue[indexPath.item])
        }
        else{
            delegate?.navigate(with: indexPath.item)
        }
        
    }

    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getItemsForeachSection() -> Int {
        switch CurrentStates.shared.catalogueState{
        case .home:
            return 4
        case .catalogue:
            //var halved = Catalogue.shared.count() / 2
            return Catalogue.shared.count()
        case .category:
            return filteredCatalogue.count
        case .searched:
            return filteredCatalogue.count
        default:
            return Catalogue.shared.count()
        }
    }

    
    
}


