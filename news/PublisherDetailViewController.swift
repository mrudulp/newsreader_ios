//
//  PublisherDetailViewController.swift
//  news
//
//  Created by Mrudul Pendharkar on 06/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

class PublisherDetailViewController: UIViewController {

    var publisher:Publisher!
    /*
    {
        didSet{
            self.updateUI()
        }
    }
    */
//    init(publisher : Publisher) {
//        super.init(nibName: "Main.storyboard", bundle: nil)
//        self.publisher = publisher
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var publisherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        updateUI()
    }
    
    func setPublisher(publisher:Publisher){
        self.publisher = publisher
    }
    
    private func updateUI(){
        if (publisher != nil){
            publisherImage.image = self.publisher.image
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
