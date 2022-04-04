//
//  CommonPopupAlertController.m
//  YUIAll
//
//  Created by YUI on 2021/11/23.
//

#import "CommonPopupAlertController.h"

@interface CommonPopupAlertController ()

@end

@implementation CommonPopupAlertController

+ (instancetype)appearance {
    return [QMUIAppearance appearanceForClass:self];
}

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initAppearance];
    });
}

+(void)initAppearance{

    CommonPopupAlertController *alertControllerAppearance = CommonPopupAlertController.appearance;
    alertControllerAppearance.alertContentMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    alertControllerAppearance.alertContentMaximumWidth = 270;
    alertControllerAppearance.alertSeparatorColor = UIColorMake(211, 211, 219);
    alertControllerAppearance.alertTitleAttributes = @{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontBoldMake(17),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
    alertControllerAppearance.alertMessageAttributes = @{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
    alertControllerAppearance.alertButtonAttributes = @{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertButtonDisabledAttributes = @{NSForegroundColorAttributeName:UIColorMake(129, 129, 129),NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertCancelButtonAttributes = @{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontBoldMake(17),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertDestructiveButtonAttributes = @{NSForegroundColorAttributeName:UIColorRed,NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)};
    alertControllerAppearance.alertContentCornerRadius = 13;
    alertControllerAppearance.alertButtonHeight = 44;
    alertControllerAppearance.alertHeaderBackgroundColor = UIColorMakeWithRGBA(247, 247, 247, 1);
    alertControllerAppearance.alertButtonBackgroundColor = alertControllerAppearance.alertHeaderBackgroundColor;
    alertControllerAppearance.alertButtonHighlightBackgroundColor = UIColorMake(232, 232, 232);
    alertControllerAppearance.alertHeaderInsets = UIEdgeInsetsMake(20, 16, 20, 16);
    alertControllerAppearance.alertTitleMessageSpacing = 3;
    alertControllerAppearance.alertTextFieldFont = UIFontMake(14);
    alertControllerAppearance.alertTextFieldTextColor = UIColorBlack;
    alertControllerAppearance.alertTextFieldBorderColor = UIColorMake(210, 210, 210);
    alertControllerAppearance.alertTextFieldTextInsets = UIEdgeInsetsMake(4, 7, 4, 7);

    alertControllerAppearance.sheetContentMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    alertControllerAppearance.sheetContentMaximumWidth = [QMUIHelper screenSizeFor55Inch].width - UIEdgeInsetsGetHorizontalValue(alertControllerAppearance.sheetContentMargin);
    alertControllerAppearance.sheetSeparatorColor = UIColorMake(211, 211, 219);
    alertControllerAppearance.sheetTitleAttributes = @{NSForegroundColorAttributeName:UIColorMake(143, 143, 143),NSFontAttributeName:UIFontBoldMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
    alertControllerAppearance.sheetMessageAttributes = @{NSForegroundColorAttributeName:UIColorMake(143, 143, 143),NSFontAttributeName:UIFontMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
    alertControllerAppearance.sheetButtonAttributes = @{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)};
    alertControllerAppearance.sheetButtonDisabledAttributes = @{NSForegroundColorAttributeName:UIColorMake(129, 129, 129),NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)};
    alertControllerAppearance.sheetCancelButtonAttributes = @{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)};
    alertControllerAppearance.sheetDestructiveButtonAttributes = @{NSForegroundColorAttributeName:UIColorRed,NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)};
    alertControllerAppearance.sheetCancelButtonMarginTop = 8;
    alertControllerAppearance.sheetContentCornerRadius = 13;
    alertControllerAppearance.sheetButtonHeight = 57;
    alertControllerAppearance.sheetHeaderBackgroundColor = UIColorMakeWithRGBA(247, 247, 247, 1);
    alertControllerAppearance.sheetButtonBackgroundColor = alertControllerAppearance.sheetHeaderBackgroundColor;
    alertControllerAppearance.sheetButtonHighlightBackgroundColor = UIColorMake(232, 232, 232);
    alertControllerAppearance.sheetHeaderInsets = UIEdgeInsetsMake(16, 16, 16, 16);
    alertControllerAppearance.sheetTitleMessageSpacing = 8;
    alertControllerAppearance.sheetButtonColumnCount = 1;
    alertControllerAppearance.isExtendBottomLayout = NO;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(QMUIAlertControllerStyle)preferredStyle{
    
    if (self = [super initWithTitle:title message:message preferredStyle:preferredStyle]) {
        
        if(title){
            
            self.alertTitleAttributes = @{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontMake(16),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:22 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
            self.alertMessageAttributes = @{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontMake(14),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
        }
        else{
            self.alertMessageAttributes = @{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontMake(16),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:22 lineBreakMode:NSLineBreakByTruncatingTail textAlignment:NSTextAlignmentCenter]};
        }
    }
    return self;
}

@end
