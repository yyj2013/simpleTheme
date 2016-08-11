//
//  UIView+DayNight.h
//  GameNews
//
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDayNightManager.h"

/**
 *  主题切换block
 *
 *  @param state 当前主题状态(GNDayNightState)
 */
typedef void (^UIViewDayNight_themeChangeBlock)(GNDayNightState state);



/**
 *  对UIView进行扩展，支持主题切换时两种回调方式
 *  方式一: 子类重写dn_onDayNightStateHasChange:方法，该方法在主题变化时会被调用,注此方式需要主动设置self.dn_isNeedTheme=YES
 *  方式二: 注册block dn_setThemeChangeBlock:,主题变化时回调block
 */
@interface UIView (DayNight)

/**
 *  设置背景色的ID
 */
@property (nonatomic, strong) NSString *dn_backgroundColorID;

/**
 *  是否注册主题通知，YES == 注册主题通知，主题切换时 
 *  dn_onDayNightStateHasChange: 会被调用
 */
@property (nonatomic, assign) BOOL dn_isNeedTheme;


/**
 *  子类通过复写该方法来做主题切换相关操作(切换图片，改变颜色等)
 *
 *  @param state 主题状态
 */
- (void)dn_onDayNightStateHasChange:(GNDayNightState) state;

/**
 *  注册主题变化的block
 *
 *  @param themeChangeBlock 主题切换block
 */
- (void)dn_setThemeChangeBlock:(UIViewDayNight_themeChangeBlock)themeChangeBlock;

@end
