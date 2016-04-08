//
//  UsageViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class UsageViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        // Do any additional setup after loading the view.
        let url = NSURL(string: AppData.baseurl + AppData.dir + AppData.usagePage)
        let req = NSURLRequest(URL: url!)
        webview.loadRequest(req)
    }
    
    func pullToRefresh() {
        self.refreshControl.endRefreshing()
        webview.reload()
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(UsageViewController.pullToRefresh), forControlEvents:.ValueChanged)
        webview.scrollView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
