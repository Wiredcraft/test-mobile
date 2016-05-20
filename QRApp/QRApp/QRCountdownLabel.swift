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
// counting closure
typealias JCCountingClosure = @convention(block) (remainTime:NSTimeInterval) -> Void

extension UILabel{
    private struct AssociatedKeys{
        static var RemainTimeKey = "remainTimeKey"
        static var TimerKey = "timeKey"
        static var CountingClosureKey = "countingClosureKey"
    }
    // time remained
    private(set) var remainTime:NSTimeInterval!{
        get{
             return (objc_getAssociatedObject(self, &AssociatedKeys.RemainTimeKey) as! NSNumber).doubleValue
        }
        set(newValue){
            objc_setAssociatedObject(self, &AssociatedKeys.RemainTimeKey, NSNumber.init(double: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    // timer used for counting
    private var timer:NSTimer?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.TimerKey) as? NSTimer
        }
        set(newValue){
            objc_setAssociatedObject(self, &AssociatedKeys.TimerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    // custom callback
    var countingClosure:JCCountingClosure?{
        get{
            let originalValue = objc_getAssociatedObject(self, &AssociatedKeys.CountingClosureKey)
            return unsafeBitCast(originalValue, JCCountingClosure.self)
        }
        set(newValue){
            let castedValue: AnyObject = unsafeBitCast(newValue, AnyObject.self)
            objc_setAssociatedObject(self, &AssociatedKeys.CountingClosureKey, castedValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    // start with timeInterval
    func startCountingWithTimeInterval(timeInterval:NSTimeInterval) {
        self.startCountingWithTimeInterval(timeInterval, countClosure: nil)
    }
    // start with end date
    func startCountingWithEndingDate(endingDate:NSDate) {
        self.startCountingWithEndingDate(endingDate, countClosure: nil)
    }
    // start with end date & custom callback
    func startCountingWithEndingDate(endingDate:NSDate, countClosure:JCCountingClosure?){
        self.cancelCounting()
        self.remainTime = endingDate.timeIntervalSinceNow
        self.countingClosure = countClosure
        self.startCounting()
    }
    // start with timeInterval & custom callback
    func startCountingWithTimeInterval(timeInterval:NSTimeInterval, countClosure:JCCountingClosure?) {
        self.cancelCounting()
        self.remainTime = timeInterval
        self.countingClosure = countClosure
        self.startCounting()
    }
    // start counting
    func startCounting() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(UILabel.countdown), userInfo: nil, repeats: true)
    }
    // cancel counting
    func cancelCounting(){
        self.timer?.invalidate()
        self.timer = nil;
        self.countingClosure = nil;
    }
    // private count down,
    // this should be a privete function, but when i do that,the selector will force me to changed this to oc function,i dont know why ?_?
    func countdown() {
        
        let seconds = Int(self.remainTime)
        if self.countingClosure != nil {
            self.countingClosure!(remainTime: self.remainTime)
        }
        self.text = "\(seconds) s"
        
        if self.remainTime < 1 {
            self.cancelCounting()
        }
        self.remainTime = self.remainTime! - stepTimeInterval
    }
}

