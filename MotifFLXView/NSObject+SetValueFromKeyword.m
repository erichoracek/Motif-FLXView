//
//  NSObject+SetValueFromKeyword.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/13/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;

#import "NSObject+SetValueFromKeyword.h"

@implementation NSObject (SetValueFromKeyword)

+ (void)mtf_registerThemeProperty:(NSString *)property forKey:(NSString *)key withValuesByKeyword:(NSDictionary *)valuesByKeyword {
    [self
        mtf_registerThemeProperty:property
        requiringValueOfClass:NSString.class
        applierBlock:^(NSString *keyword, id objectToTheme){
            NSNumber *value = valuesByKeyword[keyword];

            NSAssert(
                value != nil,
                @"Invalid %@ value: '%@', must be one of: %@.",
                key,
                keyword,
                [valuesByKeyword.allKeys componentsJoinedByString:@", "]);

            [objectToTheme setValue:value forKey:key];
        }];
}

@end
