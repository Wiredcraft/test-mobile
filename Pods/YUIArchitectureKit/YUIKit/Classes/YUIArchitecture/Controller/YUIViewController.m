//
//  YUIViewController.m
//  YUIAll
//
//  Created by YUI on 2020/11/17.
//

#import "YUIViewController.h"

#import "YUICore.h"
#import "YUIViewController+YUISubclassingHooks.h"
#import "YUIViewController+MVC.h"
#import "YUIViewController+MVP.h"
#import "YUIViewController+MVVM.h"

//#pragma mark - init
//#pragma mark - Lifecycle
////#pragma mark - UITableViewDelegate
//#pragma mark - ViewDelegate
//#pragma mark - CustomDelegate
//#pragma mark - event response
//#pragma mark - private methods
//#pragma mark - getters and setters

@interface YUIViewController ()

@property (nonatomic, assign) ArchitectureType architectureType;
@property (nonatomic, copy) NSString *architectureName;

@end

NSString * const kMVCPrefixStr = @"mvc";
NSString * const kMVPPrefixStr = @"mvp";
NSString * const kMVVMPrefixStr = @"mvvm";

@implementation YUIViewController

#pragma mark - init

+ (instancetype)sharedInstance{
    
    //Singleton instance
    static YUIViewController *yuiVC;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        yuiVC = [[self alloc] init];
    });
    
    return yuiVC;
}

//init里不要出现创建view的代码。良好的设计，在init里应该只有相关数据的初始化，而且这些数据都是比较关键的数据。init里不要掉self.view，否则会导致viewcontroller创建view。（因为view是lazyinit的）。
//初始化UIViewController，执行关键数据初始化操作，注意这里不要做view相关操作，view在loadView方法中才初始化，这时loadView还未调用。

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self configureArchitecture];
        
        [self didInitialize];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self configureArchitecture];
        
        [self didInitialize];
    }
    return self;
}

- (void)configureArchitecture{
    
    // Rewrite this func in SubClass !
}

- (void)configureArchitecture:(ArchitectureType)architectureType{
    
    self.architectureType = architectureType;
    
    NSString *temp;
    
    switch (architectureType) {
            
        case ArchitectureTypeMVC:{
            temp = kMVCPrefixStr;
        }
            break;
        case ArchitectureTypeMVP:{
            temp = kMVPPrefixStr;
        }
            break;
        case ArchitectureTypeMVVM:{
            temp = kMVVMPrefixStr;
        }
            break;
        default:{
            return;
        }
            break;
    }
    [self configureArchitectureWithArchitectureName:temp];
}


- (void)configureArchitectureWithArchitectureName:(NSString *)architectureName{
    
    self.architectureName = architectureName;
    
    NSString *bindingName = @"";
    NSString *className = NSStringFromClass([self class]);
    if(![className containsString:@"ViewController"])
        return;
    bindingName = [className substringToIndex:[className rangeOfString:@"ViewController"].location];
    
    SEL tempSelector = NSSelectorFromString(@"configureArchitectureWithBindingName:");
    
    [self performSelectorForArchitecture:tempSelector withObject:bindingName];
}

- (void)didInitialize{
    
    self.isFirstAppear = YES;
    
    [self configureNotification];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)configureNotification{
    
    // Rewrite this func in SubClass !
}

#pragma mark - Lifecycle

// loadView中只初始化view，一般用于创建比较关键的view如tableViewController的tabView，UINavigationController的navgationBar，不可掉用view的getter（在掉super loadView前），最好也不要初始化一些非关键的view。如果你是从nib文件中创建的viewController在这里一定要首先调用super的loadView方法，但建议不要重载这个方法。
// 当访问UIViewController的view属性时，view如果此时是nil，那么VC会自动调用loadView方法来初始化一个UIView并赋值给view属性。此方法用在初始化关键view
- (void)loadView{
    
    if(self.mainView){
        
        self.mainView.frame = [UIScreen mainScreen].bounds;
        self.view = self.mainView;
    }
    else{
        
        [super loadView];
    }
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

// 这时候view已经有了，最适合创建一些附加的view和控件了。
// 当VC的view对象载入内存后调用，用于对view进行额外的初始化操作
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)configureBingding{
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

// 这个一般在view被添加到superview之前，切换动画之前调用。在这里可以进行一些显示前的处理。比如键盘弹出，一些特殊的过程动画（比如状态条和navigationbar颜色）。
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupNavigationItems];
    
    [self setupToolbarItems];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

// 一般用于显示前,对子控件进行更新布局
- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

// 子控件布局完成,可以在这方法里面对子控件进行一些初始化操作.
// - (void)viewDidLoad执行完后会执行- (void)viewWillLayoutSubviews，- (void)viewDidLayoutSubviews
// 当在self.view上的子控件的高度或者宽度改变时，会先执行- (void)viewWillLayoutSubviews，- (void)viewDidLayoutSubviews，然后执行子控件中的- (void)layoutSubviews。
// 打开和收起键盘的时候
// 添加视图的时候
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

// 一般用于显示后，在切换动画后，如果有需要的操作，可以在这里加入相关代码。
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if(self.isFirstAppear)
        self.isFirstAppear = NO;
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self cleanupTimer];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)dealloc{
    
    //  If your app targets iOS 9.0 and later or macOS 10.11 and later, you don't need to unregister an observer in its dealloc method.
    //[self cleanupNotification];
    
    [self performSelectorForArchitecture:_cmd withObject:nil];
}

- (void)cleanupNotification{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - ViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods

- (void)performSelectorForArchitecture:(SEL)selector withObject:(id)object{
    
    NSString *prefixStr = self.architectureName;
    
    if(!prefixStr || [prefixStr yui_isBlankString])
        return;
    
    NSString *methodStr = NSStringFromSelector(selector);
    SEL tempSelector = NSSelectorFromString([NSString stringWithFormat:@"%@_%@",prefixStr,methodStr]);
    
    if([self respondsToSelector:tempSelector]){
        
        BeginIgnorePerformSelectorLeaksWarning
        [self performSelector:tempSelector withObject:object];
        EndIgnorePerformSelectorLeaksWarning
        //        IMP imp = [self methodForSelector:tempSelector];
        //        void (*func)(id, SEL) = (void *)imp;
        //        func(self, tempSelector);
    }
}


#pragma mark - getters and setters        ··

//1.单个 viewController
//相信大部分人都知道单个viewController的生命周期，在这里简单提下：
//1、loadView
//2、viewDidLoad
//3、viewWillAppear
//4、viewDidAppear
//5、viewWillDisappear
//6、viewDidDisappear
//
//2.viewController之间跳转时的执行顺序
//1、从A控制器 push到 B控制器
//1.B  viewDidLoad     ——>  2. A   viewWillDisappear   ——> 3. B  viewWillAppear     ——> A. ViewDidDisappear  ——>  B. viewDidAppear
//A -> B
//
//2、从B控制器 pop回 A控制器
//1.B viewWillDisappear  ——> 2. A viewWillAppear  ——> 3. B  viewDidDisappear   ——> 4. viewDidAppear
//B -> A

@end
