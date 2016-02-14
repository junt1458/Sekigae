//
//  M_WSetViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class M_WSetViewController: UIViewController {

    var sekistatus = [Bool]()
    var m_wstatus = [Bool]()
    var maxcount : Int = 0
    var mancount : Int = 0
    var womancount: Int = 0
    var btns = [UIButton]()
    var btnsize = [CGFloat]()
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnsize.append(0)
        btnsize.append(0)
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
                            btn.tag = num + 100
                            btnsize[0] = btn.frame.height
                            btnsize[1] = btn.frame.width
                        }
                        break;
                    }
                }
            }else{
                NSLog("ボタンではありません。")
            }
        }
        getBtns()
        setupbuttons()
        // Do any additional setup after loading the view.
    }
    
    func getBtns(){
        btns = [UIButton]()
        for i in 0 ..< sekistatus.count {
            btns.append(self.view.viewWithTag(i + 100) as! UIButton)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupbuttons(){
        var a : Int = 0
        for i in 0 ..< sekistatus.count {
            m_wstatus.append(true)
            let btn : UIButton = self.view.viewWithTag(i + 100) as! UIButton
            if sekistatus[i] {
                btn.setImage(UIImage(named: "man.png"), forState: .Normal)
                if (i - a) >= mancount {
                    m_wstatus[i] = false
                    btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
                }
            }else{
                a++
                btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                btn.enabled = false
            }
        }
        label1.text = "男: " + String(mancount) + "/" + String(mancount)
        label2.text = "女: " + String(womancount) + "/" + String(womancount)
        nextBtn.enabled = true
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updatelabels(){
        var m : Int = 0
        var w : Int = 0
        for i in 0 ..< sekistatus.count {
            if sekistatus[i] {
                if m_wstatus[i] {
                    m++
                }else{
                    w++
                }
            }
        }
        label1.text = "男: " + String(m) + "/" + String(mancount)
        label2.text = "女: " + String(w) + "/" + String(womancount)
        
        if m == mancount && w == womancount {
            nextBtn.enabled = true
        }else{
            nextBtn.enabled = false
        }
    }
    
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        NSLog("成功: ボタンの取得")
        var numstr = btn.currentTitle!
        NSLog("成功: ボタンの名前")
        numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
        NSLog("成功: ボタン番号String取得")
        let num = Int(numstr)! - 1
        NSLog("成功: ボタン番号取得")
        if m_wstatus[num] {
           m_wstatus[num] = false
            btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
        } else {
           m_wstatus[num] = true
            btn.setImage(UIImage(named: "man.png"), forState: .Normal)
        }
        updatelabels()
        NSLog("成功: ラベルのアップデート")
        NSLog("%d番のボタンがタップされました。", num+1)
    }
    
    func getBtnLocations() -> [CGPoint] {
        var ret = [CGPoint]()
        for a in btns {
            ret.append(a.center)
        }
        return ret
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CheckViewController
        vc.sekistatus = self.sekistatus
        vc.m_wstatus = self.m_wstatus
        vc.maxcount = self.maxcount
        vc.mancount = self.mancount
        vc.womancount = self.womancount
        vc.btnlocations = self.getBtnLocations()
        vc.btnsize = self.btnsize
    }
}
