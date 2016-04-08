//
//  M_WSetViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class M_WSetViewController: UIViewController {

    var btns = [UIButton]()
    var btnsize = [CGFloat]()
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.setTitleColor(UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0), forState: .Disabled)
        btnsize.append(0)
        btnsize.append(0)
        for i in 0 ..< AppData.CountLimit {
            for v in self.view.subviews {
                if let btn = v as? UIButton {
                    let t : String = btn.currentTitle!
                    let b : Bool = (t == String(format: "Button%d", (i + 1)))
                    if b {
                        NSLog("ボタン発見。名前: " + t)
                        if btn.allTargets().count == 0 {
                            NSLog("ボタンです。名前: " + t)
                            btn.addTarget(self, action: #selector(M_WSetViewController.buttontap(_:)), forControlEvents: .TouchUpInside)
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
            }
        }
        getBtns()
        setupbuttons()
        for i in 0 ..< AppData.CountLimit {
            if !AppData.sekistatus[i] {
                AppData.m_wstatus[i] = true
            }
        }
        for i in 0 ..< AppData.CountLimit {
            let btn = view.viewWithTag(i + 100) as! UIButton
            if AppData.sekistatus[i] {
                if AppData.m_wstatus[i] {
                    btn.setImage(UIImage(named: "man.png"), forState: .Normal)
                } else {
                    btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
                }
            } else {
                btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                btn.enabled = false
            }
        }
        if getNinzuu(true) == AppData.mancount && getNinzuu(false) == AppData.womancount {
            nextBtn.enabled = true
        } else {
            nextBtn.enabled = false
        }
        label1.text = "男: " + String(getNinzuu(true)) + "/" + String(AppData.mancount)
        label2.text = "女: " + String(getNinzuu(false)) + "/" + String(AppData.womancount)
        // Do any additional setup after loading the view.
    }
    
    func getNinzuu(man: Bool) -> Int {
        var c = 0
        if man {
            for i in 0 ..< AppData.sekistatus.count {
                if AppData.m_wstatus[i] && AppData.sekistatus[i] {
                    c += 1
                }
            }
        } else {
            for i in 0 ..< AppData.sekistatus.count {
                if !AppData.m_wstatus[i] {
                    c += 1
                }
            }
        }
        return c
    }
    
    func getBtns(){
        btns = [UIButton]()
        for i in 0 ..< AppData.sekistatus.count {
            btns.append(self.view.viewWithTag(i + 100) as! UIButton)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupbuttons(){
        var a : Int = 0
        if AppData.m_wstatus.count != AppData.CountLimit {
            for i in 0 ..< AppData.sekistatus.count {
                AppData.m_wstatus.append(true)
                let btn : UIButton = self.view.viewWithTag(i + 100) as! UIButton
                if AppData.sekistatus[i] {
                    btn.setImage(UIImage(named: "man.png"), forState: .Normal)
                    if (i - a) >= AppData.mancount {
                        AppData.m_wstatus[i] = false
                        btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
                    }
                }else{
                    a += 1
                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                    btn.enabled = false
                }
            }
        } else {
            for i in 0 ..< AppData.sekistatus.count {
                NSLog("m_wstatus[%d]:%@", i, AppData.m_wstatus[i])
                let btn : UIButton = self.view.viewWithTag(i + 100) as! UIButton
                if AppData.sekistatus[i] {
                    if AppData.m_wstatus[i] {
                        btn.setImage(UIImage(named: "man.png"), forState: .Normal)
                    } else {
                        btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
                    }
                } else {
                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                    btn.enabled = false
                }
            }
        }
        NSLog("AppData.m_wstatus.count:%d", AppData.m_wstatus.count)
        label1.text = "男: " + String(AppData.mancount) + "/" + String(AppData.mancount)
        label2.text = "女: " + String(AppData.womancount) + "/" + String(AppData.womancount)
        nextBtn.enabled = true
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updatelabels(){
        var m : Int = 0
        var w : Int = 0
        for i in 0 ..< AppData.sekistatus.count {
            if AppData.sekistatus[i] {
                if AppData.m_wstatus[i] {
                    m += 1
                }else{
                    w += 1
                }
            }
        }
        NSLog("男子%d人,女子%d人", m, w)
        label1.text = "男: " + String(m) + "/" + String(AppData.mancount)
        label2.text = "女: " + String(w) + "/" + String(AppData.womancount)
        NSLog("更新")
        if m == AppData.mancount && w == AppData.womancount {
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
        if AppData.m_wstatus[num] {
           AppData.m_wstatus[num] = false
            btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
        } else {
           AppData.m_wstatus[num] = true
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
        vc.btnlocations = self.getBtnLocations()
        vc.btnsize = self.btnsize
    }
}
