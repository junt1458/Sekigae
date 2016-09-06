//
//  SelectNameViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/13.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SelectNameViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var manmode: Bool!   //男の設定か
    var vc: SeatSetViewController!   //前のViewControllerの
    var seatnum: Int!  //席番号
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //
    // 男女別の人数を取得する関数
    //
    func getCount(man: Bool) -> Int{
        var count = 0
        if man {
            count = AppData.mancount
        } else {
            count = AppData.womancount
        }
        return count
    }
    //
    // 固定を解除するボタン
    //
    @IBAction func deset(){
        if AppData.Seat_Data[seatnum] != -1 {
            AppData.People_Data[AppData.Seat_Data[seatnum]].SeatNumber = -1
            AppData.Seat_Data[seatnum] = -1
        }
        vc.redrawbtns()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if manmode! {
            if AppData.People_Data[indexPath.row].SeatNumber != -1 {
                AppData.Seat_Data[AppData.People_Data[indexPath.row].SeatNumber] = -1
                AppData.People_Data[indexPath.row].SeatNumber = -1
            }
            if AppData.Seat_Data[seatnum] != -1 {
                AppData.People_Data[indexPath.row].SeatNumber = -1
            }
            AppData.Seat_Data[seatnum] = AppData.People_Data[indexPath.row].AllNumber
            AppData.People_Data[indexPath.row].SeatNumber = seatnum
        } else {
            if AppData.People_Data[indexPath.row + getCount(true)].SeatNumber != -1 {
                AppData.Seat_Data[AppData.People_Data[indexPath.row + getCount(true)].SeatNumber] = -1
                AppData.People_Data[indexPath.row + getCount(true)].SeatNumber = -1
            }
            if AppData.Seat_Data[seatnum] != -1 {
                AppData.People_Data[indexPath.row + getCount(true)].SeatNumber = -1
            }
            AppData.Seat_Data[seatnum] = AppData.People_Data[indexPath.row + getCount(true)].AllNumber
            AppData.People_Data[indexPath.row + getCount(true)].SeatNumber = seatnum
        }
        vc.redrawbtns()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if manmode! {
            return getCount(true)
        } else {
            return getCount(false)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        if manmode! {
            cell.textLabel?.text = String(format: "No.%d," + AppData.People_Data[indexPath.row].Name, AppData.People_Data[indexPath.row].Number)
        } else {
            cell.textLabel?.text = String(format: "No.%d," + AppData.People_Data[indexPath.row + getCount(true)].Name, AppData.People_Data[indexPath.row + getCount(true)].Number)
        }
        return cell
    }
    
}
