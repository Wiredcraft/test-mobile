//
//  CommonAlterController.m
//  YUIAll
//
//  Created by YUI on 2022/1/18.
//

#import "CommonAlterController.h"

@interface CommonAlterController ()

@end

@implementation CommonAlterController

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initAppearance];
    });
}

+(void)initAppearance{
    
    CommonAlterController *alertControllerAppearance = CommonAlterController.appearance;
    
    alertControllerAppearance.alertButtonAttributes = @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#F77724"], NSFontAttributeName:UIFontMake(16),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertButtonDisabledAttributes = @{NSForegroundColorAttributeName:UIColorMake(129, 129, 129),NSFontAttributeName:UIFontMake(16),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertCancelButtonAttributes = @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#323233"], NSFontAttributeName:UIFontMake(16),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertDestructiveButtonAttributes = @{NSForegroundColorAttributeName:UIColorRed,NSFontAttributeName:UIFontMake(16),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertContentCornerRadius = 13;
    
    alertControllerAppearance.alertButtonHeight = 48;
    alertControllerAppearance.alertTitleMessageSpacing = 8;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(QMUIAlertControllerStyle)preferredStyle{
    
    if (self = [super initWithTitle:title message:message preferredStyle:preferredStyle]) {
        
        if(title){
            
            self.alertTitleAttributes = @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#323233"], NSFontAttributeName:UIFontMake(16),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:22 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
            self.alertMessageAttributes = @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#969799"], NSFontAttributeName:UIFontMake(14),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
        }
        else{
            
            self.alertMessageAttributes = @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#323233"], NSFontAttributeName:UIFontMake(16),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:22 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
        }
    }
    return self;
}

@end
