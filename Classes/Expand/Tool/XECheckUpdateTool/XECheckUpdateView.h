//
//  XECheckUpdateView.h
//  i84zcc
//
//  Created by 小二 on 2019/9/18.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XECheckUpdateBlock)(void);

@interface XECheckUpdateView : UIView

@property (nonatomic, copy) XECheckUpdateBlock updateBlock;

- (void)reloadUpdateViewWithVersion:(NSString *)version;

@end

NS_ASSUME_NONNULL_END
