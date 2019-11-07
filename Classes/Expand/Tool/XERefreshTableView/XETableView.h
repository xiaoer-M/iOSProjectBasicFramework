//
//  XETableView.h
//  i84zcc
//
//  Created by 小二 on 2019/11/4.
//  Copyright © 2019 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XETableView;

///刷新协议
@protocol XETableRefreshDelegate<NSObject>
@optional

/**
 表格请求
 返回pageCount，如果没有pageCount，则返回0
 
 @param tableView 当前表格
 @param page 请求的页数
 @param pageSize 页数大小
 
 */
- (void)requestTableData:(XETableView *)tableView page:(NSInteger)page pageSize:(NSInteger)pageSize;

@end

/// 封装上下拉刷新的表格
@interface XETableView : UITableView

/// 声明刷新协议
@property (nonatomic, weak) id<XETableRefreshDelegate> refreshDelegate;

/// 总页数
@property (nonatomic, assign) NSInteger  pageCount;


#pragma mark -- method
/**
 开始刷新
 */
- (void)tableViewBeginRefresh;

/**
 结束刷新
 */
- (void)tableViewEndRefresh;

@end


NS_ASSUME_NONNULL_END
