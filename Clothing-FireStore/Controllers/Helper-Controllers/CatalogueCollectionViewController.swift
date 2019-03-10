//
//  ItemCollectionViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-07.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CatalogueCollectionViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }

    // MARK: METHODS TO BE OVERRIDEN BY CHILDREN
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 220)
    }

    

}
