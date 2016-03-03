//
//  People_Information.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/31.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import Foundation

//@objc(People_Information)
class People_Information /*: NSObject,NSCoding*/ {
    
    var isMan : Bool!
    var SeatNumber: Int!
    var Name: String!
    var Number: Int!
    var AllNumber: Int!
    
    /*@objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(isMan, forKey: "isMan")
        aCoder.encodeInteger(-1, forKey: "SeatNumber")
        aCoder.encodeObject(Name, forKey: "Name")
        aCoder.encodeInteger(Number, forKey: "Number")
        aCoder.encodeInteger(AllNumber, forKey: "AllNumber")
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.isMan = aDecoder.decodeBoolForKey("isMan")
        self.SeatNumber = aDecoder.decodeIntegerForKey("SeatNumber")
        self.Name = aDecoder.decodeObjectForKey("Name") as! String
        self.Number = aDecoder.decodeIntegerForKey("Number")
        self.AllNumber = aDecoder.decodeIntegerForKey("AllNumber")
    }
    */
    
    
    init(isMan: Bool, SeatNumber: Int, Name: String, Number: Int, AllNumber: Int) {
        self.isMan = isMan
        self.SeatNumber = SeatNumber
        self.Name = Name
        self.Number = Number
        self.AllNumber = AllNumber
    }
}