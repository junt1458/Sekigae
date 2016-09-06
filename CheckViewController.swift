//
//  CheckViewController.swift
//  席替え
//  Description:
//    詳細設定の画面を制御するクラスです。
//
//  Created by Tomatsu Junki on 2016/02/10.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {

    var btnlocations: [CGPoint]!    //ボタンの場所
    var btnsize: [CGFloat]!         //ボタンのサイズ
    var setcolor: Bool = true       //色分けするか
    
    @IBOutlet var sw: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sw.on = AppData.rotateLabel
        CheckandCreateData()
        CheckandCreateData2()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // People_Dataが空だったら初期状態のリストを作成
    //
    func CheckandCreateData(){
        if AppData.People_Data.count != (AppData.mancount + AppData.womancount) {
            AppData.People_Data = [People_Information]()
        }
        if AppData.People_Data.count <= 0 {
            AppData.People_Data = [People_Information]()
            for i in 0 ..< AppData.mancount + AppData.womancount {
                if i < AppData.mancount {
                    let pi = People_Information(isMan: true, SeatNumber: -1, Name: String(format: "%d番", i + 1), Number: i + 1, AllNumber: i)
                    AppData.People_Data.append(pi)
                }else{
                    let pi = People_Information(isMan: false, SeatNumber: -1, Name: String(format: "%d番", i + 1 - AppData.mancount), Number: i + 1 - AppData.mancount, AllNumber: i)
                    AppData.People_Data.append(pi)
                }
            }
        }
    }
    
    func getCount(isMan: Bool) -> Int {
        var c = 0
        for pi in AppData.People_Data {
            if pi.isMan == isMan {
                c += 1
            }
        }
        return c
    }
    
    //
    // 色選択のスイッチ切り替え時に呼ばれる関数
    //
    @IBAction func switched(sender: UISwitch){
        setcolor = sender.on
    }
    
    
    
    //
    // 名前回転のスイッチ切り替え時に呼ばれる関数
    //
    @IBAction func switched2(sender: UISwitch){
        AppData.rotateLabel = sender.on
    }
    
    
    //
    // 戻るボタン
    //
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //
    // 抽選ボタン
    //
    @IBAction func next(sender: AnyObject){
        performSegueWithIdentifier("ResSegue", sender: sender)
    }
    
    
    
    //
    // 席固定データが空だったら初期状態のリストを作成
    //
    func CheckandCreateData2(){
        if AppData.Seat_Data.count <= 0 {
            AppData.Seat_Data = [Int]()
            for _ in 0 ..< 48 {
                AppData.Seat_Data.append(-1)
            }
        }
    }
    
    
    
    //
    // 画面遷移時に遷移先のウィンドウに値を渡す
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ResultViewController {
            vc.vc = self
            vc.btnlocations = self.btnlocations
            vc.btnsize = self.btnsize
            vc.setcolor = self.setcolor
        }
    }
}
