//
//  CommonAmountTextFieldViewDelegateObject.m
//  YUIAll
//
//  Created by YUI on 2021/5/12.
//

#import "CommonAmountTextFieldViewDelegateObject.h"

@implementation CommonAmountTextFieldViewDelegateObject

/**
 *  textField的代理方法，监听textField的文字改变
 *  textField.text是当前输入字符之前的textField中的text
 *
 *  @param textField textField
 *  @param range     当前光标的位置
 *  @param string    当前输入的字符
 *
 *  @return 是否允许改变
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    BOOL isHavePoint = NO;
    
        // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        
        isHavePoint = YES;
    }else{
        
        isHavePoint = NO;
    }
 
    if (string.length > 0) {
 
            //当前输入的字符
        unichar single = [string characterAtIndex:0];
 
            // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.')){
 
            return NO;
        }
 
        // 只能有一个小数点
        if (isHavePoint && single == '.') {
 
            return NO;
        }
 
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
 
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            
            if (textField.text.length > 1) {
                
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                
                if (![secondStr isEqualToString:@"."]) {
 
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
 
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (isHavePoint) {
            
            NSRange ran = [textField.text rangeOfString:@"."];
                // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
 
                    return NO;
                }
            }
        }
    }
 
    return YES;
}

@end
