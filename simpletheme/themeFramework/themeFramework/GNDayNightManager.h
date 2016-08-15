//
//  GNDayNightManager.h
//  GameNews
//
//  Created by baidu on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GNDayNightManagerInstance [GNDayNightManager sharedInstance]

extern NSString * const GNDAYNIGHT_STATE_CHANGE;            //夜间<->日间模式切换通知

/**
 *  主题状态
 */
typedef NS_ENUM(NSUInteger, GNDayNightState) {
    GNDayNightInvalidState = 0, //error state
    GNDayNightDayState,         //日间主题
    GNDayNightNightState,       //夜间主题
};

/**
 *  按钮状态
 */
typedef NS_ENUM(NSUInteger, GNButtonImgType) {
    GNButtonImgNormalType,                      //按钮normal态
    GNButtonImgPressType,                       //按钮press态
};

@interface GNDayNightManager : UIImageView

@property (nonatomic, assign) GNDayNightState state;
@property (nonatomic, strong, getter=getThemePath) NSString *themePath;

/**
 *  获得主题管理单例
 *
 *  @return 主题单例
 */
+ (GNDayNightManager*)sharedInstance;

/**
 *  切换当前主题
 */
- (void)switchState;

/**
 *  设置当前主题状态
 *
 *  @param state (GNDayNightState)
 */
- (void)setState:(GNDayNightState)state;

/**
 *  通过iconID及状态(GNButtonImgType)获取图片name
 *
 *  @param iconID iconID
 *
 *  @return 图片name
 */
- (UIImage *)getImageWithIconID:(NSString *)iconID;

/**
 *  通过colorID获得当前主题对应的Color(16进制rgb)
 *
 *  @param colorID colorID
 *
 *  @return 16机制rgb
 */
- (int)getColorWithColorID:(NSString *)colorID;

@end
