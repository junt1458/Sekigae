//
//  ViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if DebugSet.autoLoad {
            AppData.loadData()
        }
        AppData.loadBefore()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetData(){
        let alert = UIAlertController(title: "確認", message: "保存されているデータを削除します。\nよろしいですか？", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {action in
            let alert2 = UIAlertController(title: "警告", message: "保存されているデータを削除します。\nよろしいですか？\n(※データを削除した場合復元はできません。)", preferredStyle: .Alert)
            alert2.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {action in
                AppData.formatData()
                let alert3 = UIAlertController(title: "完了", message: "削除しました。", preferredStyle: .Alert)
                alert3.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert3, animated: true, completion: nil)
            }))
            alert2.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

}

