//
//  ZCLoginContentView.h
//  i84zcc
//
//  Created by 小二 on 2019/9/5.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZCLoginContentView;

@protocol ZCLoginContentViewDelegate <NSObject>
// 改变账号
- (void)contentView:(ZCLoginContentView *)view didChangeAccount:(NSString *)accountStr;
// 改变密码
- (void)contentView:(ZCLoginContentView *)view didChangePassword:(NSString *)passwordStr;
// 登录
- (void)contentView:(ZCLoginContentView *)view didSelectLoginBtn:(UIButton *)sender;

@end

@interface ZCLoginContentView : UIView

@property (nonatomic, weak) id<ZCLoginContentViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
