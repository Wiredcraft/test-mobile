//
//  QRLocalSaver.swift
//  QRApp
//
//  Created by 顾强 on 16/5/20.
//  Copyright © 2016年 johnny. All rights reserved.
//

import Foundation

/**
 *  used for data localize
 */
struct QRLocalSaver {
    private struct AssociatedKeys{
        static var DataStringKey = "dataStringKey"
        static var ExpiredDateKey = "ExpiredDateKey"
    }
    var dataString:String!
    var ExpiredDate:NSDate!
    
    static func saveToLocal(aString:String!, date:NSDate!) -> Void {
//        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            NSUserDefaults.standardUserDefaults().setObject(aString, forKey: AssociatedKeys.DataStringKey)
            NSUserDefaults.standardUserDefaults().setObject(date, forKey: AssociatedKeys.ExpiredDateKey)
//        }
    }
    
    func saveToLocal() -> Void {
        QRLocalSaver.saveToLocal(self.dataString, date: self.ExpiredDate)
    }
    
    static func readFromLocal() -> QRLocalSaver? {
        var saver = QRLocalSaver()
        if let String = NSUserDefaults.standardUserDefaults().stringForKey(AssociatedKeys.DataStringKey) {
            saver.dataString = String
        }else{
            return nil;
        }
        saver.dataString = NSUserDefaults.standardUserDefaults().stringForKey(AssociatedKeys.DataStringKey)
        saver.ExpiredDate = NSUserDefaults.standardUserDefaults().objectForKey(AssociatedKeys.ExpiredDateKey) as! NSDate
        return saver
    }
}