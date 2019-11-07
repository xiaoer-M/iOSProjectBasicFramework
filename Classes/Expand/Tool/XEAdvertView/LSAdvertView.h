//
//  LSAdvertView.h
//  ELaw
//
//  Created by 伪装者 on 2018/7/21.
//  Copyright © 2018年 xe. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface LSAdvertView : UIView

/**
 *  显示广告页面方法
 */
- (void)show;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  跳转链接
 */
@property (nonatomic, copy) NSString *pushUrl;

@end
