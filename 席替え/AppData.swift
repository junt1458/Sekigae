//
//  AppData.swift
//  席替え
//  Description:
//    アプリのデータを管理するクラスです。
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
    //
    static var size1: [Float] = [14.0, 10.0, 8.0, 7.0, 7.0, 17.0]  //iPhone4s以前の端末、iPad用のフォントサイズ
    static var size2: [Float] = [15.0, 11.5, 9.0, 8.5, 8.0, 18.0]  //size1以外の端末用のフォントサイズ
    static var usesize1: Bool = false                              //size1の配列を使用するか
    
    
    
    
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
    static var sekistatus: [Bool] = [Bool]()         //席の配置設定(Key: Status)
    static var m_wstatus: [Bool] = [Bool]()          //男女の配置設定(Key: M_W)
    static var People_Data = [People_Information]()  //人物の設定データ(Key: P_D)
    static var Seat_Data = [Int]()                   //席のデータ
    static var Before_Data = [Int]()                 //前回の席情報(Key: B_D)
    static var rotateLabel: Bool = false             //ラベルを回転させるか(Key: RL)
    
    
    
    
    
    //
    // アプリのデータを保存する関数
    //
    static func saveData(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(maxcount, forKey: "Max")                                                     //合計人数の保存
        userDefaults.setObject(mancount, forKey: "Man")                                                     //男の人数の保存
        userDefaults.setObject(womancount, forKey: "Woman")                                                 //女の人数の保存
        userDefaults.setObject(sekistatus, forKey: "Status")                                                //席の配置設定の保存
        userDefaults.setObject(m_wstatus, forKey: "M_W")                                                    //男女の配置設定の保存
        userDefaults.setObject(PD_DataConverter().convertAllToStringListData(People_Data), forKey: "P_D")   //人物の設定データの保存
        userDefaults.setObject(rotateLabel, forKey: "RL")                                                   //ラベルを回転させる設定の保存
        userDefaults.setObject(Before_Data, forKey: "B_D")                                                  //前回の席情報の保存
        userDefaults.synchronize()
    }
    
    
    
    
    
    //
    // アプリのデータをロードする関数
    //
    static func loadData(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        //
        // 保存されているデータのNilチェック
        //
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
        if isNil(userDefaults.valueForKey("RL")) {
            rotateLabel = false
            userDefaults.setObject(false, forKey: "RL")
        }
        userDefaults.synchronize()
        
        
        
        //
        // データの読み込み
        //
        maxcount = userDefaults.valueForKey("Max") as! Int                                                    //合計人数の読み込み
        mancount = userDefaults.valueForKey("Man") as! Int                                                    //男の人数の読み込み
        womancount = userDefaults.valueForKey("Woman") as! Int                                                //女の人数の読み込み
        sekistatus = userDefaults.valueForKey("Status") as! [Bool]                                            //席の配置設定の読み込み
        m_wstatus = userDefaults.valueForKey("M_W") as! [Bool]                                                //男女の配置設定の読み込み
        People_Data = PD_DataConverter().convertAllToPI_Data(userDefaults.valueForKey("P_D") as! [[String]])  //人物の設定データの読み込み
        Before_Data = userDefaults.valueForKey("B_D") as! [Int]                                               //前回の席データの読み込み
        rotateLabel = userDefaults.valueForKey("RL") as! Bool                                                 //ラベルを回転させる設定の読み込み
    }
    
    
    //
    // 前回の席情報のみ読み込む
    //
    static func loadBefore(){
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if isNil(userDefaults.valueForKey("B_D")) {
            Before_Data = genBeforeData()
            userDefaults.setObject(Before_Data, forKey: "B_D")
        }
        Before_Data = userDefaults.valueForKey("B_D") as! [Int]
    }
    
    
    
    
    
    //
    //引数がNilかチェック
    //
    static func isNil(data: AnyObject?) -> Bool{
        return data == nil
    }
    
    
    
    
    //
    // 一時保存変数をリセット
    //
    static func formatTempData(){
        maxcount = 0
        mancount = 0
        womancount = 0
        sekistatus = [Bool]()
        m_wstatus = [Bool]()
        People_Data = [People_Information]()
        Seat_Data = [Int]()
        Before_Data = genBeforeData()
        rotateLabel = false
        loadBefore()
    }
    
    
    
    //
    // 保存されているデータを削除
    //
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
        rotateLabel = false
        userDefaults.setObject(rotateLabel, forKey: "RL")
        userDefaults.synchronize()
    }
    
    
    
    //
    // 前回の席データの配列を生成
    //
    static func genBeforeData() -> [Int] {
        var array = [Int]()
        for _ in 0 ..< CountLimit {
            array.append(-1)
        }
        return array
    }
    
}
