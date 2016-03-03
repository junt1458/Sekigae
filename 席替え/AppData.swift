//
//  AppData.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/17.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import Foundation

class AppData {
    
    //
    // フォントサイズの設定
    // 配列の中身
    //   0: 5文字のとき
    //   1: 6,7文字のとき
    //   2: 8文字のとき
    //   3: 9文字のとき
    //   4: 10文字以上
    //   5: それ以外
    // データ
    // size1: iPhone4s以前の端末、iPad用のデータ
    // size2: size1以外の端末用のデータ
    // usesize1: size1を使うか
    //
    static var size1: [Float] = [14.0, 10.0,   8.0,   7.0, 7.0, 17.0]
    static var size2: [Float] = [15.0, 11.5, 9.0, 8.5, 8.0, 18.0]
    static var usesize1: Bool = false
    
    
    //
    // ホームページ関連の定数の定義
    //
    static let baseurl = "http://junki-t.net/"                   //ホームページのURL
    static let dir = "SmartPhoneApps/SeatChange/"                //ページのディレクトリ
    static let usagePage = "usage.html"                          //使い方ページのファイル名
    static let infoPage = "info.php"                             //お知らせページのファイル名
    
    //
    // アプリのデータの定義
    //
    static let CountLimit: Int = 48                  //最大人数の設定
    static var maxcount: Int = 0                     //合計人数(Key: Max)
    static var mancount: Int = 0                     //男の人数(Key: Man)
    static var womancount: Int = 0                   //女の人数(Key: Woman)
    static var sekistatus: [Bool] = [Bool]()         //席の使用不使用設定(Key: Status)
    static var m_wstatus: [Bool] = [Bool]()          //席の男子女子設定(Key: M_W)
    static var People_Data = [People_Information]()  //人物の設定データ(Key: P_D)
    static var Seat_Data = [Int]()                   //席のデータ
    static var Before_Data = [Int]()                 //前回の席情報(Key: B_D)
    
    //
    // データのロード、セーブの関数
    //
    static func saveData(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        NSLog("合計人数の保存")
        userDefaults.setObject(maxcount, forKey: "Max")
        NSLog("男の人数の保存")
        userDefaults.setObject(mancount, forKey: "Man")
        NSLog("女の人数の保存")
        userDefaults.setObject(womancount, forKey: "Woman")
        NSLog("席の状態を保存")
        userDefaults.setObject(sekistatus, forKey: "Status")
        NSLog("席の男女の設定の保存")
        userDefaults.setObject(m_wstatus, forKey: "M_W")
        NSLog("人のデータの保存")
        userDefaults.setObject(PD_DataConverter().convertAllToStringListData(People_Data), forKey: "P_D")
        //userDefaults.setObject(People_Data, forKey: "P_D")
        NSLog("%@", String(true))
        
        NSLog("前回の結果の保存")
        userDefaults.setObject(Before_Data, forKey: "B_D")
        userDefaults.synchronize()
    }
    
    static func loadData(){
        if !DebugSet.noLoad {
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if isNil(userDefaults.valueForKey("Max")) {
                maxcount = 0
                userDefaults.setObject(maxcount, forKey: "Max")
            }
            if isNil(userDefaults.valueForKey("Man")) {
                mancount = 0
                userDefaults.setObject(mancount, forKey: "Man")
            }
            if isNil(userDefaults.valueForKey("Woman")) {
                womancount = 0
                userDefaults.setObject(womancount, forKey: "Woman")
            }
            if isNil(userDefaults.valueForKey("Status")) {
                sekistatus = [Bool]()
                userDefaults.setObject(sekistatus, forKey: "Status")
            }
            if isNil(userDefaults.valueForKey("M_W")) {
                m_wstatus = [Bool]()
                userDefaults.setObject(m_wstatus, forKey: "M_W")
            }
            if isNil(userDefaults.valueForKey("P_D")) {
                People_Data = [People_Information]()
                userDefaults.setObject([[String]](), forKey: "P_D")
            }
            if isNil(userDefaults.valueForKey("B_D")) {
                Before_Data = genBeforeData()
                userDefaults.setObject(Before_Data, forKey: "B_D")
            }
            maxcount = userDefaults.valueForKey("Max") as! Int
            mancount = userDefaults.valueForKey("Man") as! Int
            womancount = userDefaults.valueForKey("Woman") as! Int
            sekistatus = userDefaults.valueForKey("Status") as! [Bool]
            m_wstatus = userDefaults.valueForKey("M_W") as! [Bool]
            People_Data = PD_DataConverter().convertAllToPI_Data(userDefaults.valueForKey("P_D") as! [[String]])
            Before_Data = userDefaults.valueForKey("B_D") as! [Int]
            userDefaults.synchronize()
        }else{
            maxcount = 40
            NSLog("maxcountの設定: %d", maxcount)
            mancount = 20
            womancount = 20
            sekistatus = [true, false, false, true, false, false, true, true, false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
            m_wstatus = [true, true, true, true, true , true, true, false, true, true, true, true, false, false, false, false, false, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, true, true, false, false, false, false, true, true, true, true, true, true, true, true, true]
        }
    }
    
    static func loadBefore(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if isNil(userDefaults.valueForKey("B_D")) {
            Before_Data = genBeforeData()
            userDefaults.setObject(Before_Data, forKey: "B_D")
        }
        Before_Data = userDefaults.valueForKey("B_D") as! [Int]
    }
    
    static func isNil(data: AnyObject?) -> Bool{
        return data == nil
    }
    
    static func formatTempData(){
        maxcount = 0
        mancount = 0
        womancount = 0
        sekistatus = [Bool]()
        m_wstatus = [Bool]()
        People_Data = [People_Information]()
        Seat_Data = [Int]()
        Before_Data = genBeforeData()
        loadBefore()
    }
    
    static func formatData(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        maxcount = 0
        userDefaults.setObject(maxcount, forKey: "Max")
        mancount = 0
        userDefaults.setObject(mancount, forKey: "Man")
        womancount = 0
        userDefaults.setObject(womancount, forKey: "Woman")
        sekistatus = [Bool]()
        userDefaults.setObject(sekistatus, forKey: "Status")
        m_wstatus = [Bool]()
        userDefaults.setObject(m_wstatus, forKey: "M_W")
        People_Data = [People_Information]()
        userDefaults.setObject([[String]](), forKey: "P_D")
        Before_Data = genBeforeData()
        userDefaults.setObject(Before_Data, forKey: "B_D")
        Seat_Data = [Int]()
        userDefaults.synchronize()
    }
 
    static func genBeforeData() -> [Int] {
        var array = [Int]()
        for _ in 0 ..< CountLimit {
            array.append(-1)
        }
        return array
    }
    
}
