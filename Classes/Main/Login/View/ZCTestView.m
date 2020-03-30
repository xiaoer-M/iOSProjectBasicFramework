//
//  ZCTestView.m
//  i84zcc
//
//  Created by 小二 on 2020/3/30.
//  Copyright © 2020 小二. All rights reserved.
//

#import "ZCTestView.h"
#import "UIResponder+ZCRouter.h"

@interface ZCTestView()
@property (nonatomic, strong) UIButton *lsBtn;
@end


@implementation ZCTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _lsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lsBtn.frame = CGRectMake(0, 0, 50, 50);
    [_lsBtn setTitle:@"TEST" forState:UIControlStateNormal];
    [_lsBtn setBackgroundColor:[UIColor redColor]];
    [_lsBtn addTarget:self action:@selector(lsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lsBtn];
}

- (void)lsBtnAction:(UIButton *)sender {
    NSLog(@"%@",[self nextResponder]);
    [[self nextResponder] routerEventWithName:@"lsBtnAction" userInfo:nil];
}

@end
