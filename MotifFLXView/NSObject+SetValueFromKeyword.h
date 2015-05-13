//
//  NSObject+SetValueFromKeyword.h
//  MotifFLXView
//
//  Created by Eric Horacek on 5/13/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Foundation;

@interface NSObject (SetValueFromKeyword)

+ (void)mtf_registerThemeProperty:(NSString *)property forKey:(NSString *)key withValuesByKeyword:(NSDictionary *)valuesByKeyword;

@end
