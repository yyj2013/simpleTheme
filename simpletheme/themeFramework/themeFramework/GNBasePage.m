//
//  GNBasePage.m
//  GameNews
//
//  Created by baidu on 16/5/9.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import "GNBasePage.h"

@interface GNBasePage ()

@end

@implementation GNBasePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.dn_backgroundColorID = @"normalPageBackColor";
    self.view.dn_backgroundColorID = @"normalPageBackColor";
    [self.view dn_setThemeChangeBlock:^(GNDayNightState state) {
        [self onDayNightStateChange:state];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    GNLog(@"Warning！！！！didReceiveMemoryWarning");
}

#pragma mark - 日夜间切换

/**
 *  主题切换回调，为防止子类没有调用super方法出现问题，公共事务在 (onDayNightStateChange:)处理
 *  而子类去复写 (onDayNightStateChange:)
 *
 *  @param state 主题状态
 */
- (void)onDayNightStateChange:(GNDayNightState)state {
    [self onDayNightStateHasChange:state];
    //做一些公共的事情
}

- (void)onDayNightStateHasChange:(GNDayNightState)state {
    
}

@end
