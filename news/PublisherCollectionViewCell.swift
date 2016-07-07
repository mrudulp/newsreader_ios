//
//  PublisherCollectionViewCell.swift
//  news
//
//  Created by Mrudul Pendharkar on 06/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

class PublisherCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var publisherImage: UIImageView!
    @IBOutlet weak var publisherVisualEffect: UIVisualEffectView!
    @IBOutlet weak var publisherTitle: UILabel!
    
    var publisher:Publisher!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        self.publisherImage.image = publisher.image
        self.publisherTitle.text = publisher.title
        self.layer.cornerRadius = 3.0
    }
}
