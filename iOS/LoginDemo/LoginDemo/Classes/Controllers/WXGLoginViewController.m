//
//  WXGLoginViewController.m
//  LoginDemo
//
//  Created by Nicholas Chow on 15/9/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGLoginViewController.h"
#import "WXGUserInfoViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface WXGLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger userId;

@end

@implementation WXGLoginViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

// resign the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)login {
    [self.view endEditing:YES];

    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if (username.length == 0 || password.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"username and password cannot be empty!" maskType:SVProgressHUDMaskTypeGradient];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *parameters = @{@"username" : username, @"password" : password};
    
    [self.manager POST:@"http://localhost:5000/login" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSInteger userId = 0;
        
        if (![responseObject[@"user_id"] isKindOfClass:[NSNull class]]) {
            userId = [responseObject[@"user_id"] integerValue];
        }
        
        if (!userId) {
            [SVProgressHUD showErrorWithStatus:@"your username or password is wrong!" maskType:SVProgressHUDMaskTypeGradient];
        } else {
            self.userId = userId;
            
            // save user_id
            [[NSUserDefaults standardUserDefaults] setObject:@(userId) forKey:@"userId"];
            
            // push to show user info
            [self performSegueWithIdentifier:@"userInfo" sender:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"server error!" maskType:SVProgressHUDMaskTypeGradient];
    }];
}

// deal with the return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self login];
    }
    return YES;
}

// pass the user_id
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"userInfo"]) {
        WXGUserInfoViewController *userInfoVC = segue.destinationViewController;
        userInfoVC.userId = self.userId;
    }
}

- (void)dealloc {
    [self.manager.operationQueue cancelAllOperations];
}

@end
