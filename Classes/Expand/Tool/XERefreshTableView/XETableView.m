//
//  XETableView.m
//  i84zcc
//
//  Created by 小二 on 2019/11/4.
//  Copyright © 2019 小二. All rights reserved.
//

#import "XETableView.h"
#import "MJRefresh.h"

@interface  XETableView()
/// 页数
@property (nonatomic, assign) NSInteger  page;
/// 每页大小
@property (nonatomic, assign) NSInteger  pageSize;

@end

@implementation XETableView

#pragma mark -- life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}

#pragma mark -- LSTableRefreshDelegate
///下拉刷新
- (void)pullDown {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(requestTableData:page:pageSize:)]) {
        self.page = 0;
        [self.refreshDelegate requestTableData:self page:self.page pageSize:self.pageSize];
    }
}

///上拉加载
- (void)pullUp {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(requestTableData:page:pageSize:)]) {
        self.page += self.pageCount;
        [self.refreshDelegate requestTableData:self page:self.page pageSize:self.pageSize];
    }
}

#pragma mark -- public method
///开始刷新
- (void)tableViewBeginRefresh {
    [self.mj_header beginRefreshing];
}

///刷新结束
- (void)tableViewEndRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

#pragma mark -- getter/setter
- (NSInteger)page {
    if (_page == 0) {
        return 0;
    }
    return _page;
}

- (NSInteger)pageSize {
    if (_pageSize == 0) {
        return 20;
    }
    return _pageSize;
}

- (void)setPageCount:(NSInteger)pageCount {
    [self tableViewEndRefresh];
    _pageCount = pageCount;
    
    if (pageCount < 20) {
        self.mj_footer = nil;
    } else {
        if (!self.mj_footer) {
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
        }
    }
}

@end

