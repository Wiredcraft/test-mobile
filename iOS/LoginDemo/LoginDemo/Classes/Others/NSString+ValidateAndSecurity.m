//
//  NSString+ValidateAndSecurity.m
//  LoginDemo
//
//  Created by Nicholas Chow on 15/9/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "NSString+ValidateAndSecurity.h"
#import <CocoaSecurity.h>

@implementation NSString (ValidateAndSecurity)

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)securityWithPassword:(NSString *)password {
    return [[CocoaSecurity md5:[NSString stringWithFormat:@"python%@ios", password]] hexLower];
}

@end
