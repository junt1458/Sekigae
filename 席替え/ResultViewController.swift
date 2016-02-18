//
//  ResultViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/13.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var btnlocations: [CGPoint]!
    var btnsize: [CGFloat]!
    var labels = [UILabel]()
    var imageviews = [UIImageView]()
    var vc: CheckViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("count:%d",btnlocations.count)
        for a in 0 ..< btnlocations.count {
            let i = btnlocations[a]
            NSLog("a:%d", a)
            let img :UIImageView = UIImageView(frame: CGRectMake(1, 1, btnsize[1], btnsize[0]))
            img.center = i
            img.image = UIImage(named: "desk.png")
            let label : UILabel = UILabel(frame: CGRectMake(1, 1, btnsize[1], btnsize[0]))
            label.center = CGPoint(x: btnsize[1] / 2, y: btnsize[0] / 2)
            label.text = "Label"
            label.font = UIFont.systemFontOfSize(18)
            label.textAlignment = NSTextAlignment.Center
            img.addSubview(label)
            self.view.addSubview(img)
            labels.append(label)
            imageviews.append(img)
        }
        tyuusen()
        for i in 0 ..< 8 {
            if isnotUsed(i) {
                deleteViews(i)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onemore(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
        vc.next(sender)
    }
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getArrayIndex(isMan: Bool, manData: [People_Information], womanData: [People_Information], data: People_Information) -> Int{
        if isMan {
            var index = -1
            for i in 0 ..< manData.count {
                if manData[i].AllNumber == data.AllNumber && manData[i].isMan == data.isMan && manData[i].Number == data.Number {
                    index = i
                    break;
                }
            }
            return index
        } else {
            var index = -1
            for i in 0 ..< womanData.count {
                if womanData[i].AllNumber == data.AllNumber && womanData[i].isMan == data.isMan && womanData[i].Number == data.Number {
                    index = i
                    break;
                }
            }
            return index
        }
    }
    
    func deleteViews(retsu: Int) {
        let num = retsu
        let a = (num / 8)
        let n = num - a * 8
        for i in 0 ..< 6 {
            imageviews[n + 8 * i].removeFromSuperview()
        }
    }
    
    //
    // 横一列使われてないかをチェックします。
    //
    func isnotUsed(retsu: Int) -> Bool{
        let num = retsu
        let a = (num / 8)
        let n = num - a * 8
        var notused = true
        for i in 0 ..< 6 {
            if AppData.sekistatus[n + 8 * i] {
                notused = false
                NSLog("%d列は使われています。", retsu)
                break;
            }
        }
        return notused
    }
    
    func tyuusen(){
        var manData = getData(true)
        var womanData = getData(false)
        for i in 0 ..< AppData.Seat_Data.count {
            if AppData.Seat_Data[i] != -1 {
                let data = AppData.People_Data[AppData.Seat_Data[i]]
                labels[i].text = AppData.People_Data[AppData.Seat_Data[i]].Name
                if AppData.m_wstatus[i] {
                    manData.removeAtIndex(getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }else{
                    womanData.removeAtIndex(getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }
            }
        }
        for i in 0 ..< labels.count {
            if AppData.sekistatus[i] {
                if AppData.Seat_Data[i] == -1 {
                    if AppData.m_wstatus[i] {
                        var index:Int = Int(arc4random_uniform(UInt32(manData.count)))
                        var dcount = 0
                        while dcount < 10 && AppData.Before_Data[i] == manData[index].AllNumber {
                            dcount++
                            index = Int(arc4random_uniform(UInt32(manData.count)))
                        }
                        let data = manData[index]
                        labels[i].text = data.Name
                        AppData.Seat_Data[i] = data.AllNumber
                        manData.removeAtIndex(index)
                    } else {
                        var index:Int = Int(arc4random_uniform(UInt32(womanData.count)))
                        var dcount = 0
                        while dcount < 10 && AppData.Before_Data[i] == womanData[index].AllNumber {
                            dcount++
                            index = Int(arc4random_uniform(UInt32(womanData.count)))
                        }
                        let data = womanData[index]
                        labels[i].text = data.Name
                        AppData.Seat_Data[i] = data.AllNumber
                        womanData.removeAtIndex(index)
                    }
                }
            } else {
                imageviews[i].removeFromSuperview()
                let img :UIImageView = UIImageView(frame: CGRectMake(1, 1, btnsize[1], btnsize[0]))
                img.center = btnlocations[i]
                img.image = UIImage(named: "nodesk.png")
                self.view.addSubview(img)
                imageviews[i] = img
            }
        }
    }
    
    func getData(manData: Bool) -> [People_Information] {
        var array = [People_Information]()
        for a in 0 ..< AppData.People_Data.count {
            let i = AppData.People_Data[a]
            if manData {
                if i.isMan! {
                    array.append(i)
                }
            } else {
                if !i.isMan {
                    array.append(i)
                }
            }
        }
        return array
    }
    
    @IBAction func close(sender: AnyObject){
        let alert = UIAlertController(title: "終了", message: "終了しますか？", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {action in
            let alert2 = UIAlertController(title: "確認", message: "今回のデータを保存しますか？", preferredStyle: .Alert)
            alert2.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {action in
                AppData.saveData()
                let alert3 = UIAlertController(title: "完了", message: "保存しました", preferredStyle: .Alert)
                alert3.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                    self.performSegueWithIdentifier("FirstSegue", sender: sender)
                    AppData.formatTempData()
                }))
                self.presentViewController(alert3, animated: true, completion: nil)
            }))
            alert2.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler: {action in
                let alert3 = UIAlertController(title: "注意", message: "今回のデータは保存されません。\n本当に終了してもよろしいですか？", preferredStyle: .Alert)
                alert3.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {action in
                    self.performSegueWithIdentifier("FirstSegue", sender: sender)
                    AppData.formatTempData()
                }))
                alert3.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert3, animated: true, completion: nil)
            }))
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        
        //FirstSegue
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
