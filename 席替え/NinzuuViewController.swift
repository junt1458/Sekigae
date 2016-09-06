//
//  NinzuuViewController.swift
//  席替え
//  Description:
//    人数を設定する
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class NinzuuViewController: UIViewController {

    var man = 0
    var woman = 0
    
    var isObserving = false
    
    @IBOutlet var manField: UITextField!
    @IBOutlet var womanField: UITextField!
    
    @IBOutlet var NextBtn: UIButton!
    @IBOutlet var DoneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.setTitleColor(UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0), forState: .Disabled)  //次へボタンの色の設定
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
      //  self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(!isObserving) {
            let notification = NSNotificationCenter.defaultCenter()
            notification.addObserver(self, selector: #selector(NinzuuViewController.keyboardWillShow(_:))
                , name: UIKeyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector: #selector(NinzuuViewController.keyboardWillHide(_:))
                , name: UIKeyboardWillHideNotification, object: nil)
            isObserving = true
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if(isObserving) {
            let notification = NSNotificationCenter.defaultCenter()
            notification.removeObserver(self)
            notification.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
            notification.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
            isObserving = false
        }
    }
    
    func keyboardWillShow(notification: NSNotification?) {
        DoneBtn.enabled = true
        DoneBtn.hidden = false
    }
    func keyboardWillHide(notification: NSNotification?) {
        DoneBtn.enabled = false
        DoneBtn.hidden = true
    }
    
    @IBAction func done(){
        manField.resignFirstResponder()
        womanField.resignFirstResponder()
        DoneBtn.enabled = false
        DoneBtn.hidden = true
    }
    
    //
    // 次へ
    //
    @IBAction func next(sender: AnyObject){
        var msg = ""
        var invalid = false
        if manField.text == "" || womanField.text == "" {
            invalid = true
            msg = "人数を入力してください。"
        } else {
            man = Int(manField.text!)!
            woman = Int(womanField.text!)!
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
