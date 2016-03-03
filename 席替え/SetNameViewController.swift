//
//  SetNameViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/09.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SetNameViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    var selectedIndex: Int!
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var nameBox: UITextField!
    @IBOutlet var seibetulabel: UILabel!
    @IBOutlet var numlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckandCreateData()
        tableview.dataSource = self
        tableview.delegate = self
        nameBox.delegate = self
        // Do any additional setup after loading the view.
    }
    
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

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        save(true)
        return true
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkbox(checked: Int){
        for row in 0 ..< AppData.People_Data.count {
            let indexPath = NSIndexPath(forRow: row, inSection: 0)
            let cell = tableview.cellForRowAtIndexPath(indexPath)
            if row == checked {
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell?.accessoryType = UITableViewCellAccessoryType.None
            }
        }
    }
    
    func save(goNext: Bool){
        if selectedIndex != nil {
            AppData.People_Data[selectedIndex].Name = nameBox.text
            tableview.reloadData()
            if goNext && AppData.mancount + AppData.womancount >= selectedIndex + 2 {
                selectedIndex = selectedIndex + 1
                let pi = AppData.People_Data[selectedIndex]
                var seibetu = "女"
                if pi.isMan! {
                    seibetu = "男"
                }
                nameBox.text = pi.Name
                seibetulabel.text = seibetu
                numlabel.text = String(format: "%d番", pi.Number)
                checkbox(selectedIndex)
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if selectedIndex != nil {
            checkbox(selectedIndex)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pi = AppData.People_Data[indexPath.row]
        var seibetu = "女"
        if pi.isMan! {
            seibetu = "男"
        }
        nameBox.text = pi.Name
        seibetulabel.text = seibetu
        numlabel.text = String(format: "%d番", pi.Number)
        checkbox(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedIndex = indexPath.row
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.People_Data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        var seibetu = "女"
        if AppData.People_Data[indexPath.row].isMan! {
            seibetu = "男"
        }
        cell.textLabel?.text = String(format: "No.%d," + AppData.People_Data[indexPath.row].Name + "," + seibetu, AppData.People_Data[indexPath.row].Number)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
