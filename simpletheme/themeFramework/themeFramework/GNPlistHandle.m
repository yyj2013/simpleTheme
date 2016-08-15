//
//  GNPlistHandle.m
//  baseframework
//
//  Created by csyyj on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import "GNPlistHandle.h"

@implementation GNPlistHandle

+ (NSDictionary *)handlePlistToDictWithResource:(NSString *)resource dir:(NSString *)dir {
    NSString *configURLPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist" inDirectory:dir];
    if (configURLPath != nil && [[NSFileManager defaultManager] fileExistsAtPath:configURLPath]) {
        NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:configURLPath];
        return configDic;
    }
    return nil;
}

@end
