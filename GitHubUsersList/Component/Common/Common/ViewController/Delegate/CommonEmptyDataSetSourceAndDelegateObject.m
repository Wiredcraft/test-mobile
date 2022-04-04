//
//  CommonEmptyDataTableSetViewDelegateObject.m
//  YUIAll
//
//  Created by YUI on 2021/6/10.
//

#import "CommonEmptyDataSetSourceAndDelegateObject.h"

@implementation CommonEmptyDataSetSourceAndDelegateObject

- (instancetype)init{
    
    if([super init]){
        
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize{
    
}

#pragma mark - <DZNEmptyDataSetDelegate>

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{

    if(self.modelManager){
        
        return self.modelManager.dataDidLoad;
    }
    return YES;
}

//  没数据也可以加载滑动  下拉刷新  上拉加载  YES有代表可滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    
    return YES;
}

#pragma mark - <DZNEmptyDataSetSource>

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{

    return -(50);
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *tempTextStr;
    
    if(self.titleStr && ![self.titleStr isEqualToString:@""]){

        tempTextStr = self.titleStr;
    }
    else{
        tempTextStr = @"没有更多信息了";
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13],
                                 NSForegroundColorAttributeName:[UIColor blackColor]};
    
    return [[NSAttributedString alloc] initWithString:tempTextStr attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *tempImageURLStr;
    
    if(self.imageURLStr && ![self.imageURLStr isEqualToString:@""]){

        tempImageURLStr = self.imageURLStr;
    }
    else{
        tempImageURLStr = @"";
    }
    return [UIImage imageNamed:tempImageURLStr];
}

@end
