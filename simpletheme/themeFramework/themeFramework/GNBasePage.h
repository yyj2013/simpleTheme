//
//  GNBasePage.h
//  GameNews
//
//  Created by baidu on 16/5/9.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNBasePage : UIViewController

/**
 *  设置此值可以在日夜间切换时自动完成page backgroundColor切换
 */
@property (nonatomic, strong) NSString *dn_backgroundColorID;

/**
 *  日夜间状态变化时会回调此函数,子类复写去处理主题变化通知
 *
 *  @param state 主题状态
 */
- (void)onDayNightStateHasChange:(GNDayNightState) state;

@end
