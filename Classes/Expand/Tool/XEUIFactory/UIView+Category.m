//
//  UIView+Category.m
//  i84zcc
//
//  Created by 小二 on 2019/9/16.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)setupCommonlyUsedShadow {
    // 添加阴影
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = kMostlightTextColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 3.0;
}

@end
