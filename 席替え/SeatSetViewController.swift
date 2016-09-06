//
//  SeatSetViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/12.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SeatSetViewController: UIViewController {

    var manmode: Bool!  //男の固定化
    var seatnum: Int!   //席番号

    @IBOutlet var saveBtn: UIButton!
    
    //
    // 文字サイズの配列の位置を取得する関数
    //
    func getIndex(lng: Int) -> Int {
        var ind: Int = lng - 5
        if lng >= 7 {
            ind -= 1
        }
        if ind < 0 {
            ind = 5
        }
        if lng > 9 {
            ind = 4
        }
        return ind
    }
    
    //
    // 文字サイズの配列を取得する関数
    //
    func getSizeArray() -> [Float] {
        if AppData.usesize1 {
            return AppData.size1
        } else {
            return AppData.size2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // ボタンの設定
        //
        for i in 0 ..< AppData.CountLimit {
            for v in self.view.subviews {
                if let btn = v as? UIButton {
                    let t : String = btn.currentTitle!
                    let b : Bool = (t == String(format: "Button%d", (i + 1)))
                    if b {
                        if btn.allTargets().count == 0 {
                            btn.addTarget(self, action: #selector(SeatSetViewController.buttontap(_:)), forControlEvents: .TouchUpInside)
                            var numstr = btn.currentTitle!
                            numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
                            let num = Int(numstr)! - 1
                            if AppData.Seat_Data[num] >= 0 {
                                btn.setTitle(AppData.People_Data[AppData.Seat_Data[num]].Name, forState: .Normal)
                                let lng:Int = Int(String(AppData.People_Data[AppData.Seat_Data[num]].Name.endIndex))!
                                btn.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
                            } else {
                                btn.setTitle("", forState: .Normal)
                            }
                            btn.tag = num + 100;
                        }
                        break;
                    }
                }
            }
        }
        setupbuttons()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // ボタンの文字をもう一度再表示する関数
    //
    func redrawbtns(){
        for i in 0 ..< AppData.sekistatus.count{
            let btn = self.view.viewWithTag(i + 100) as! UIButton
            if AppData.Seat_Data[i] >= 0 {
                btn.setTitle(AppData.People_Data[AppData.Seat_Data[i]].Name, forState: .Normal)
                let lng:Int = Int(String(AppData.People_Data[AppData.Seat_Data[i]].Name.endIndex))!
                btn.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
            } else {
                btn.setTitle("", forState: .Normal)
            }
        }
    }
    
    //
    // ボタンの設定
    //
    func setupbuttons(){
        var a : Int = 0
        for i in 0 ..< AppData.sekistatus.count {
            AppData.m_wstatus.append(true)
            let btn : UIButton = self.view.viewWithTag(i + 100) as! UIButton
            if AppData.sekistatus[i] {
                btn.setBackgroundImage(UIImage(named: "man.png"), forState: .Normal)
                btn.setImage(nil, forState: .Normal)
                if !AppData.m_wstatus[i] {
                    btn.setBackgroundImage(UIImage(named: "woman.png"), forState: .Normal)
                }
            }else{
                a += 1
                btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                btn.enabled = false
            }
        }
        saveBtn.enabled = true
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    // 設定の切り替え
    //
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        let num = btn.tag - 100
        manmode = AppData.m_wstatus[num]
        seatnum = num
        performSegueWithIdentifier("SetSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! SelectNameViewController
        vc.manmode = self.manmode
        vc.vc = self
        vc.seatnum = self.seatnum
    }

}
