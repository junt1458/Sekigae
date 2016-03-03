//
//  CheckViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/10.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {

    var btnlocations: [CGPoint]!
    var btnsize: [CGFloat]!
    
    func CheckandCreateData(){
        var flag = false
        if AppData.People_Data.count <= 0 {
            flag = true
        } else {
            flag = false
        }
        if flag {
            AppData.People_Data = [People_Information]()
            for i in 0 ..< AppData.mancount + AppData.womancount {
                if DebugSet.debug {
                    var isMan = true
                    if i > AppData.mancount {
                        isMan = false
                    }
                    let pi = People_Information(isMan: isMan, SeatNumber: -1, Name: getName(i + 1), Number: i + 1, AllNumber: i)
                    AppData.People_Data.append(pi)
                } else {
                    if i < AppData.mancount {
                        let pi = People_Information(isMan: true, SeatNumber: -1, Name: String(format: "%d番", i + 1), Number: i + 1, AllNumber: i)
                        AppData.People_Data.append(pi)
                        NSLog("男,%d", i + 1)
                    }else{
                        let pi = People_Information(isMan: false, SeatNumber: -1, Name: String(format: "%d番", i + 1 - AppData.mancount), Number: i + 1 - AppData.mancount, AllNumber: i)
                        AppData.People_Data.append(pi)
                        NSLog("女,%d", i - AppData.mancount + 1)
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
        if AppData.Seat_Data.count <= 0 {
            flag = true
        } else {
            flag = false
        }
        if flag {
            AppData.Seat_Data = [Int]()
            for _ in 0 ..< 48 {
                AppData.Seat_Data.append(-1)
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
        if let vc = segue.destinationViewController as? ResultViewController {
            vc.vc = self
            vc.btnlocations = self.btnlocations
            vc.btnsize = self.btnsize
        }
    }
}
