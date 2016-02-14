//
//  People_Information.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/31.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import Foundation

class People_Information {
    
    var isMan : Bool!
    var isSetSeat: Bool!
    var SeatNumber: Int!
    var Name: String!
    var Number: Int!
    var AllNumber: Int!
    
    init(isMan: Bool, isSetSeat: Bool, SeatNumber: Int, Name: String, Number: Int, AllNumber: Int) {
        self.isMan = isMan
        self.isSetSeat = isSetSeat
        self.SeatNumber = SeatNumber
        self.Name = Name
        self.Number = Number
        self.AllNumber = AllNumber
    }
}