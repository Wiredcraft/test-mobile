//
//  YUIViewModel.m
//  YUIAll
//
//  Created by YUI on 2021/2/21.
//

#import "YUIViewModel.h"

@implementation YUIViewModel

#pragma mark - init

- (instancetype)init{
    
    self = [super init];
    
    if(self) {
        
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize{
    
    // Rewrite this func in SubClass !
}

#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{

}

#pragma mark - <YUIViewManagerDelegate>

- (void)viewManager:(id)viewManager withInfo:(NSDictionary *)info{
    
}

#pragma mark ViewManager Block

- (ViewManagerInfoBlock)viewModelWithViewManagerBlockOfInfo:(NSDictionary *)info{
    
    return ^{
      NSLog(@"hello");
    };
}

#pragma mark 中介者传值

- (void)notice {
    
//    [self.mediator noticeViewManagerWithInfo:self.viewModelInfo];
}

//我很想写点什么，但很遗憾作为ViewModel离视图层比较远，无法通过subView进行补充
//- (id<YUIViewModelDelegateProtocol>)viewModelDelegate{
//    
//    return _viewModelDelegate;
//}

//#pragma mark 加载网络请求

//- (NSURLSessionTask *)viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
//
//    return [[SMKAction sharedAction] sendRequestBlock:^id(NSObject *request) {
//        return [[ThirdRequest alloc]init];
//    } progress:nil success:^(id responseObject) {
//        NSArray *modelArray = [ThirdModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
//        if (success) {
//            success(modelArray);
//        }
//    } failure:nil];
//
//}

//- (id)getRandomData:(NSArray *)array {
//    u_int32_t index = arc4random_uniform((u_int32_t)10);
//    return array[index];
//}
//
//#pragma mark 配置加工模型数据，并通过block传递给view
//
//- (void)viewModelWithModelBlcok:(void (^)(id))modelBlock {
//
//    [self viewModelWithProgress:nil success:^(id responseObject) {
//        if (modelBlock) {
//
//            if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(viewModel:withInfo:)]) {
//                [self.viewModelDelegate viewModel:self withInfo:@{@"info" : @"呵呵， 你好， 我是ViewModel，我加载数据成功了"}];
//            }
//            modelBlock([self getRandomData:responseObject]);
//        }
//    } failure:nil];
//}

@end
