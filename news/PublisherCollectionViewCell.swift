//
//  PublisherCollectionViewCell.swift
//  news
//
//  Created by Mrudul Pendharkar on 06/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

protocol PublisherCellDelegate {
    func deletePublisher(publisher:Publisher)
}

class PublisherCollectionViewCell: UICollectionViewCell {
    
    var delegate:PublisherCellDelegate!
    @IBOutlet weak var publisherImage: UIImageView!
    @IBOutlet weak var publisherVisualEffect: UIVisualEffectView!
    @IBOutlet weak var publisherTitle: UILabel!
    
    @IBOutlet weak var closeView: UIView!
    var publisher:Publisher!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        self.publisherImage.image = publisher.image
        self.publisherTitle.text = publisher.title
        self.layer.cornerRadius = 3.0
        self.closeView.layer.cornerRadius = 16.0
    }
    @IBAction func onCloseBtnClicked(sender: AnyObject) {
        print("Deleting Publisher")
        if let delegate = self.delegate{
            
            delegate.deletePublisher(publisher)
        }
    }
}
