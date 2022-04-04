//
//  YUIKit.h
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import <UIKit/UIKit.h>

#ifndef YUIKit_h
#define YUIKit_h

//#if __has_include("YUIModel.h")
//#import "YUIModel.h"
//#endif
//
//#if __has_include("YUIModelManager.h")
//#import "YUIModelManager.h"
//#endif
//
//#if __has_include("NSObject+YUIModel.h")
//#import "NSObject+YUIModel.h"
//#endif
//

static NSString * const YUI_VERSION = @"0.1.3";

#if __has_include("YUICore.h")
#import "YUICore.h"
#endif

#if __has_include("YUIArchitecture.h")
#import "YUIArchitecture.h"
#endif

#if __has_include("YUILog.h")
#import "YUILog.h"
#endif

#if __has_include("YUIWeakObjectContainer.h")
#import "YUIWeakObjectContainer.h"
#endif

#endif /* YUIKit_h */
