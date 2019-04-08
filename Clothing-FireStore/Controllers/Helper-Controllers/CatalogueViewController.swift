//
//  CatalogueViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-08.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class CatalogueViewController: StoryboardNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CatalogueViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
        
}


