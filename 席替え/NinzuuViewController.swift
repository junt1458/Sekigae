//
//  NinzuuViewController.swift
//  席替え
//  Description:
//    人数を設定する
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class NinzuuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var man = 20
    var woman = 20
    
    @IBOutlet var manPicker: UIPickerView!
    @IBOutlet var womanPicker: UIPickerView!
    @IBOutlet var ninzuuLabel: UILabel!
    
    @IBOutlet var NextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.setTitleColor(UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0), forState: .Disabled)  //次へボタンの色の設定
        manPicker.dataSource = self
        womanPicker.dataSource = self
        manPicker.delegate = self
        womanPicker.delegate = self
        manPicker.selectRow(20, inComponent: 0, animated: false)
        womanPicker.selectRow(20, inComponent: 0, animated: false)
        ninzuuLabel.text = "合計: 40人"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 49
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 9999 {
            //男の人数を変更
            man = row
            woman = womanPicker.selectedRowInComponent(0)
        } else if pickerView.tag == 8888 {
            //女の人数を変更
            man = manPicker.selectedRowInComponent(0)
            woman = row
        }
        ninzuuLabel.text = String(format: "合計: %d人", man + woman)
    }
    
    //
    // 次へ
    //
    @IBAction func next(sender: AnyObject){
        var msg = ""
        var invalid = false
        if (man + woman) > AppData.CountLimit {
            invalid = true
            msg = String(format: "人数を%d人より多くすることはできません。", AppData.CountLimit)
        } else if (man + woman) <= 0 {
            invalid = true
            msg = "人数を0人以下にすることはできません。"
        } else if man < 0 || woman < 0 {
            invalid = true
            msg = "入力された値がおかしいです。"
        }
        if invalid {
            let alert = UIAlertController(title: "エラー", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("NextSegue", sender: sender)
        }
    }
    
    //
    // 前回のデータを読み込む
    //
    @IBAction func LoadBeforeData(sender: AnyObject){
        AppData.loadData()
        if (AppData.mancount + AppData.womancount) > AppData.CountLimit || (AppData.mancount + AppData.womancount) <= 0 {
            let msg = String(format: "読み込むデータがありませんでした。", AppData.CountLimit)
            let alert = UIAlertController(title: "エラー", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }else{
            man = AppData.mancount
            woman = AppData.womancount
            performSegueWithIdentifier("NextSegue", sender: sender)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let max = man + woman
        AppData.maxcount = max
        AppData.womancount = woman
        AppData.mancount = man
    }

    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
