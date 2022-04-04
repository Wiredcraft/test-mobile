//
//  UIView+Common.m
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import "UIView+Common.h"
#import <objc/runtime.h>

@implementation UIView (Common)

- (UIEdgeInsets)subviewEdge{
    
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setSubviewEdge:(UIEdgeInsets)subviewEdge{
    
    objc_setAssociatedObject(self, @selector(subviewEdge), @(subviewEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)subviewSpacingWidth{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setSubviewSpacingWidth:(NSInteger)subviewSpacingWidth {
    
    objc_setAssociatedObject(self, @selector(subviewSpacingWidth), @(subviewSpacingWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)subviewSpacingHeight{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setSubviewSpacingHeight:(NSInteger)subviewSpacingHeight{
    
     objc_setAssociatedObject(self, @selector(subviewSpacingHeight), @(subviewSpacingHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)style{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setStyle:(NSInteger)style{
    
     objc_setAssociatedObject(self, @selector(style), @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)type{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setType:(NSInteger)type{
    
     objc_setAssociatedObject(self, @selector(type), @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)index{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setIndex:(NSInteger)index{
    
     objc_setAssociatedObject(self, @selector(index), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)internalIndex{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setInternalIndex:(NSInteger)internalIndex{
    
     objc_setAssociatedObject(self, @selector(internalIndex), @(internalIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupLayoutParams{
    
    self.subviewEdge = UIEdgeInsetsMake( 14, 15, 14, 15);
    self.subviewSpacingWidth = 8;
    self.subviewSpacingHeight = 8;
}

@end
