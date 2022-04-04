//
//  NSObject+YUIViewManager.m
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import "NSObject+YUIViewManager.h"
#import <objc/runtime.h>

@implementation NSObject (YUIViewManager)

-(id<YUIViewDelegateProtocol>)viewDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setViewDelegate:(id<YUIViewDelegateProtocol>)viewDelegate {
    objc_setAssociatedObject(self, @selector(viewDelegate), viewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

-(ViewEventBlock)viewEventBlock {
    return objc_getAssociatedObject(self, @selector(viewEventBlock));
}

-(void)setViewEventBlock:(ViewEventBlock)viewEventBlock {
    objc_setAssociatedObject(self, @selector(viewEventBlock), viewEventBlock, OBJC_ASSOCIATION_COPY);
}

-(void)viewWithViewManager:(id<YUIViewDelegateProtocol>)viewManager {
    if (viewManager) {
        self.viewDelegate = viewManager;
    }
}

@end
