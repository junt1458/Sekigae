//
//  PD_DataConverter.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/18.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import Foundation

class PD_DataConverter {
    
    func convertToBool(value : String) -> Bool{
        switch value {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    //
    // People_InformationをStringリストデータに変換します。
    // 返り値
    //  [String]
    //    0: isMan
    //    1: SeatNumber
    //    2: Name
    //    3: Number
    //    4: AllNumber
    //
    func convertToStringListData(data: People_Information) -> [String] {
        let isMan = String(data.isMan)
        let SeatNumber = String(-1)
        let Name = data.Name
        let Number = String(data.Number)
        let AllNumber = String(data.AllNumber)
        var list = [String]()
        list.append(isMan)
        list.append(SeatNumber)
        list.append(Name)
        list.append(Number)
        list.append(AllNumber)
        return list
    }
    
    //
    // convertToStringListDataで変換したデータをPeople_Informationに戻します
    // 返り値
    //  People_Information
    //
    func convertToPI_Data(data: [String]) -> People_Information {
        let isMan = convertToBool(data[0])
        let SeatNumber = Int(data[1])!
        let Name = data[2]
        let Number = Int(data[3])!
        let AllNumber = Int(data[4])!
        return People_Information(isMan: isMan, SeatNumber: SeatNumber, Name: Name, Number: Number, AllNumber: AllNumber)
    }
    
    //
    // 配列の中身全てにconvertToPI_Dataを実行します
    // 返り値
    //  [[String]]
    //
    func convertAllToPI_Data(data: [[String]]) -> [People_Information] {
        var d = [People_Information]()
        for i in data {
            d.append(convertToPI_Data(i))
        }
        return d
    }

    //
    // 配列の中身全てにconvertToStringListDataを実行します
    // 返り値
    //  [People_Information]
    //
    func convertAllToStringListData(data: [People_Information]) -> [[String]]{
        var d = [[String]]()
        for i in data {
            d.append(convertToStringListData(i))
        }
        return d
    }
    
}