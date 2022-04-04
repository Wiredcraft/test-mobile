//
//  UIViewController+YUI.m
//  YUIAll
//
//  Created by YUI on 2020/11/17.
//

#import "UIViewController+YUI.h"

@implementation UIViewController (YUI)

+ (instancetype)sharedInstance{
    
    //Singleton instance
    static UIViewController *vC;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        vC = [[self alloc] init];
    });
    
    return vC;
}

- (void)clear{
    
        //    dispatch_once_t onceToken = 0;
}

#pragma mark - Controller Callback

#pragma mark - Init

-(void)commonInit{
    
}

-(void)setup{
    
}

-(void)clean{
    
}

#pragma mark - View Init

-(void)configureNavigationBar{
    
}

-(void)configureTabBar{
    
}

-(void)configureMainView{
    
}

-(void)configureSubview{

}

-(void)configureSubviewLayout{

}

-(void)updateSubviewLayout{
    
}

-(void)updateSubview{
    
}

-(void)restoreSubview{
    
}

-(void)removeSubView{
    
    for (UIView *view in [self.view subviews]){
        
        [view removeFromSuperview];
    }
    
    //    if ([self.subviews count] > =1) {
    //
    //        NSInteger temp = [self.subviews count];
    //
    //        for(int i = 0;i < temp; i++){
    //
    //            [[self.subviews objectAtIndex:0] removeFromSuperview];
    //        }
    //    }
}

-(void)configureRefresh{
    
}

#pragma mark - View Layout Callback

#pragma mark - Gesture Interaction

- (void)configureGesture{
    
}

-(void)updateGesture{
    
}

#pragma mark - Animation Effect

#pragma mark - Model Interaction

-(void)updateData{
    
}

-(void)getData{
    
}

-(void)setData{
    
}


-(void)uploadData{
    
}

-(void)saveData{
    
}

-(void)loadData{
    
}

-(void)processData{
    
}

-(void)restoreData{
    
}

-(void)releaseData{
    
}

#pragma mark - Model Interaction Callback

#pragma mark - View Interaction

#pragma mark - View Interaction Callback

#pragma mark - Active Trigger

#pragma mark - Passive Callback

#pragma mark - Transition Callback

- (BOOL)isSelectorOverrided:(SEL)selector{

    return [self.class instanceMethodForSelector:selector] != [UIViewController instanceMethodForSelector:selector];
}

@end
