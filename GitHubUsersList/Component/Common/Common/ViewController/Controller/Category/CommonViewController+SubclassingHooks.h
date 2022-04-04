//
//  CommonViewController+MVVM.h
//  YUIAll
//
//  Created by YUI on 2021/5/26.
//

#import "CommonViewController.h"

#import "ComnonArchitectureDelegateObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonViewController (){
    
    ComnonArchitectureDelegateObject *_architectureDelegateObject;
}

@property (nullable, nonatomic, strong) ComnonArchitectureDelegateObject *architectureDelegateObject;

@end

@interface CommonViewController (SubclassingHooks)

@end

NS_ASSUME_NONNULL_END
