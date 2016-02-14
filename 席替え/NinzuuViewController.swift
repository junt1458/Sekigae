//
//  NinzuuViewController.swift
//  席替え
//
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
        // Do any additional setup after loading the view.
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
            notification.addObserver(self, selector: "keyboardWillShow:"
                , name: UIKeyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector: "keyboardWillHide:"
                , name: UIKeyboardWillHideNotification, object: nil)
            isObserving = true
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if(isObserving) {
            let notification = NSNotificationCenter.defaultCenter()
            notification.removeObserver(self)
            notification.removeObserver(self
                , name: UIKeyboardWillShowNotification, object: nil)
            notification.removeObserver(self
                , name: UIKeyboardWillHideNotification, object: nil)
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
    
    @IBAction func next(sender: AnyObject){
        var msg = ""
        var invalid = false
        if manField.text == "" || womanField.text == "" {
            invalid = true
            msg = "人数を入力してください。"
        } else {
            man = Int(manField.text!)!
            woman = Int(womanField.text!)!
            if (man + woman) > 48 {
                invalid = true
                msg = "人数を48人より多くすることはできません。"
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! SekiHaitiViewController
        let max = man + woman
        vc.maxcount = max
        vc.womancount = woman
        vc.mancount = man
    }

    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
