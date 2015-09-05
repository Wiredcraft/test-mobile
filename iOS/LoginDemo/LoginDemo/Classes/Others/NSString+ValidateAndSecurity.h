//
//  NSString+ValidateAndSecurity.h
//  LoginDemo
//
//  Created by Nicholas Chow on 15/9/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ValidateAndSecurity)

+ (BOOL)validateEmail:(NSString *)email;

+ (NSString *)securityWithPassword:(NSString *)password;

@end
