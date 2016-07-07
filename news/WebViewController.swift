//
//  WebViewController.swift
//  news
//
//  Created by Mrudul Pendharkar on 06/07/16.
//  Copyright © 2016 ShreeVed. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    var publisher:Publisher!
    
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var progressview: UIProgressView!
    
    private var hasFinishedLoading = false
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = publisher.title
        webview.delegate = self
        let pageURL = NSURL(string: publisher.url)
        let request = NSURLRequest(URL: pageURL!)
        webview.loadRequest(request)
        navigationController?.hidesBarsOnSwipe = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: webview delegate
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0*Double(NSEC_PER_SEC))), dispatch_get_main_queue()){
            [weak self] in
            if let _self = self{
                _self.hasFinishedLoading = true
            }
        }
    }
    
    deinit{
        webview.stopLoading()
        webview.delegate = nil
    }
    
    func updateProgress(){
        if (progressview.progress >= 1){
            progressview.hidden = true
        } else {
            if hasFinishedLoading {
                progressview.progress += 0.002
            }else{
                if (progressview.progress <= 0.3){
                    progressview.progress += 0.004
                }
                else if (progressview.progress <= 0.6){
                    progressview.progress += 0.002
                }
                else if (progressview.progress <= 0.9){
                    progressview.progress += 0.001
                }
                else if (progressview.progress <= 0.94){
                    progressview.progress += 0.0001
                } else {
                    progressview.progress = 0.9401
                }
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.008*Double(NSEC_PER_SEC))), dispatch_get_main_queue()){
            [weak self] in
            if let _self = self{
                _self.updateProgress()
            }
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
