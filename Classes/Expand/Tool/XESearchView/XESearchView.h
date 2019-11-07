//
//  XESearchView.h
//  i84zcc
//
//  Created by 小二 on 2019/9/11.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XESearchView;

@protocol XESearchViewDelegate <NSObject>
- (void)xe_searchView:(XESearchView *)searchView textDidChange:(NSString *)searchText;

@optional
- (void)xe_searchViewTextDidBeginEditing:(XESearchView *)searchView;
- (void)xe_searchViewTextDidEndEditing:(XESearchView *)searchView;
- (void)xe_searchViewCancelButtonClicked:(XESearchView *)searchView;

@end

@interface XESearchView : UIView
/** 代理 */
@property(nonatomic, weak) id <XESearchViewDelegate> delegate;
/** 取消按钮的显示隐藏 */
@property(nonatomic, assign) BOOL showsCancelButton;
/** 文字 */
@property(nonatomic, strong) NSString *text;
/** 占位文字 */
@property(nonatomic, strong) NSString *placeholder;

- (void)xe_becomeFirstResponder;
- (void)xe_resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
