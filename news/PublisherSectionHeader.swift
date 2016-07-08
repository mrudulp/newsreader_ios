//
//  PublisherSectionHeader.swift
//  news
//
//  Created by Mrudul Pendharkar on 07/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

class PublisherSectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var publisher:Publisher!{
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI(){
        self.headerLabel.text = publisher.section
    }
        
}
