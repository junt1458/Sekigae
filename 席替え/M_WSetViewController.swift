//
//  M_WSetViewController.swift
//  席替え
//  Description:
//    男女席配置ウィンドウの制御クラスです。
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class M_WSetViewController: UIViewController {

    var btns = [UIButton]()      //ボタンを収納する配列
    var btnsize: [CGFloat] = [0, 0]    //ボタンサイズ
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.setTitleColor(UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0), forState: .Disabled)  //次へボタンの色の設定
        
        //
        // ボタンの設定
        //
        btns = [UIButton]()
        for i in 0 ..< AppData.CountLimit {
            for v in self.view.subviews {
                if let btn = v as? UIButton {
                    if (btn.currentTitle! == String(format: "Button%d", (i + 1))) {
                        if btn.allTargets().count == 0 {
                            btn.addTarget(self, action: #selector(M_WSetViewController.buttontap(_:)), forControlEvents: .TouchUpInside)
                            var numstr = btn.currentTitle!
                            numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
                            let num = Int(numstr)! - 1
                            btn.tag = num + 100
                            btns.append(btn)
                            btnsize[0] = btn.frame.height
                            btnsize[1] = btn.frame.width
                        }
                        break;
                    }
                }
            }
        }
        setupbuttons()
        
        //
        // 男女配置設定の初期化
        //
        for i in 0 ..< AppData.CountLimit {
            if !AppData.sekistatus[i] {
                AppData.m_wstatus[i] = true
            }
        }
        
        //
        // ボタンの画像の設定
        //
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // 男女別の人数を取得する
    //
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
    
    //
    // 男女別の人数を取得する(ボタン設定前用)
    //
    func getNinzuu2(man: Bool) -> Int {
        var c = 0
        if man {
            for i in 0 ..< AppData.m_wstatus.count {
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
    
    //
    // ボタンの画像を設定する関数
    //
    func setupbuttons(){
        if AppData.m_wstatus.count != AppData.CountLimit {
            if AppData.CountLimit > AppData.m_wstatus.count {
                for _ in AppData.m_wstatus.count ..< AppData.CountLimit {
                    AppData.m_wstatus.append(true)
                    if(getNinzuu2(true) > AppData.mancount){
                        let i:Int = AppData.m_wstatus.count - 1
                        if AppData.sekistatus[i]{
                            AppData.m_wstatus[i] = false
                        }
                    }
                }
            } else {
                var list = [Bool]()
                for i in 0 ..< AppData.m_wstatus.count {
                    list.append(AppData.m_wstatus[i])
                }
                if list.count != AppData.m_wstatus.count {
                    for _ in list.count ..< AppData.CountLimit {
                        list.append(true)
                    }
                }
                AppData.m_wstatus = list
            }
        }
        nextBtn.enabled = true
    }
    
    
    //
    // 戻るボタン
    //
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //
    // ラベルを更新
    //
    func updatelabels(){
        let m : Int = getNinzuu(true)
        let w : Int = getNinzuu(false)
        label1.text = "男: " + String(m) + "/" + String(AppData.mancount)
        label2.text = "女: " + String(w) + "/" + String(AppData.womancount)
        if m == AppData.mancount && w == AppData.womancount {
            nextBtn.enabled = true
        }else{
            nextBtn.enabled = false
        }
    }
    
    //
    // 設定の変更
    //
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        var numstr = btn.currentTitle!
        numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
        let num = Int(numstr)! - 1
        if AppData.m_wstatus[num] {
           AppData.m_wstatus[num] = false
            btn.setImage(UIImage(named: "woman.png"), forState: .Normal)
        } else {
           AppData.m_wstatus[num] = true
            btn.setImage(UIImage(named: "man.png"), forState: .Normal)
        }
        updatelabels()
    }
    
    //
    // ボタンの場所の取得
    //
    func getBtnLocations() -> [CGPoint] {
        var ret = [CGPoint]()
        for a in btns {
            ret.append(a.center)
        }
        return ret
    }
    
    
    //
    // 次のウィンドウへ変数を渡す
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CheckViewController
        vc.btnlocations = self.getBtnLocations()
        vc.btnsize = self.btnsize
    }
}
