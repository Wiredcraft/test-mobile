//
//  QRCountdownLabel.swift
//  QRApp
//
//  Created by 顾强 on 16/5/19.
//  Copyright © 2016年 johnny. All rights reserved.
//

import UIKit

/// config
private let stepTimeInterval:NSTimeInterval = 1
private let configTimeZone:NSTimeZone = NSTimeZone.localTimeZone()

typealias JCCountingClosure = (remainTime:NSTimeInterval) -> Void

extension UILabel{
    private struct AssociatedKeys{
        static var RemainTimeKey = "remainTimeKey"
        static var TimerKey = "timeKey"
        static var CountingClosureKey = "countingClosureKey"
    }
    
    private(set) var remainTime:NSTimeInterval!{
        get{
             return (objc_getAssociatedObject(self, &AssociatedKeys.RemainTimeKey) as! NSNumber).doubleValue
        }
        set(newValue){
            print(newValue)
            objc_setAssociatedObject(self, &AssociatedKeys.RemainTimeKey, NSNumber.init(double: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    private var timer:NSTimer?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.TimerKey) as? NSTimer
        }
        set(newValue){
            print(newValue)
            objc_setAssociatedObject(self, &AssociatedKeys.TimerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var countingClosure:JCCountingClosure?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.CountingClosureKey) as? JCCountingClosure
        }
        set(newValue){
            let castedValue = newValue as! AnyObject
            objc_setAssociatedObject(self, &AssociatedKeys.CountingClosureKey, castedValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    func startCountingWithTimeInterval(timeInterval:NSTimeInterval) {
        self.startCountingWithTimeInterval(timeInterval, countClosure: nil)
    }
    
    func startCountingWithEndingDate(endingDate:NSDate) {
        self.startCountingWithEndingDate(endingDate, countClosure: nil)
    }
    
    func startCountingWithEndingDate(endingDate:NSDate, countClosure:JCCountingClosure?){
        self.cancelCounting()
        self.remainTime = endingDate.timeIntervalSinceNow
//        self.countingClosure = countClosure
        self.startCounting()
    }
    
    func startCountingWithTimeInterval(timeInterval:NSTimeInterval, countClosure:JCCountingClosure?) {
        self.cancelCounting()
        self.remainTime = timeInterval
//        self.countingClosure = countClosure
        self.startCounting()
    }
    
    func startCounting() {

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(UILabel.countdown), userInfo: nil, repeats: true)
    }
    
    func cancelCounting(){
        self.timer?.invalidate()
    }
    
    func countdown() {
        self.remainTime = self.remainTime! - stepTimeInterval
        if self.countingClosure != nil {
            self.countingClosure!(remainTime: self.remainTime)
        }else{
            self.text = "\(self.remainTime) s"
        }
        
        if self.remainTime == 0 {
            self.cancelCounting()
        }
    }
}

