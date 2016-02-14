//
//  CheckViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/10.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {

    var sekistatus = [Bool]()
    var m_wstatus = [Bool]()
    var maxcount : Int = 0
    var mancount : Int = 0
    var womancount: Int = 0
    var btnlocations: [CGPoint]!
    var btnsize: [CGFloat]!
    var People_Data : [People_Information]!
    var Seat_Data : [Int]!
    
    func CheckandCreateData(){
        var flag = false
        if People_Data == nil {
            flag = true
        } else if People_Data.count <= 0 {
            flag = true
        } else {
            flag = false
        }
        if flag {
            People_Data = [People_Information]()
            for i in 0 ..< mancount + womancount {
                if DebugSet.debug {
                    var isMan = true
                    if i > mancount {
                        isMan = false
                    }
                    let pi = People_Information(isMan: isMan, isSetSeat: false, SeatNumber: -1, Name: getName(i + 1), Number: i + 1, AllNumber: i)
                    People_Data.append(pi)
                } else {
                    if i < mancount {
                        let pi = People_Information(isMan: true, isSetSeat: false, SeatNumber: -1, Name: String(format: "%d番", i + 1), Number: i + 1, AllNumber: i)
                        People_Data.append(pi)
                        NSLog("男,%d", i + 1)
                    }else{
                        let pi = People_Information(isMan: false, isSetSeat: false, SeatNumber: -1, Name: String(format: "%d番", i + 1 - mancount), Number: i + 1 - mancount, AllNumber: i)
                        People_Data.append(pi)
                        NSLog("女,%d", i - mancount + 1)
                    }
                }
            }
        }
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getName(count: Int) -> String {
        var str = ""
        for _ in 0 ..< count {
            str = str + "阿"
        }
        return str
    }
    
    @IBAction func next(sender: AnyObject){
        performSegueWithIdentifier("ResSegue", sender: sender)
    }
    
    func CheckandCreateData2(){
        var flag = false
        if Seat_Data == nil {
            flag = true
        } else if Seat_Data.count <= 0 {
            flag = true
        } else {
            flag = false
        }
        if flag {
            Seat_Data = [Int]()
            for _ in 0 ..< 48 {
                Seat_Data.append(-1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckandCreateData()
        CheckandCreateData2()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? SetNameViewController {
            vc.mancount = self.mancount
            vc.womancount = self.womancount
            vc.People_Data = self.People_Data
            vc.vc = self
        } else if let vc = segue.destinationViewController as? SeatSetViewController {
            vc.sekistatus = self.sekistatus
            vc.m_wstatus = self.m_wstatus
            vc.People_Data = self.People_Data
            vc.Seat_Data = self.Seat_Data
            vc.mancount = self.mancount
            vc.womancount = self.womancount
            vc.vc = self
        } else if let vc = segue.destinationViewController as? ResultViewController {
            vc.btnsize = self.btnsize
            vc.btnlocations = self.btnlocations
            vc.sekistatus = self.sekistatus
            vc.Seat_Data = self.Seat_Data
            vc.m_wstatus = self.m_wstatus
            vc.People_Data = self.People_Data
            vc.vc = self
        }
    }
}
