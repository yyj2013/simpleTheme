//
//  GNPlistHandle.h
//  baseframework
//
//  Created by csyyj on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNPlistHandle : NSObject

+ (NSDictionary *)handlePlistToDictWithResource:(NSString *)resource dir:(NSString *)dir;

@end
