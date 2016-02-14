//
//  SelectNameViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/13.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SelectNameViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var People_Data = [People_Information]()
    var manmode: Bool!
    var mancount: Int!
    var womancount: Int!
    var vc: SeatSetViewController!
    var seatnum: Int!
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
    
    func getCount(man: Bool) -> Int{
        var count = 0
        if man {
            count = mancount
        } else {
            count = womancount
        }
        NSLog("count:%d", count)
        return count
    }
    
    @IBAction func deset(){
        if vc.Seat_Data[seatnum] != -1 {
            vc.People_Data[vc.Seat_Data[seatnum]].SeatNumber = -1
            vc.Seat_Data[seatnum] = -1
        }
        vc.redrawbtns()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if manmode! {
            NSLog("indexPath.row:%d", indexPath.row)
            if vc.People_Data[indexPath.row].SeatNumber != -1 {
                vc.Seat_Data[People_Data[indexPath.row].SeatNumber] = -1
                vc.People_Data[indexPath.row].SeatNumber = -1
            }
            if vc.Seat_Data[seatnum] != -1 {
                vc.People_Data[indexPath.row].SeatNumber = -1
            }
            vc.Seat_Data[seatnum] = People_Data[indexPath.row].AllNumber
            vc.People_Data[indexPath.row].SeatNumber = seatnum
        } else {
            if vc.People_Data[indexPath.row + getCount(true)].SeatNumber != -1 {
                vc.Seat_Data[People_Data[indexPath.row + getCount(true)].SeatNumber] = -1
                vc.People_Data[indexPath.row + getCount(true)].SeatNumber = -1
            }
            if vc.Seat_Data[seatnum] != -1 {
                vc.People_Data[indexPath.row + getCount(true)].SeatNumber = -1
            }
            vc.Seat_Data[seatnum] = People_Data[indexPath.row + getCount(true)].AllNumber
            vc.People_Data[indexPath.row + getCount(true)].SeatNumber = seatnum
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
            cell.textLabel?.text = String(format: "No.%d," + People_Data[indexPath.row].Name, People_Data[indexPath.row].Number)
        } else {
            NSLog("indexPath.row + getCount(true) - 2 = %d", indexPath.row + getCount(true))
            cell.textLabel?.text = String(format: "No.%d," + People_Data[indexPath.row + getCount(true)].Name, People_Data[indexPath.row + getCount(true)].Number)
        }
        return cell
    }
    
}
