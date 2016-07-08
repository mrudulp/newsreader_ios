//
//  PublishersCollectionViewController.swift
//  news
//
//  Created by Mrudul Pendharkar on 05/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PublishersCollectionViewController: UICollectionViewController, PublisherCellDelegate {

    //DataSource
    let publishers = Publishers()
    private let leftAndRightPaddings: CGFloat = 32.0
    private let numberOfItems: CGFloat = 3.0
    private let heightAdjustment: CGFloat = 30.0
    private var canClose:Bool = true
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addItemBtn: UIBarButtonItem!
    private struct Storyboard
    {
        static let CellIdentifier = "PublisherCell"
        static let showWebView = "ShowWebView"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)/numberOfItems
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return publishers.numberOfSections
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pubs = publishers.numberOfPublishersInSection(section)
        let str = "pub count :: \(pubs):: section:: \(section)"
        print(str)
        return publishers.numberOfPublishersInSection(section)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! PublisherCollectionViewCell
        cell.publisher = publishers.publisherForItemAtIndexPath(indexPath)
        cell.delegate = self
        cell.closeView.hidden = canClose
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let publisher = publishers.publisherForItemAtIndexPath(indexPath)
        self.performSegueWithIdentifier(Storyboard.showWebView, sender: publisher)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! PublisherSectionHeader
        if let publisher = publishers.publisherForItemAtIndexPath(indexPath){
            headerView.publisher = publisher
        }
        return headerView
    }
    
    override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print("Moving Item from \(sourceIndexPath.row) to \(destinationIndexPath.row)")
        publishers.movePublisherFromIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.showWebView {
            let webViewController = segue.destinationViewController as! WebViewController
            let publisher = sender as! Publisher
            webViewController.publisher = publisher
        }
    }
    @IBAction func onAddItemClicked(sender: AnyObject) {
        //print("We arriuved here")
        let indexPath = publishers.indexPathForNewRandomPublisher()
        self.collectionView?.insertItemsAtIndexPaths([indexPath])
    }
    
    @IBAction func onEditClicked(sender: AnyObject) {
        
        if (self.editButton.title == "Edit") {
            print("Editing Collection")
            self.editButton.title = "Done"
            self.canClose = false
        } else {
            print("Done Collection")
            self.editButton.title = "Edit"
            self.canClose = true
        }
        self.collectionView?.reloadData()
    }
    
    // MARK: PublisherCellDelegate
    
    func deletePublisher(publisher:Publisher) {
        let indexPath:NSIndexPath = publishers.indexPathForPublisher(publisher)
        let indexs = [indexPath]
        publishers.deleteItemsAtIndexPaths(indexs)
        collectionView?.reloadData()
    }

}
