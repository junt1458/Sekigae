//
//  ResultViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/13.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var imgview: UIImageView!  //背景のImageView
    
    @IBOutlet var ib1: UIImageView!      //席のImageView+Labelの背景のImageView1
    @IBOutlet var ib2: UIImageView!      //席のImageView+Labelの背景のImageView2
    @IBOutlet var ib3: UIImageView!      //席のImageView+Labelの背景のImageView3
    
    var setcolor: Bool!                        //色を変えるかどうか
    var btnlocations: [CGPoint]!               //ボタンの場所の配列
    var btnsize: [CGFloat]!                    //ボタンのサイズの配列
    var labels = [UILabel]()                   //ImageViewの上にあるLabelの配列
    var imageviews = [UIImageView]()           //ImageViewの配列
    var vc: CheckViewController!               //もう一度ボタン用の前のViewContoller
    var backdata = [Int]()                     //戻るときの固定データ
    var backsdata = [People_Information]()     //戻るときの人のデータ
    var backbdata = [Int]()                    //戻るときの前回のデータ
    var ar: CGRect!                            //座標記録用
    
    var img1: UIImage!        //保存用の画像1
    var img2: UIImage!        //保存用の画像2
    
    //
    // 文字の大きさの配列の位置を取得する関数
    //
    func getIndex(lng: Int) -> Int {
        var ind: Int = lng - 5
        if lng >= 7 {
            ind -= 1
        }
        if ind < 0 {
            ind = 5
        }
        if lng > 9 {
            ind = 4
        }
        return ind
    }
    
    //
    // 文字の大きさの配列を取得する関数
    //
    func getSizeArray() -> [Float] {
        if AppData.usesize1 {
            return AppData.size1
        } else {
            return AppData.size2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // 戻るとき用のデータの保存
        //
        backdata = AppData.Seat_Data
        backsdata = AppData.People_Data
        backbdata = AppData.Before_Data
        
        //
        // ImageViewとLabelの準備
        //
        for a in 0 ..< btnlocations.count {
            let i = btnlocations[a]
            let img :UIImageView = UIImageView(frame: CGRectMake(1, 1, btnsize[1], btnsize[0]))
            img.center = i
            img.image = UIImage(named: "desk.png")
            if setcolor! && AppData.sekistatus[a] {
                if AppData.m_wstatus[a] {
                    img.image = UIImage(named: "man.png")
                } else {
                    img.image = UIImage(named: "woman.png")
                }
            }
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
        
        //
        // 前回のデータの数がおかしい場合は前回のデータを読み込み直す
        //
        if AppData.Before_Data.count != AppData.CountLimit {
            AppData.loadBefore()
        }
        
        tyuusen()                   //抽選
        rotateLabels()              //回転がONの場合Labelを回転させる
        ib1.frame = getBackSize1()  //ImageView+Labelの背景の場所を設定1
        ib2.frame = getBackSize2()  //ImageView+Labelの背景の場所を設定2
        ib3.frame = getBackSize3()  //ImageView+Labelの背景の場所を設定3
        delviews()                  //横１列使われてない場所はViewを削除する
        let img = imgview.image!    //背景の画像を一時的に保存する
        imgview.image = nil         //撮影用に背景を削除する
        TakePhoto()                 //席の写真を撮影する
        imgview.image = img         //背景の画像を戻す
        // Do any additional setup after loading the view.
    }
    
    //
    // 設定によってLabelを回転させる関数
    //
    func rotateLabels(){
        var kakudo: CGFloat!
        if AppData.rotateLabel {
            kakudo = CGFloat((180/180.0) * M_PI)
        } else {
            kakudo = 0.0
        }
        for l in labels {
            l.transform = CGAffineTransformMakeRotation(kakudo)
        }
    }
    
    //
    // １列使われてない場所を消す関数
    //
    func delviews(){
        for i in 0 ..< 8 {
            if isnotUsed(i) {
                deleteViews(i)
            }
        }
    }
    
    //
    // ImageView+Labelの背景の場所を取得する関数 1
    //
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
        let hidariue = CGPointMake(
            CGFloat(Int(imageviews[minretsu + 8 * 5].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)),
            CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))  //左上の座標
        let migishita = CGPointMake(
            CGFloat(Int(imageviews[maxretsu + 8 * 4].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)),
            CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))  //右下の座標
        
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    //
    // ImageView+Labelの背景の場所を取得する関数 2
    //
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
        let hidariue = CGPointMake(
            CGFloat(Int(imageviews[minretsu + 8 * 3].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)),
            CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))   //左上の座標
        let migishita = CGPointMake(
            CGFloat(Int(imageviews[maxretsu + 8 * 2].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)),
            CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))   //右下の座標
        
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    //
    // ImageView+Labelの背景の場所を取得する関数 3
    //
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
        let hidariue = CGPointMake(
            CGFloat(Int(imageviews[minretsu + 8 * 1].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2)),
            CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2)))   //左上の座標
        let migishita = CGPointMake(
            CGFloat(Int(imageviews[maxretsu + 8 * 0].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2)),
            CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2)))   //右下の座標
        
        return CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y + 1)
    }
    
    //
    // 保存用の写真を撮る関数
    //
    func TakePhoto(){
        for i in 0 ..< 8 {
            if !isnotUsed(i) {
                let num = i                          //列の番号
                let a = (num / 8)                    //したの掛け算用の定数
                let n = num - a * 8                  //したの取得用の定数
                let im1 = imageviews[n + 8 * 0]      //間隔取得用のImageView1
                let im2 = imageviews[n + 8 * 1]      //間隔取得用のImageView2
                let kankaku = Int(im1.frame.midX - im2.frame.midX - im1.frame.width)  //間隔(１つ目の真ん中の座標) - (2つ目の真ん中の座標) - (Viewの横幅)
                var minretsu = 99  //最前列
                var maxretsu = 0   //最後列
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
                
                let hidariue = CGPointMake(
                    CGFloat(Int(imageviews[minretsu + 8 * 5].center.x) - Int(imageviews[minretsu + 8 * 5].frame.width / 2) - kankaku),
                    CGFloat(Int(imageviews[minretsu + 8 * 5].center.y) - Int(imageviews[minretsu + 8 * 5].frame.height / 2) - kankaku))   //左上の座標
                let migishita = CGPointMake(
                    CGFloat(Int(imageviews[maxretsu + 8 * 0].center.x) + Int(imageviews[maxretsu + 8 * 0].frame.width / 2) + kankaku),
                    CGFloat(Int(imageviews[maxretsu + 8 * 0].center.y) + Int(imageviews[maxretsu + 8 * 0].frame.height / 2) + kankaku))   //右下の座標
                let ab = CGPointMake(
                    CGFloat(Int(imageviews[7 + 8 * 0].center.x) + Int(imageviews[7 + 8 * 0].frame.width / 2) + kankaku),
                    CGFloat(Int(imageviews[7 + 8 * 0].center.y) + Int(imageviews[7 + 8 * 0].frame.height / 2) + kankaku))      //結果画面と同じの撮影用の座標

                //ar = CGRectMake(hidariue.x, hidariue.y, migishita.x - hidariue.x, migishita.y - hidariue.y)      //中央に寄せるや引き伸ばすの撮影用の座標
                
                //
                // 写真の撮影
                //
                UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.mainScreen().scale * 3)
                self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
                let img = UIGraphicsGetImageFromCurrentImageContext()! as UIImage               //画面全体のスクリーンショット
                UIGraphicsEndImageContext()
                let origRef    = img.CGImage;                          //画像のCGImage
                let origWidth  = Int(CGImageGetWidth(origRef))         //画像の横の幅
                let origHeight = Int(CGImageGetHeight(origRef))        //画像の縦の幅
                let hiritu1 = Int(origWidth / Int(self.view.frame.width))    //画像の横とViewの横の比率
                let hiritu2 = Int(origHeight / Int(self.view.frame.height))  //画像の縦とViewの縦の比率
                
                let a1 : CGFloat = CGFloat(Int(hidariue.x) * hiritu1)       //画像の左のX座標
                let a2 : CGFloat = CGFloat(Int(hidariue.y) * hiritu2 + 1)   //画像の左のY座標
                let a3 : CGFloat = CGFloat(Int(Int(migishita.x) * hiritu1) - Int(Int(hidariue.x) * hiritu1))       //画像の右のX座標(引き伸ばす、中央に寄せる用)
                let a4 : CGFloat = CGFloat(Int(Int(migishita.y) * hiritu2) - Int(Int(hidariue.y) * hiritu2) + 1)   //画像の右のY座標(引き伸ばす、中央に寄せる用)
                
                let a33 : CGFloat = CGFloat(Int(Int(ab.x) * hiritu1) - Int(Int(hidariue.x) * hiritu1))      //画像の右のX座標(結果画面と同じ用)
                let a44 : CGFloat = CGFloat(Int(Int(ab.y) * hiritu2) - Int(Int(hidariue.y) * hiritu2) + 1)  //画像の右のY座標(結果画面と同じ用)
                
                let ar2 = CGRectMake(a1, a2, a33, a44)  //結果画面と同じの画像用の座標
                ar = CGRectMake(a1, a2, a3, a4)         //中央に寄せるや引き伸ばすの画像用の座標
                var imageRef = CGImageCreateWithImageInRect(img.CGImage, ar)  //中央、引き伸ばしのCGImage
                let cropImage = UIImage(CGImage: imageRef!)                   //中央、引き伸ばしのUIImage
                img1 = cropImage
                imageRef = CGImageCreateWithImageInRect(img.CGImage, ar2)  //結果と同じのCGImage
                let cropImage2 = UIImage(CGImage: imageRef!)               //結果と同じのUIImage
                img2 = cropImage2
                break;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // もう一度ボタン
    //
    @IBAction func onemore(sender: AnyObject){
        AppData.People_Data = backsdata
        AppData.Seat_Data = backdata
        AppData.Before_Data = backbdata
        self.dismissViewControllerAnimated(true, completion: nil)
        vc.next(sender)
    }
    
    //
    // 戻るボタン
    //
    @IBAction func back(){
        AppData.People_Data = backsdata
        AppData.Seat_Data = backdata
        AppData.Before_Data = backbdata
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    // 人のデータの配列の位置を取得する関数です。
    //
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
    
    //
    // 1列削除します。
    //
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
                break;
            }
        }
        return notused
    }
    
    //
    // 抽選する関数です。
    //
    func tyuusen(){
        var manData = getData(true)
        var womanData = getData(false)
        
        //
        // 固定されている人をリストから削除し、席に配置します
        //
        for i in 0 ..< AppData.Seat_Data.count {
            if AppData.Seat_Data[i] != -1 {
                let data = AppData.People_Data[AppData.Seat_Data[i]]
                labels[i].text = AppData.People_Data[AppData.Seat_Data[i]].Name
                let lng:Int = Int(String(labels[i].text!.endIndex))!
                labels[i].font = UIFont.systemFontOfSize(CGFloat(getSizeArray()[getIndex(lng)]))
                if AppData.m_wstatus[i] {
                    manData.removeAtIndex(getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }else{
                    womanData.removeAtIndex(getArrayIndex(AppData.m_wstatus[i], manData: manData, womanData: womanData, data: data))
                }
            }
        }
        
        //
        // 固定されていない席を抽選します。
        //
        for i in 0 ..< labels.count {
            if AppData.sekistatus[i] {
                if AppData.Seat_Data[i] == -1 {
                    if AppData.m_wstatus[i] {
                        var index:Int = Int(arc4random_uniform(UInt32(manData.count)))
                        var dcount = 0
                        while dcount < 10 && AppData.Before_Data[i] == manData[index].AllNumber {
                            //
                            // 前回の席と同じだったら１０回まで抽選しなおします。
                            //
                            dcount += 1
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
                            //
                            // 前回の席と同じだったら１０回まで抽選しなおします。
                            //
                            dcount += 1
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
    
    //
    // 男女別のデータを取得する関数
    //
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

    //
    // 閉じるボタン
    //
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let v = segue.destinationViewController as? SavePhotoViewController {
            v.img = img1
            v.img2 = img2
        }
    }
    
}
