//
//  UIView+DayNight.m
//  GameNews
//
//  Created by baidu on 16/5/27.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import "UIView+DayNight.h"
#import <objc/runtime.h>

static int gn_dn_backgroundColorId;     //backgroundColorID
static int gn_dn_isNeedThemeId;         //是否需要注册主题ID
static int gn_dn_isHasRegistNotifId;    //标识是否已经注册主题切换通知ID
static int gn_dn_themeChangeBlockId;    //主题切换blockID

@implementation UIView (DayNight)

/**
 *  交换dealloc函数，需要在dealloc之前remove通知
 */
+ (void)load {
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        //为了在dealloc之前去除theme通知，交换dealloc函数
        
        SEL originalDealloc = NSSelectorFromString(@"dealloc");
        SEL swizzledDealloc = @selector(gn_dealloc);
        
        Method origMethod = class_getInstanceMethod(class, originalDealloc);
        Method swizzMethod = class_getInstanceMethod(class, swizzledDealloc);
        
        method_exchangeImplementations(origMethod, swizzMethod);
    });
}

- (void)gn_dealloc {
    if (self.dn_isHasRegistNotif) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:GNDAYNIGHT_STATE_CHANGE object:nil];
    }
    [self gn_dealloc];
}

#pragma mark - add property

//为UIView提供基础的主题背景色设置
- (NSString *)dn_backgroundColorID {
    return objc_getAssociatedObject(self, &gn_dn_backgroundColorId);
}

- (void)setDn_backgroundColorID:(NSString *)colorID {
    objc_setAssociatedObject(self, &gn_dn_backgroundColorId, colorID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.dn_isNeedTheme = YES;
    [self setBackgroundColor:UIColorFromRGB([[GNDayNightManager sharedInstance] getColorWithColorID:colorID])];
}

//标识是否需要主题，当设置为需要主题时，注册 GNDAYNIGHT_STATE_CHANGE 主题切换通知
- (BOOL)dn_isNeedTheme {
    NSNumber *isNeedThemeNum = objc_getAssociatedObject(self, &gn_dn_isNeedThemeId);
    return [isNeedThemeNum boolValue];
}

- (void)setDn_isNeedTheme:(BOOL)dn_isNeedTheme {
    objc_setAssociatedObject(self, &gn_dn_isNeedThemeId, @(dn_isNeedTheme), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (dn_isNeedTheme && !self.dn_isHasRegistNotif) { //未注测过通知且需要主题通知，进行注册
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dn_onDayNightStateChange:) name:GNDAYNIGHT_STATE_CHANGE object:nil];
    } else if(!dn_isNeedTheme && self.dn_isHasRegistNotif){ //设置为不需要注册，且已经注册，则把通知移除
        [[NSNotificationCenter defaultCenter] removeObserver:self name:GNDAYNIGHT_STATE_CHANGE object:nil];
        self.dn_isHasRegistNotif = NO;
    }
    
}

//标识是否已经注册通知，防止dn_isNeedTheme被多次设置后导致同一个UIView注册多次通知
- (BOOL)dn_isHasRegistNotif {
    NSNumber *isHasReg = objc_getAssociatedObject(self, &gn_dn_isHasRegistNotifId);
    return [isHasReg boolValue];
}

- (void)setDn_isHasRegistNotif:(BOOL)dn_isHasRegistNotif {
    NSNumber *hasRegistNotif = @(dn_isHasRegistNotif);
    objc_setAssociatedObject(self, &gn_dn_isHasRegistNotifId, hasRegistNotif, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

//themeChangeBlock
- (UIViewDayNight_themeChangeBlock)dn_themeChangeBlock {
    return objc_getAssociatedObject(self, &gn_dn_themeChangeBlockId);
}

#pragma mark - public
- (void)dn_setThemeChangeBlock:(UIViewDayNight_themeChangeBlock)themeChangeBlock {
    if (themeChangeBlock) {
        self.dn_isNeedTheme = YES;
        objc_setAssociatedObject(self, &gn_dn_themeChangeBlockId, themeChangeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else {
        self.dn_isNeedTheme = NO;
    }
}

#pragma mark - callback
- (void)dn_onDayNightStateChange:(NSNotification*)notification {
    //处理backgroundColor
    if ([[self dn_backgroundColorID] length] > 0) {
        UIColor *backColor = UIColorFromRGB([[GNDayNightManager sharedInstance] getColorWithColorID:[self dn_backgroundColorID]]);
        [UIView animateWithDuration:0.25 animations:^{
           [self setBackgroundColor:backColor];
        }];
    }
    
    if ([self dn_themeChangeBlock]) {
        UIViewDayNight_themeChangeBlock block = [self dn_themeChangeBlock];
        block([GNDayNightManagerInstance state]);
    }
    
    //子类可以复写此方法
    [self dn_onDayNightStateHasChange:[[GNDayNightManager sharedInstance] state]];
}

- (void)dn_onDayNightStateHasChange:(GNDayNightState) state  {
    //子类按需实现
}


@end
