//
//  XECheckUpdateView.m
//  i84zcc
//
//  Created by 小二 on 2019/9/18.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XECheckUpdateView.h"

static const CGFloat kUpdateBtnHeight = 45;
static const CGFloat kUpdateImgHeight = 255;

@interface XECheckUpdateView()
@property (nonatomic, strong) UIView *cheackView;
@property (nonatomic, strong) UIImageView *checkImgView;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *versionLb;
@property (nonatomic, strong) UILabel *desLb;
@property (nonatomic, strong) UIButton *updateBtn;

@end

@implementation XECheckUpdateView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self addSubview:self.cheackView];
    [self addSubview:self.checkImgView];
    [self addSubview:self.tipLb];
    [self addSubview:self.versionLb];
    [self addSubview:self.desLb];
    [self addSubview:self.updateBtn];
    
    [self.cheackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(280);
    }];
    
    [self.checkImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.cheackView);
        make.height.mas_equalTo(kUpdateImgHeight);
    }];
    
    [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cheackView);
        make.top.equalTo(self.checkImgView.mas_bottom).offset(6);
        make.width.equalTo(self.cheackView).multipliedBy(0.5);
        make.height.mas_equalTo(18);
    }];
    
    [self.versionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLb.mas_right).offset(3);
        make.centerY.equalTo(self.tipLb);
        make.height.equalTo(self.tipLb);
    }];
    
    [self.desLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cheackView).offset(35);
        make.right.equalTo(self.cheackView).offset(-35);
        make.top.equalTo(self.tipLb.mas_bottom).offset(11);
    }];
    
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cheackView).offset(30);
        make.right.equalTo(self.cheackView).offset(-30);
        make.top.equalTo(self.desLb.mas_bottom).offset(22);
        make.height.mas_equalTo(kUpdateBtnHeight);
        make.bottom.equalTo(self.cheackView).offset(-20);
    }];
}

- (void)reloadUpdateViewWithVersion:(NSString *)version {
    self.versionLb.text = [NSString stringWithFormat:@"  V%@  ",version];
}

#pragma mark - getter/setter
- (UIView *)cheackView {
    if (!_cheackView) {
        _cheackView = [[UIView alloc] init];
        _cheackView.backgroundColor = [UIColor whiteColor];
        _cheackView.layer.cornerRadius = 10.f;
        _cheackView.layer.masksToBounds = YES;
    }
    return _cheackView;
}

- (UIImageView *)checkImgView {
    if (!_checkImgView) {
        _checkImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"update_bgImage"]];
    }
    return _checkImgView;
}

- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [UILabel createLabelWithText:NSLocalizedString(@"Latest version", nil) textColor:[UIColor blackColor] font:kBoldFont(14) textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor]];
    }
    return _tipLb;
}

- (UILabel *)versionLb {
    if (!_versionLb) {
        NSString *versionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        _versionLb = [UILabel createLabelWithText:versionStr textColor:[UIColor whiteColor] font:kBoldFont(12) textAlignment:NSTextAlignmentLeft backgroundColor:kMainColor];
        _versionLb.layer.cornerRadius = 3.0;
        _versionLb.layer.masksToBounds = YES;
    }
    return _versionLb;
}

- (UILabel *)desLb {
    if (!_desLb) {
        _desLb = [UILabel createLabelWithText:NSLocalizedString(@"The updated version uses more features, experiences the new interface, responds faster, is more efficient, and has a better experience.", nil) textColor:kPaleColor font:kFont(12) textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor]];
        _desLb.numberOfLines = 0;
    }
    return _desLb;
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [UIButton createButtonWithTitle:NSLocalizedString(@"Update now", nil) titleColor:[UIColor whiteColor] textFont:kMediumFont(18) backgroundColor:kMainColor target:^(UIButton * _Nonnull sender) {
            !self.updateBlock ?: self.updateBlock();
        }];
        
        [_updateBtn setupCommonlyUsedShadow];
        _updateBtn.layer.cornerRadius = kUpdateBtnHeight/2;
    }
    return _updateBtn;
}

@end
