//
//  ResultViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/13.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var imgview: UIImageView!
    
    @IBOutlet var ib1: UIImageView!
    @IBOutlet var ib2: UIImageView!
    @IBOutlet var ib3: UIImageView!
    
    var btnlocations: [CGPoint]!
    var btnsize: [CGFloat]!
    var labels = [UILabel]()
    var imageviews = [UIImageView]()
    var vc: CheckViewController!
    var backdata = [Int]()
    var backsdata = [People_Information]()
    //var hidariue: CGPoint!
    //var migishita: CGPoint!
    var ar: CGRect!
    
    var img1: UIImage!
    var img2: UIImage!
    
    func getIndex(lng: Int) -> Int {
        var ind: Int = lng - 5
        if lng >= 7 {
            ind--
        }
        if ind < 0 {
            ind = 5
        }
        if lng > 9 {
            ind = 4
        }
        return ind
    }
    
    func getSizeArray() -> [Float] {
        if AppData.usesize1 {
            return AppData.size1
        } else {
            return AppData.size2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backdata = AppData.Seat_Data
        backsdata = AppData.People_Data
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
        if AppData.Before_Data.count != AppData.CountLimit {
            AppData.loadBefore()
        }
        tyuusen()
        ib1.frame = getBackSize1()
        ib2.frame = getBackSize2()
        ib3.frame = getBackSize3()
        delviews()
        let img = imgview.image!
        imgview.image = nil
        getArea()
        imgview.image = img
        // Do any additional setup after loading the view.
    }
    
    func delviews(){
        for i in 0 ..< 8 {
            if isnotUsed(i) {
                deleteViews(i)
            }
        }
    }
    
    func getBackSize1() -> CGRect {
        var minretsu = 99
        var maxretsu = 0
        for a in 0 ..< 8 {
            if !isnotUsed(a) {
                if minretsu > a {
                    minretsu = a
                }
                if maxretsu < a {
                    maxretsu = a
                }
            }
        }
        let hidariue = CGPointMake(CGFloat(Int(imageviews[minretsu + 8 * 5].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)), CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))
        let migishita = CGPointMake(CGFloat(Int(imageviews[maxretsu + 8 * 4].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)), CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    func getBackSize2() -> CGRect {
        var minretsu = 99
        var maxretsu = 0
        for a in 0 ..< 8 {
            if !isnotUsed(a) {
                if minretsu > a {
                    minretsu = a
                }
                if maxretsu < a {
                    maxretsu = a
                }
            }
        }
        let hidariue = CGPointMake(CGFloat(Int(imageviews[minretsu + 8 * 3].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)), CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))
        let migishita = CGPointMake(CGFloat(Int(imageviews[maxretsu + 8 * 2].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)), CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    func getBackSize3() -> CGRect {
        var minretsu = 99
        var maxretsu = 0
        for a in 0 ..< 8 {
            if !isnotUsed(a) {
                if minretsu > a {
                    minretsu = a
                }
                if maxretsu < a {
                    maxretsu = a
                }
            }
        }
        let hidariue = CGPointMake(CGFloat(Int(imageviews[minretsu + 8 * 1].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)), CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))
        let migishita = CGPointMake(CGFloat(Int(imageviews[maxretsu + 8 * 0].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)), CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    func getArea(){
        for i in 0 ..< 8 {
            if !isnotUsed(i) {
                let num = i
                let a = (num / 8)
                let n = num - a * 8
                let im1 = imageviews[n + 8 * 0]
                let im2 = imageviews[n + 8 * 1]
                let kankaku = Int(im1.frame.midX - im2.frame.midX - im1.frame.width)
                NSLog("間隔: %d", kankaku)
                var minretsu = 99
                var maxretsu = 0
                for a in 0 ..< 8 {
                    if !isnotUsed(a) {
                        if minretsu > a {
                            minretsu = a
                        }
                        if maxretsu < a {
                            maxretsu = a
                        }
                    }
                }
                let hidariue = CGPointMake(CGFloat(Int(imageviews[minretsu + 8 * 5].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2) - kankaku), CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2) - kankaku))
                let migishita = CGPointMake(CGFloat(Int(imageviews[maxretsu + 8 * 0].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2) + kankaku), CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2) + kankaku))
                
                let ab        = CGPointMake(CGFloat(Int(imageviews[7        + 8 * 0].center.x) + Int(imageviews[7        + 8 * 0].frame.width / 2) + kankaku), CGFloat(Int(imageviews[7        + 8 * 0].center.y) + Int(imageviews[7        + 8 * 0].frame.height / 2) + kankaku))
                NSLog("最後尾の列: %d, 最前列: %d", maxretsu, minretsu)
                NSLog("左上 X: %d, Y:%d, 右下 X: %d, Y: %d", Int(hidariue.x), Int(hidariue.y), Int(migishita.x), Int(migishita.y))
                ar = CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y)
                NSLog("minX: %d, minY:%d, maxX:%d, maxY:%d", Int(ar.minX), Int(ar.minY), Int(ar.maxX), Int(ar.maxY))
                UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.mainScreen().scale * 3)
                self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
                let img = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
                UIGraphicsEndImageContext()
                let origRef    = img.CGImage;
                let origWidth  = Int(CGImageGetWidth(origRef))
                let origHeight = Int(CGImageGetHeight(origRef))
                NSLog("Screen Height: %d, Screen Width: %d, Img Height: %d, Img Width: %d, ih/sh=%d, iw/sw=%d", Int(self.view.frame.height), Int(self.view.frame.width), origHeight, origWidth, origHeight / Int(self.view.frame.height), origWidth / Int(self.view.frame.width))
                let hiritu1 = Int(origWidth / Int(self.view.frame.width))
                let hiritu2 = Int(origHeight / Int(self.view.frame.height))
                //ar = CGRectMake(CGFloat(Int(hidariue.x) * hiritu1), CGFloat(Int(hidariue.y) * hiritu2), CGFloat(Int(migishita.x) - Int(hidariue.x) * hiritu1), CGFloat(Int(migishita.y) - Int(hidariue.y) * hiritu2))
                let a1 : CGFloat = CGFloat(Int(hidariue.x) * hiritu1)
                let a2 : CGFloat = CGFloat(Int(hidariue.y) * hiritu2 + 1)
                let a3 : CGFloat = CGFloat(Int(Int(migishita.x) * hiritu1) - Int(Int(hidariue.x) * hiritu1))
                let a4 : CGFloat = CGFloat(Int(Int(migishita.y) * hiritu2) - Int(Int(hidariue.y) * hiritu2) + 1)
                
                let a11 : CGFloat = CGFloat(Int(hidariue.x) * hiritu1)
                let a22 : CGFloat = CGFloat(Int(hidariue.y) * hiritu2 + 1)
                let a33 : CGFloat = CGFloat(Int(Int(ab.x) * hiritu1) - Int(Int(hidariue.x) * hiritu1))
                let a44 : CGFloat = CGFloat(Int(Int(ab.y) * hiritu2) - Int(Int(hidariue.y) * hiritu2) + 1)
                let ar2 = CGRectMake(a11, a22, a33, a44)
                
                ar = CGRectMake(a1, a2, a3, a4)
                var imageRef = CGImageCreateWithImageInRect(img.CGImage, ar)
                let cropImage = UIImage(CGImage: imageRef!)
                NSLog("minX: %d, minY:%d, maxX:%d, maxY:%d", Int(ar.minX), Int(ar.minY), Int(ar.maxX), Int(ar.maxY))
                NSLog("a1: %d, a2:%d, a3:%d, a4:%d", Int(a1), Int(a2), Int(a3), Int(a4))
                //UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
               //UIImageWriteToSavedPhotosAlbum(cropImage, nil, nil, nil)
               //s UIGraphicsBeginImageContext(ar.size)
               // self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
               // let img = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
              //  UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                img1 = cropImage
                
                UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.mainScreen().scale * 3)
                self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
                //let imm2 = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
                UIGraphicsEndImageContext()
                imageRef = CGImageCreateWithImageInRect(img.CGImage, ar2)
                NSLog("test")
                NSLog("minX: %d, minY:%d, maxX:%d, maxY:%d", Int(ar2.minX), Int(ar2.minY), Int(ar2.maxX), Int(ar2.maxY))
                NSLog("a1: %d, a2:%d, a3:%d, a4:%d", Int(a11), Int(a22), Int(a33), Int(a44))
                let cropImage2 = UIImage(CGImage: imageRef!)
                img2 = cropImage2
                break;
            }
        }
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
        AppData.People_Data = backsdata
        AppData.Seat_Data = backdata
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
        for i in 0 ..< manData.count {
            NSLog("manData[%d].Name: %@", i, manData[i].Name)
        }
        var womanData = getData(false)
        for i in 0 ..< womanData.count {
            NSLog("womanData[%d].Name: %@", i, womanData[i].Name)
        }

        for i in 0 ..< AppData.Seat_Data.count {
            if AppData.Seat_Data[i] != -1 {
                let data = AppData.People_Data[AppData.Seat_Data[i]]
                labels[i].text = AppData.People_Data[AppData.Seat_Data[i]].Name
                let lng:Int = Int(String(labels[i].text!.endIndex))!
                labels[i].font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
                if AppData.m_wstatus[i] {
                    NSLog("manData.count: %d, getArrayIndex: %d", manData.count, getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                    manData.removeAtIndex(getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }else{
                    NSLog("womanData.count: %d, getArrayIndex: %d", womanData.count, getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
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
                        let lng:Int = Int(String(labels[i].text!.endIndex))!
                        labels[i].font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
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
                        let lng:Int = Int(String(labels[i].text!.endIndex))!
                        labels[i].font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let v = segue.destinationViewController as? SavePhotoViewController {
            v.img = img1
            v.img2 = img2
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    
}
