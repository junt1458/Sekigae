//
//  SeatSetViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/12.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SeatSetViewController: UIViewController {

    var manmode: Bool!
    var seatnum: Int!

    @IBOutlet var saveBtn: UIButton!
    
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
                            NSLog("SeatData[%d]:%d", num, AppData.Seat_Data[num])
                            if AppData.Seat_Data[num] >= 0 {
                                btn.setTitle(AppData.People_Data[AppData.Seat_Data[num]].Name, forState: .Normal)
                                let lng:Int = Int(String(AppData.People_Data[AppData.Seat_Data[num]].Name.endIndex))!
                                if lng == 5 {
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(15)
                                }else if lng == 6  || lng == 7{
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(11.5)
                                }else if lng == 8 {
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(9)
                                } else if lng == 9{
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(8.5)
                                } else if lng > 9{
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(8)
                                } else {
                                    btn.titleLabel?.font = UIFont.systemFontOfSize(18)
                                }
                            } else {
                                btn.setTitle("", forState: .Normal)
                            }
                            NSLog("num:%d",num)
                            btn.tag = num + 100;
                        }
                        break;
                    }
                }
            }else{
                NSLog("ボタンではありません。")
            }
        }
        setupbuttons()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func redrawbtns(){
        for i in 0 ..< AppData.sekistatus.count{
            let btn = self.view.viewWithTag(i + 100) as! UIButton
            if AppData.Seat_Data[i] >= 0 {
                btn.setTitle(AppData.People_Data[AppData.Seat_Data[i]].Name, forState: .Normal)
                let lng:Int = Int(String(AppData.People_Data[AppData.Seat_Data[i]].Name.endIndex))!
                if lng == 5 {
                    btn.titleLabel?.font = UIFont.systemFontOfSize(15)
                }else if lng == 6  || lng == 7{
                    btn.titleLabel?.font = UIFont.systemFontOfSize(11.5)
                }else if lng == 8 {
                    btn.titleLabel?.font = UIFont.systemFontOfSize(9)
                } else if lng == 9{
                    btn.titleLabel?.font = UIFont.systemFontOfSize(8.5)
                } else if lng > 9{
                    btn.titleLabel?.font = UIFont.systemFontOfSize(8)
                } else {
                    btn.titleLabel?.font = UIFont.systemFontOfSize(18)
                }
            } else {
                btn.setTitle("", forState: .Normal)
            }
        }
    }
    
    func setupbuttons(){
        var a : Int = 0
        for i in 0 ..< AppData.sekistatus.count {
            AppData.m_wstatus.append(true)
            NSLog("i:%d",i)
            let btn : UIButton = self.view.viewWithTag(i + 100) as! UIButton
            if AppData.sekistatus[i] {
                btn.setBackgroundImage(UIImage(named: "man.png"), forState: .Normal)
                btn.setImage(nil, forState: .Normal)
                if !AppData.m_wstatus[i] {
                    btn.setBackgroundImage(UIImage(named: "woman.png"), forState: .Normal)
                }
            }else{
                a++
                btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                btn.enabled = false
            }
        }
        saveBtn.enabled = true
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        NSLog("成功: ボタンの取得")
        let num = btn.tag - 100
        NSLog("設定の処理をここに書く")
        manmode = AppData.m_wstatus[num]
        seatnum = num
        performSegueWithIdentifier("SetSegue", sender: sender)
        NSLog("%d番のボタンがタップされました。", num+1)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! SelectNameViewController
        vc.manmode = self.manmode
        vc.vc = self
        vc.seatnum = self.seatnum
    }

}
