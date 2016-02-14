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
    var sekistatus: [Bool]!
    var m_wstatus: [Bool]!
    var People_Data: [People_Information]!
    var Seat_Data: [Int]!
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
            if sekistatus[n + 8 * i] {
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
        for i in 0 ..< Seat_Data.count {
            if Seat_Data[i] != -1 {
                let data = People_Data[Seat_Data[i]]
                labels[i].text = People_Data[Seat_Data[i]].Name
                if m_wstatus[i] {
                    manData.removeAtIndex(getArrayIndex(m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }else{
                    womanData.removeAtIndex(getArrayIndex(m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }
            }
        }
        for i in 0 ..< labels.count {
            if sekistatus[i] {
                if Seat_Data[i] == -1 {
                    if m_wstatus[i] {
                        let index:Int = Int(arc4random_uniform(UInt32(manData.count)))
                        let data = manData[index]
                        labels[i].text = data.Name
                        manData.removeAtIndex(index)
                    } else {
                        let index:Int = Int(arc4random_uniform(UInt32(womanData.count)))
                        let data = womanData[index]
                        labels[i].text = data.Name
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
        /*for i in 0 ..< labels.count {
        if sekistatus[i] {
        if Seat_Data[i] != -1 {
        labels[i].text = People_Data[Seat_Data[i]].Name
        if m_wstatus[i] {
        manData.removeAtIndex(getArrayIndex(m_wstatus[i], manData: manData, womanData: womanData, data: People_Data[Seat_Data[i]]))
        } else {
        womanData.removeAtIndex(getArrayIndex(m_wstatus[i], manData: manData, womanData: womanData, data: People_Data[Seat_Data[i]]))
        }
        } else {
        let array = getRandom(m_wstatus[i], manData: manData, womanData: womanData)
        let num = array[0] as! Int
        let data = array[1] as! People_Information
        labels[i].text = data.Name
        if data.isMan! {
        manData.removeAtIndex(num)
        } else {
        womanData.removeAtIndex(num)
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
        }*/
    }
    
    
    //
    //  データが入った配列を返します。
    //  配列の中身
    //    0: int型(ランダム生成された番号)
    //    1: People_Information(取得したデータ)
    //
    /* func getRandom(isMan: Bool, manData: [People_Information], womanData: [People_Information]) -> [AnyObject] {
    var array = [AnyObject]()
    if isMan {
    let index:Int = Int(arc4random_uniform(UInt32(manData.count)))
    if manData[index].SeatNumber == -1 {
    array.append(index)
    array.append(manData[index])
    return array
    } else {
    NSLog("席設定済みのユーザー")
    return getRandom(isMan, manData: manData, womanData: womanData)
    }
    } else {
    let index:Int = Int(arc4random_uniform(UInt32(womanData.count)))
    if womanData[index].SeatNumber == -1 {
    array.append(index)
    array.append(womanData[index])
    return array
    } else {
    NSLog("席設定済みのユーザー")
    return getRandom(isMan, manData: manData, womanData: womanData)
    }
    }
    }*/
    
    /*  func getRandom(isMan: Bool, manData: [People_Information], womanData: [People_Information]) -> People_Information {
    if isMan {
    let index = Int(arc4random_uniform(UInt32(manData.count)))
    if manData[index].SeatNumber == -1 {
    return manData[index]
    } else {
    return getRandom(isMan, manData: manData, womanData: womanData)
    }
    }
    return People_Information(isMan: false, isSetSeat: false, SeatNumber: -1, Name: "Nil", Number: -1, AllNumber: -1)
    }*/
    
    func getData(manData: Bool) -> [People_Information] {
        var array = [People_Information]()
        for a in 0 ..< People_Data.count {
            let i = People_Data[a]
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
