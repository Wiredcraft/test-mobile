//
//  ComnonArchitectureDelegateObject.m
//  YUIAll
//
//  Created by YUI on 2021/6/15.
//

#import "ComnonArchitectureDelegateObject.h"

@implementation ComnonArchitectureDelegateObject

- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{
    
    if(event && [event isKindOfClass:[NSDictionary class]]){
        
        if([[event allKeys]containsObject:@"name"] && [[event objectForKey:@"name"] isKindOfClass:[NSString class]]){
            
            NSMutableDictionary *eventDict = [NSMutableDictionary dictionaryWithDictionary:event];
            [eventDict addEntriesFromDictionary:@{@"view":view}];
            
            NSString *methodName = [event objectForKey:@"name"];
            [self performDynamicMethodWithName:methodName info:eventDict];
        }
    }
    else{
        
        return;
    }
}

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{
    
    if(info && [info isKindOfClass:[NSDictionary class]]){
        
        if([[info allKeys]containsObject:@"name"] && [[info objectForKey:@"name"] isKindOfClass:[NSString class]]){
            
            NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithDictionary:info];
            [infoDict addEntriesFromDictionary:@{@"viewModel":viewModel}];
            
            NSString *methodName = [info objectForKey:@"name"];
            [self performDynamicMethodWithName:methodName info:infoDict];
        }
    }
    else{
        
        return;
    }
}

- (void)viewManager:(id)viewManager withInfo:(NSDictionary *)info{
    
    if([[info allKeys]containsObject:@"name"] && [[info objectForKey:@"name"] isKindOfClass:[NSString class]]){
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithDictionary:info];
        [infoDict addEntriesFromDictionary:@{@"viewManager":viewManager}];
        
        NSString *methodName = [info objectForKey:@"name"];
        [self performDynamicMethodWithName:methodName info:infoDict];
    }
}

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if([[info allKeys]containsObject:@"name"] && [[info objectForKey:@"name"] isKindOfClass:[NSString class]]){
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithDictionary:info];
        [infoDict addEntriesFromDictionary:@{@"viewController":viewController}];
        
        NSString *methodName = [infoDict objectForKey:@"name"];
        [self performDynamicMethodWithName:methodName info:infoDict];
    }
}

- (void)performDynamicMethodWithName:(NSString *)name info:(NSDictionary *)info{
    
    NSString *methodName = name;
    SEL methodSelector1 = NSSelectorFromString(methodName);
    SEL methodSelector2 = NSSelectorFromString([NSString stringWithFormat:@"%@:",methodName]);
    
    if([self.delegate respondsToSelector:methodSelector2]){
        
        IMP imp = [self.delegate methodForSelector:methodSelector2];
        void (*func)(id, SEL, NSDictionary *) = (void *)imp;
        func(self.delegate, methodSelector2, info);
    }
    else if([self.delegate respondsToSelector:methodSelector1]){
        
        IMP imp = [self.delegate methodForSelector:methodSelector1];
        void (*func)(id, SEL) = (void *)imp;
        func(self.delegate, methodSelector1);
    }
}

@end
