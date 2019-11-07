//
//  NSString+Category.h
//  i84zcc
//
//  Created by 小二 on 2019/9/27.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

/**
 删除字符串中的空格

 @return 回调
 */
- (NSString *)removeWhitespace;

/**
 转化中文

 @return 回调
 */
- (NSString *)transformToChinese;


/**
 取首字母
 
 @return 回调
 */
- (NSString *)firstLetter;

@end

NS_ASSUME_NONNULL_END
