//
//  WXGUserInfoViewController.m
//  LoginDemo
//
//  Created by Nicholas Chow on 15/9/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGUserInfoViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface WXGUserInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation WXGUserInfoViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    NSString *url = [NSString stringWithFormat:@"http://localhost:5000/user/%ld", self.userId];
    
    [self.manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", responseObject[@"user"][@"name"]];
        self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", responseObject[@"user"][@"email"]];
        self.dateLabel.text = [NSString stringWithFormat:@"Created at: %@", responseObject[@"user"][@"created_at"]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"server error" maskType:SVProgressHUDMaskTypeGradient];
    }];
}

- (IBAction)logout {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
