//
//  YUIComponent.h
//  YUIAll
//
//  Created by YUI on 2021/3/22.
//

#ifndef YUICore_h
#define YUICore_h



//#if __has_include("YUIHelper.h")
//#import "YUIHelper.h"
//#endif
//
#if __has_include("YUICommonDefines.h")
#import "YUICommonDefines.h"
#endif

#if __has_include("YUIRuntime.h")
#import "YUIRuntime.h"
#endif

#if __has_include("YUILab.h")
#import "YUILab.h"
#endif

//#if __has_include("YUIConfiguration.h")
//#import "YUIConfiguration.h"
//#endif
//
//#if __has_include("YUIConfigurationMacros.h")
//#import "YUIConfigurationMacros.h"
//#endif



//#if __has_include("CAAnimation+YUI.h")
//#import "CAAnimation+YUI.h"
//#endif
//
//#if __has_include("CALayer+YUI.h")
//#import "CALayer+YUI.h"
//#endif
//
//#if __has_include("CALayer+YUIViewAnimation.h")
//#import "CALayer+YUIViewAnimation.h"
//#endif

#if __has_include("NSArray+YUI.h")
#import "NSArray+YUI.h"
#endif

//#if __has_include("NSAttributedString+YUI.h")
//#import "NSAttributedString+YUI.h"
//#endif
//
#if __has_include("NSCharacterSet+YUI.h")
#import "NSCharacterSet+YUI.h"
#endif

#if __has_include("NSMethodSignature+YUI.h")
#import "NSMethodSignature+YUI.h"
#endif

//#if __has_include("NSNumber+YUI.h")
//#import "NSNumber+YUI.h"
//#endif

#if __has_include("NSObject+YUI.h")
#import "NSObject+YUI.h"
#endif

//#if __has_include("NSObject+YUIMultipleDelegates.h")
//#import "NSObject+YUIMultipleDelegates.h"
//#endif
//
//#if __has_include("NSParagraphStyle+YUI.h")
//#import "NSParagraphStyle+YUI.h"
//#endif
//
//#if __has_include("NSPointerArray+YUI.h")
//#import "NSPointerArray+YUI.h"
//#endif

#if __has_include("NSString+YUI.h")
#import "NSString+YUI.h"
#endif

//#if __has_include("NSURL+YUI.h")
//#import "NSURL+YUI.h"
//#endif



//#if __has_include("UIActivityIndicatorView+YUI.h")
//#import "UIActivityIndicatorView+YUI.h"
//#endif
//
//#if __has_include("UIBarItem+YUI.h")
//#import "UIBarItem+YUI.h"
//#endif
//
//#if __has_include("UIBarItem+YUIBadge.h")
//#import "UIBarItem+YUIBadge.h"
//#endif
//
//#if __has_include("UIBezierPath+YUI.h")
//#import "UIBezierPath+YUI.h"
//#endif
//
//#if __has_include("UIButton+YUI.h")
//#import "UIButton+YUI.h"
//#endif
//
//#if __has_include("UICollectionView+YUI.h")
//#import "UICollectionView+YUI.h"
//#endif
//
//#if __has_include("UICollectionView+YUICellSizeKeyCache.h")
//#import "UICollectionView+YUICellSizeKeyCache.h"
//#endif
//
//#if __has_include("UIColor+YUI.h")
//#import "UIColor+YUI.h"
//#endif
//
//#if __has_include("UIColor+YUITheme.h")
//#import "UIColor+YUITheme.h"
//#endif
//
//#if __has_include("UIControl+YUI.h")
//#import "UIControl+YUI.h"
//#endif
//
//#if __has_include("UIFont+YUI.h")
//#import "UIFont+YUI.h"
//#endif
//
//#if __has_include("UIGestureRecognizer+YUI.h")
//#import "UIGestureRecognizer+YUI.h"
//#endif
//
//#if __has_include("UIImage+YUI.h")
//#import "UIImage+YUI.h"
//#endif
//
//#if __has_include("UIImage+YUITheme.h")
//#import "UIImage+YUITheme.h"
//#endif
//
//#if __has_include("UIImageView+YUI.h")
//#import "UIImageView+YUI.h"
//#endif
//
//#if __has_include("UIInterface+YUI.h")
//#import "UIInterface+YUI.h"
//#endif
//
//#if __has_include("UILabel+YUI.h")
//#import "UILabel+YUI.h"
//#endif
//
//#if __has_include("UIMenuController+YUI.h")
//#import "UIMenuController+YUI.h"
//#endif
//
//#if __has_include("UINavigationBar+YUI.h")
//#import "UINavigationBar+YUI.h"
//#endif
//
//#if __has_include("UINavigationBar+Transition.h")
//#import "UINavigationBar+Transition.h"
//#endif
//
//#if __has_include("UINavigationController+NavigationBarTransition.h")
//#import "UINavigationController+NavigationBarTransition.h"
//#endif
//
//#if __has_include("UINavigationController+YUI.h")
//#import "UINavigationController+YUI.h"
//#endif
//
//#if __has_include("UIScrollView+YUI.h")
//#import "UIScrollView+YUI.h"
//#endif
//
//#if __has_include("UISearchBar+YUI.h")
//#import "UISearchBar+YUI.h"
//#endif
//
//#if __has_include("UISearchController+YUI.h")
//#import "UISearchController+YUI.h"
//#endif
//
//#if __has_include("UISwitch+YUI.h")
//#import "UISwitch+YUI.h"
//#endif
//
//#if __has_include("UITabBar+YUI.h")
//#import "UITabBar+YUI.h"
//#endif
//
//#if __has_include("UITabBarItem+YUI.h")
//#import "UITabBarItem+YUI.h"
//#endif
//
//#if __has_include("UITableView+YUI.h")
//#import "UITableView+YUI.h"
//#endif
//
//#if __has_include("UITableView+YUICellHeightKeyCache.h")
//#import "UITableView+YUICellHeightKeyCache.h"
//#endif
//
//#if __has_include("UITableView+YUIStaticCell.h")
//#import "UITableView+YUIStaticCell.h"
//#endif
//
//#if __has_include("UITableViewCell+YUI.h")
//#import "UITableViewCell+YUI.h"
//#endif
//
//#if __has_include("UITextField+YUI.h")
//#import "UITextField+YUI.h"
//#endif
//
//#if __has_include("UITextInputTraits+YUI.h")
//#import "UITextInputTraits+YUI.h"
//#endif
//
//#if __has_include("UITextView+YUI.h")
//#import "UITextView+YUI.h"
//#endif
//
//#if __has_include("UITraitCollection+YUI.h")
//#import "UITraitCollection+YUI.h"
//#endif
//
//#if __has_include("UIView+YUI.h")
//#import "UIView+YUI.h"
//#endif
//
//#if __has_include("UIView+YUITheme.h")
//#import "UIView+YUITheme.h"
//#endif
//
//#if __has_include("UIViewController+YUI.h")
//#import "UIViewController+YUI.h"
//#endif
//
//#if __has_include("UIViewController+YUITheme.h")
//#import "UIViewController+YUITheme.h"
//#endif
//
//#if __has_include("UIVisualEffect+YUITheme.h")
//#import "UIVisualEffect+YUITheme.h"
//#endif
//
//#if __has_include("UIWindow+YUI.h")
//#import "UIWindow+YUI.h"
//#endif

#endif /* YUICore_h */

