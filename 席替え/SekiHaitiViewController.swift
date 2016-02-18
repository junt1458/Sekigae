//
//  SekiHaitiViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SekiHaitiViewController: UIViewController {

    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for v in self.view.subviews {
            if v is UIButton {
                let btn = v as! UIButton
                for i in 0 ..< 50 {
                    let t : String = btn.currentTitle!
                    let b : Bool = t.containsString(String(i))
                    if b {
                        if btn.allTargets().count == 0 {
                            NSLog("ボタンです。名前: " + t)
                            btn.addTarget(self, action: "buttontap:", forControlEvents: .TouchUpInside)
                            var numstr = btn.currentTitle!
                            numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
                            let num = Int(numstr)! - 1
                            if AppData.sekistatus.count != AppData.CountLimit {
                                AppData.sekistatus.append(false)
                                if (num + 1) <= AppData.maxcount {
                                    AppData.sekistatus[num] = true
                                    btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
                                }else{
                                    AppData.sekistatus[num] = false
                                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                                }
                            } else {
                                if AppData.sekistatus[num] {
                                    btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
                                } else {
                                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                                }
                            }
                        }
                        break;
                    }
                }
            }else{
                NSLog("ボタンではありません。")
            }
        }
        checkbtnandupdlbl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        var numstr = btn.currentTitle!
        numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
        let num = Int(numstr)! - 1
        if AppData.sekistatus[num] {
            AppData.sekistatus[num] = false
            btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
            checkbtnandupdlbl()
        } else {
            AppData.sekistatus[num] = true
            btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
            checkbtnandupdlbl()
        }
        NSLog("%d番のボタンがタップされました。", num+1)
    }
    
    func checkbtnandupdlbl(){
        if AppData.maxcount == 0 {
            AppData.loadData()
        }
        var truecnt: Int = 0
        for b in AppData.sekistatus {
            if b {
                truecnt++
            }
        }
        if truecnt == AppData.maxcount {
            nextBtn.enabled = true
        }else{
            nextBtn.enabled = false
        }
        NSLog("maxcount: %d", AppData.maxcount)
        label.text = String(truecnt) + "/" + String(AppData.maxcount)
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
