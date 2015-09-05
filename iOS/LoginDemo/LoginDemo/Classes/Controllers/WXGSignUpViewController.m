//
//  WXGSignUpViewController.m
//  LoginDemo
//
//  Created by Nicholas Chow on 15/9/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGSignUpViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface WXGSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation WXGSignUpViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)signUp {
    [self.view endEditing:YES];
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *name = self.nameField.text;
    NSString *email = self.emailField.text;
    
    if (username.length == 0 || password.length == 0 || name.length == 0 || email.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"username, password, name and email cannot be empty!" maskType:SVProgressHUDMaskTypeGradient];
        return;
    }
    
    if (![self validateEmail:email]) {
        [SVProgressHUD showErrorWithStatus:@"email format is incorrect!" maskType:SVProgressHUDMaskTypeGradient];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *parameters = @{@"username" : username, @"password" : password, @"name" : name, @"email" : email};
    
    [self.manager POST:@"http://localhost:5000/user/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSString *message = responseObject[@"message"];
        
        if ([message isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"singup successful!" maskType:SVProgressHUDMaskTypeGradient];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"server error!" maskType:SVProgressHUDMaskTypeGradient];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self.nameField becomeFirstResponder];
    } else if (textField == self.nameField) {
        [self.emailField becomeFirstResponder];
    } else if (textField == self.emailField) {
        [self signUp];
    }
    return YES;
}

- (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
