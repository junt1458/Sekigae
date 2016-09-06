//
//  People_Information.swift
//  席替え
//  Description:
//    人物の固有データを一括管理するクラスです。
//  Created by Tomatsu Junki on 2016/01/31.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import Foundation

class People_Information {
    
    var isMan : Bool!     //男か
    var SeatNumber: Int!  //席番号
    var Name: String!     //名前
    var Number: Int!      //番号
    var AllNumber: Int!   //通し番号
    
    init(isMan: Bool, SeatNumber: Int, Name: String, Number: Int, AllNumber: Int) {
        self.isMan = isMan
        self.SeatNumber = SeatNumber
        self.Name = Name
        self.Number = Number
        self.AllNumber = AllNumber
    }
}