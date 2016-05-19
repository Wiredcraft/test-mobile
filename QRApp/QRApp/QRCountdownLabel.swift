//
//  QRCountdownLabel.swift
//  QRApp
//
//  Created by 顾强 on 16/5/19.
//  Copyright © 2016年 johnny. All rights reserved.
//

import UIKit

private var remainTimeKey = "remainTimeKey"
private var timerKey = "timerKey"
private var countingClosureKey = "countingClosureKey"
/// config
private let stepTimeInterval:NSTimeInterval = 1
private let configTimeZone:NSTimeZone = NSTimeZone.localTimeZone()

typealias JCCountingClosure = (remainTime:NSTimeInterval) -> Void

extension UILabel{
    
    private(set) var remainTime:NSTimeInterval!{
        get{
             return (objc_getAssociatedObject(self, &remainTimeKey) as! NSNumber).doubleValue
        }
        set(newValue){
            print(newValue)
            objc_setAssociatedObject(self, &remainTimeKey, NSNumber.init(double: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    private var timer:NSTimer!{
        get{
            return objc_getAssociatedObject(self, &timerKey) as? NSTimer
        }
        set(newValue){
            print(newValue)
            objc_setAssociatedObject(self, &timerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var countingClosure:JCCountingClosure?{
        get{
            return objc_getAssociatedObject(self, &countingClosureKey) as? JCCountingClosure
        }
        set(newValue){
            let castedValue = newValue as! AnyObject
            objc_setAssociatedObject(self, &countingClosureKey, castedValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    
    func startCountingWithEndingDate(endingDate:NSDate){
        self.cancelCounting()
        self.remainTime = endingDate.timeIntervalSinceNow
        self.startCounting()
    }
    
    func startCountingWithTimeInterval(timeInterval:NSTimeInterval) {
        self.cancelCounting()
        self.remainTime = timeInterval
        self.startCounting()
    }
    
    func startCounting() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector(countdown()), userInfo: nil, repeats: false)
        
    }
    
    func cancelCounting(){
        self.timer?.invalidate()
    }
    
    private func countdown() {
        self.remainTime = self.remainTime! - stepTimeInterval
//        if self.countingClosure != nil {
//            self.countingClosure!(remainTime: self.remainTime)
//        }else{
            self.text = "\(self.remainTime) s"
//        }
        
//        if self.remainTime == 0 {
//            self.cancelCounting()
//        }
    }
}

