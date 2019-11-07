//
//  NSString+Category.m
//  i84zcc
//
//  Created by 小二 on 2019/9/27.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSString *)removeWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)transformToChinese {
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

- (NSString *)firstLetter {
    if (self.length > 0) {
        return [self substringToIndex:1];
    }
    return nil;
}


@end
