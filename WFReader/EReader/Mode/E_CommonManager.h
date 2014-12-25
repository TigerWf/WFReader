//
//  E_CommonManager.h
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "E_ContantFile.h"
/**
 *  公共管理类
 */


@interface E_CommonManager : NSObject

+ (NSUInteger)Manager_getChapterBefore;

/**
 *  获得字号
 *
 *  @return 字号大小
 */
+ (NSUInteger)fontSize;


/**
 *  存储字号
 *
 *  @param fontSize 存储的字号大小
 */
+ (void)saveFontSize:(NSUInteger)fontSize;

@end
