//
//  SekiHaitiViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SekiHaitiViewController: UIViewController {

    var sekistatus = [Bool]()
    var maxcount : Int = 0
    var mancount : Int = 0
    var womancount : Int = 0
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
                            sekistatus.append(false)
                            if (num + 1) <= maxcount {
                                sekistatus[num] = true
                                btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
                            }else{
                                sekistatus[num] = false
                                btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
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
        if sekistatus[num] {
            sekistatus[num] = false
            btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
            checkbtnandupdlbl()
        } else {
            sekistatus[num] = true
            btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
            checkbtnandupdlbl()
        }
        NSLog("%d番のボタンがタップされました。", num+1)
    }
    
    func checkbtnandupdlbl(){
        var truecnt: Int = 0
        for b in sekistatus {
            if b {
                truecnt++
            }
        }
        if truecnt == maxcount {
            nextBtn.enabled = true
        }else{
            nextBtn.enabled = false
        }
        label.text = String(truecnt) + "/" + String(maxcount)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! M_WSetViewController
        vc.maxcount = maxcount
        vc.womancount = womancount
        vc.mancount = mancount
        vc.sekistatus = sekistatus
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
